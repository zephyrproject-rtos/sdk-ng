#/usr/bin/env bash

set -e

usage()
{
  echo "Usage: $(basename $0) host source prefix"
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
  echo "prefix must be specified."
  exit 1
fi

BUILD_HOST="$1"
BUILD_SOURCE="$2"
BUILD_PREFIX="$3"

# Set build parameters
QEMU_TARGETS=" \
  aarch64-softmmu \
  arm-softmmu \
  i386-softmmu \
  or1k-softmmu \
  mips-softmmu \
  mipsel-softmmu \
  riscv32-softmmu \
  riscv64-softmmu \
  rx-softmmu \
  sparc-softmmu \
  x86_64-softmmu \
  xtensa-softmmu \
"

QEMU_FLAGS=" \
  --disable-docs \
  --disable-sdl \
  --disable-gtk \
  --disable-debug-info \
  --disable-cap-ng \
  --disable-libnfs \
  --disable-libusb \
  --disable-libiscsi \
  --disable-usb-redir \
  --disable-linux-aio \
  --disable-guest-agent \
  --disable-libssh \
  --disable-vnc \
  --disable-kvm \
  --disable-seccomp \
  --disable-tpm \
  --disable-numa \
  --disable-glusterfs \
  --disable-virtfs \
  --disable-xen \
  --disable-curl \
  --disable-attr \
  --disable-curses \
  --disable-iconv \
  --disable-parallels \
  --disable-replication \
  --disable-dmg
"

if [ "${BUILD_HOST}" == "windows-x86_64" ]; then
  QEMU_FLAGS+="--cross-prefix=x86_64-w64-mingw32-"
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
    /usr/x86_64-w64-mingw32/sys-root/mingw/bin/iconv.dll \
    /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libffi-6.dll \
    /usr/lib/gcc/x86_64-w64-mingw32/7.3-win32/libgcc_s_seh-1.dll \
    /usr/lib/gcc/x86_64-w64-mingw32/7.3-win32/libssp-0.dll \
    /usr/lib/gcc/x86_64-w64-mingw32/7.3-win32/libstdc++-6.dll \
    /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libgio-2.0-0.dll \
    /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libglib-2.0-0.dll \
    /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libgmodule-2.0-0.dll \
    /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libgobject-2.0-0.dll \
    /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libintl-8.dll \
    /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libpcre-1.dll \
    /usr/x86_64-w64-mingw32/sys-root/mingw/bin/libpixman-1-0.dll \
    /usr/x86_64-w64-mingw32/sys-root/mingw/bin/zlib1.dll \
    /usr/x86_64-w64-mingw32/lib/libwinpthread-1.dll \
  "

  for l in ${QEMU_WIN_LIBS}; do
    cp -f ${l} ${BUILD_PREFIX}
  done
fi
