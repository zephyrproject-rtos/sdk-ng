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
  aarch64-softmmu \
  arm-softmmu \
  i386-softmmu \
  mips-softmmu \
  mipsel-softmmu \
  or1k-softmmu \
  riscv32-softmmu \
  riscv64-softmmu \
  rx-softmmu \
  sparc-softmmu \
  x86_64-softmmu \
  xtensa-softmmu \
"

QEMU_FLAGS=" \
  --disable-attr \
  --disable-cap-ng \
  --disable-curl \
  --disable-curses \
  --disable-debug-info \
  --disable-dmg
  --disable-docs \
  --disable-glusterfs \
  --disable-gnutls \
  --disable-gtk \
  --disable-guest-agent \
  --disable-iconv \
  --disable-kvm \
  --disable-libiscsi \
  --disable-libnfs \
  --disable-libssh \
  --disable-libusb \
  --disable-linux-aio \
  --disable-nettle \
  --disable-numa \
  --disable-parallels \
  --disable-replication \
  --disable-sdl \
  --disable-seccomp \
  --disable-selinux \
  --disable-tpm \
  --disable-usb-redir \
  --disable-virtfs \
  --disable-xen \
  --enable-gcrypt \
  --enable-png \
  --enable-vnc \
  --enable-vnc-jpeg \
"

if [ "${BUILD_HOST}" == "windows-x86_64" ]; then
  BUILD_PREFIX="${BUILD_OUTPUT}/qemu"

  # Set MinGW-w64 cross toolchain prefix
  QEMU_FLAGS+="--cross-prefix=x86_64-w64-mingw32-"

  # Specify statically linked libraries. Only small runtime libraries are
  # statically linked for now to reduce the overall QEMU binary size.
  export LDFLAGS=" \
    -l:libssp.a \
    -l:libwinpthread.a \
    "
elif [[ "${BUILD_HOST}" =~ ^macos-.* ]]; then
  BUILD_PREFIX="${BUILD_OUTPUT}/opt/qemu"

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

# Configure QEMU
${BUILD_SOURCE}/configure \
  ${QEMU_FLAGS} \
  --target-list="${QEMU_TARGETS}" \
  --prefix="${BUILD_PREFIX}"

# Build QEMU
make -j

# Install QEMU
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
    "

  for l in ${QEMU_WIN_LIBS}; do
    cp -f ${l} ${BUILD_PREFIX}
  done
fi

# Symlink QEMU executables for macOS
if [[ "${BUILD_HOST}" =~ ^macos-.* ]]; then
  mkdir -p ${BUILD_OUTPUT}/usr/bin
  pushd ${BUILD_OUTPUT}/usr/bin

  ln -sf ../../opt/qemu/bin/qemu-edid qemu-edid
  ln -sf ../../opt/qemu/bin/qemu-img qemu-img
  ln -sf ../../opt/qemu/bin/qemu-io qemu-io
  ln -sf ../../opt/qemu/bin/qemu-nbd qemu-nbd
  ln -sf ../../opt/qemu/bin/qemu-storage-daemon qemu-storage-daemon
  ln -sf ../../opt/qemu/bin/qemu-system-aarch64 qemu-system-aarch64
  ln -sf ../../opt/qemu/bin/qemu-system-arm qemu-system-arm
  ln -sf ../../opt/qemu/bin/qemu-system-i386 qemu-system-i386
  ln -sf ../../opt/qemu/bin/qemu-system-mips qemu-system-mips
  ln -sf ../../opt/qemu/bin/qemu-system-mipsel qemu-system-mipsel
  ln -sf ../../opt/qemu/bin/qemu-system-or1k qemu-system-or1k
  ln -sf ../../opt/qemu/bin/qemu-system-riscv32 qemu-system-riscv32
  ln -sf ../../opt/qemu/bin/qemu-system-riscv64 qemu-system-riscv64
  ln -sf ../../opt/qemu/bin/qemu-system-rx qemu-system-rx
  ln -sf ../../opt/qemu/bin/qemu-system-sparc qemu-system-sparc
  ln -sf ../../opt/qemu/bin/qemu-system-x86_64 qemu-system-x86_64
  ln -sf ../../opt/qemu/bin/qemu-system-xtensa qemu-system-xtensa

  popd
fi
