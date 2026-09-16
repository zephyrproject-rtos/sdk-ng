#!/usr/bin/env bash

set -e

usage()
{
  echo "Usage: $(basename $0) host source output"
}

# Validate and parse arguments
if [ "$1" == "" ]; then
  usage
  echo
  echo "host must be specified."
  exit 1
elif [ "$2" == "" ]; then
  usage
  echo
  echo "source must be specified."
  exit 1
elif [ "$3" == "" ]; then
  usage
  echo
  echo "output must be specified."
  exit 1
fi

BUILD_HOST="$1"
BUILD_SOURCE="$2"
BUILD_OUTPUT="$3"

# Set build parameters
QEMU_TARGETS=" \
  xtensa-softmmu \
  riscv32-softmmu \
"

# Espressif documents --enable-debug and --enable-sdl for local development
# builds (https://github.com/espressif/esp-toolchain-docs/tree/main/qemu).
# Neither is shipped here: debug instrumentation is inappropriate for a
# released host tool, and the SDK runs headless ('-nographic'). Start from the
# deterministic baseline used by Espressif's own CI and enable only what the
# Espressif machines need.
QEMU_FLAGS=" \
  --bindir=bin \
  --disable-debug-info \
  --disable-docs \
  --disable-strip \
  --disable-user \
  --disable-werror \
  --enable-gcrypt \
  --enable-pixman \
  --enable-slirp \
  --with-suffix= \
  --without-default-features \
"

if [ "${BUILD_HOST}" == "windows-x86_64" ]; then
  BUILD_PREFIX="${BUILD_OUTPUT}/qemu-espressif"

  # Set MinGW-w64 cross toolchain prefix
  QEMU_FLAGS+=" --cross-prefix=x86_64-w64-mingw32-"

  # The bundled libslirp wrap (4.7) is a MinGW DLL-exporting library. Linking
  # the static archive against QEMU objects that use dllimport fails with
  # unresolved __imp_slirp_*. Build the wrap as a shared library instead and
  # ship the DLL next to the emulators.
  MESON_EXTRA_ARGS="-Dslirp:default_library=shared"

  # Specify statically linked libraries. Only small runtime libraries are
  # statically linked for now to reduce the overall QEMU binary size.
  export LDFLAGS=" \
    -l:libssp.a \
    -l:libwinpthread.a \
    "
elif [[ "${BUILD_HOST}" =~ ^macos-.* ]]; then
  BUILD_PREFIX="${BUILD_OUTPUT}/opt/qemu-espressif"
  QEMU_FLAGS+=" --enable-fdt=internal"

  case ${BUILD_HOST} in
    macos-aarch64)
      HOMEBREW_PREFIX="/opt/homebrew"
      ;;
    macos-x86_64)
      HOMEBREW_PREFIX="/usr/local"
      ;;
  esac

  # Ensure that arch-specific Homebrew environment is configured
  eval $(${HOMEBREW_PREFIX}/bin/brew shellenv)

  # Specify statically linked libraries and their dependencies
  export LDFLAGS=" \
    ${HOMEBREW_PREFIX}/lib/libgcrypt.a \
    ${HOMEBREW_PREFIX}/lib/libgio-2.0.a \
    ${HOMEBREW_PREFIX}/lib/libglib-2.0.a \
    ${HOMEBREW_PREFIX}/lib/libgmodule-2.0.a \
    ${HOMEBREW_PREFIX}/lib/libgmp.a \
    ${HOMEBREW_PREFIX}/lib/libgobject-2.0.a \
    ${HOMEBREW_PREFIX}/lib/libgpg-error.a \
    ${HOMEBREW_PREFIX}/lib/libintl.a \
    ${HOMEBREW_PREFIX}/lib/libjpeg.a \
    ${HOMEBREW_PREFIX}/lib/libpcre2-8.a \
    ${HOMEBREW_PREFIX}/lib/libpixman-1.a \
    ${HOMEBREW_PREFIX}/lib/libpng.a \
    ${HOMEBREW_PREFIX}/lib/libslirp.a \
    ${HOMEBREW_PREFIX}/lib/libzstd.a \
    ${HOMEBREW_PREFIX}/opt/libffi/lib/libffi.a \
    -framework AppKit \
    -framework CoreServices \
    -framework Foundation \
    -liconv \
    -lresolv \
    -lz \
    "
else
  echo "ERROR: Invalid build host '${BUILD_HOST}'"
  exit 1
fi

if [ "${BUILD_HOST}" == "windows-x86_64" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  SLIRP_PATCH="${SCRIPT_DIR}/../meta-zephyr-sdk/recipes-devtools/qemu_espressif/files/0003-meson-windows-shared-libslirp.patch"
  patch -p1 -d "${BUILD_SOURCE}" < "${SLIRP_PATCH}"
fi

# Configure QEMU
${BUILD_SOURCE}/configure \
  ${QEMU_FLAGS} \
  --target-list="${QEMU_TARGETS}" \
  --prefix="${BUILD_PREFIX}" \
  ${MESON_EXTRA_ARGS:-}

# Build and install QEMU
if [ "${BUILD_HOST}" == "windows-x86_64" ]; then
  # Default ninja 'all' also links libslirp wrap tests; only ship the two
  # emulators used by Zephyr. make install then fills install-only files
  # (e.g. trace/trace-events-all) without rebuilding the wrap tests.
  make -j qemu-system-xtensa.exe qemu-system-riscv32.exe
else
  make -j
fi
make install

# Copy required dynamic-link libraries for Windows
if [ "${BUILD_HOST}" == "windows-x86_64" ]; then
  QEMU_WIN_LIBS=" \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libgcrypt-20.dll \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libgpg-error-0.dll \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libiconv-2.dll \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libintl-8.dll \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libjpeg-8.dll \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libpixman-1-0.dll \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/lib/libgcc_s_seh-1.dll \
    "

  for l in ${QEMU_WIN_LIBS}; do
    cp -f "${l}" ${BUILD_PREFIX}/bin
  done

  # Wrap-built slirp is installed as libslirp-0.dll next to the emulators.
  slirp_dll=""
  for f in "${BUILD_PREFIX}/bin"/libslirp*.dll; do
    if [ -f "${f}" ]; then
      slirp_dll="${f}"
      break
    fi
  done
  if [ -z "${slirp_dll}" ]; then
    slirp_dll="$(find . -name 'libslirp*.dll' -print -quit)"
    if [ -z "${slirp_dll}" ]; then
      echo "ERROR: libslirp DLL was not produced" >&2
      exit 1
    fi
    cp -f "${slirp_dll}" ${BUILD_PREFIX}/bin
  fi

  # Namespaced copies so find_program() does not collide with stock QEMU
  cp -f ${BUILD_PREFIX}/bin/qemu-system-xtensa.exe \
        ${BUILD_PREFIX}/bin/qemu-system-espressif-xtensa.exe
  cp -f ${BUILD_PREFIX}/bin/qemu-system-riscv32.exe \
        ${BUILD_PREFIX}/bin/qemu-system-espressif-riscv32.exe
  rm -f ${BUILD_PREFIX}/bin/qemu-system-xtensa.exe
  rm -f ${BUILD_PREFIX}/bin/qemu-system-riscv32.exe
fi

# Symlink namespaced QEMU executables for macOS (do not overwrite usr/bin
# qemu-system-xtensa / qemu-system-riscv32 from the main QEMU tree)
if [[ "${BUILD_HOST}" =~ ^macos-.* ]]; then
  mkdir -p ${BUILD_OUTPUT}/usr/bin
  pushd ${BUILD_OUTPUT}/usr/bin

  ln -sf ../../opt/qemu-espressif/bin/qemu-system-xtensa \
        qemu-system-espressif-xtensa
  ln -sf ../../opt/qemu-espressif/bin/qemu-system-riscv32 \
        qemu-system-espressif-riscv32

  popd
fi
