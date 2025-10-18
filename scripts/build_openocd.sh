#!/usr/bin/env bash

set -e

LIBUSB_VERSION="1.0.29"
HIDAPI_VERSION="0.15.0"
LIBFTDI_VERSION="1.4"

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
BUILD_SYSROOT="${PWD}/sysroot"

# Set build parameters
OPENOCD_FLAGS=" \
  --enable-ftdi \
  --enable-cmsis-dap \
  --enable-jlink \
  --enable-stlink \
  --disable-doxygen-html \
  --disable-git-update \
  --disable-werror \
  "

if [ "${BUILD_HOST}" == "windows-x86_64" ]; then
  BUILD_PREFIX="${BUILD_OUTPUT}/openocd"

  OPENOCD_FLAGS+="--host=x86_64-w64-mingw32"
elif [[ "${BUILD_HOST}" =~ ^macos-.* ]]; then
  BUILD_PREFIX="${BUILD_OUTPUT}/opt/openocd"

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

  # Make pkg-config look for the libraries from the build sysroot
  export PKG_CONFIG_PATH="${BUILD_SYSROOT}/lib/pkgconfig"

  # Specify statically linked libraries and their dependencies
  export LDFLAGS=" \
    -framework CoreFoundation \
    -framework IOKit \
    -framework Security \
    "

  # Build static libraries required by OpenOCD. These libraries are manually
  # built because the corresponding Homebrew packages do not provide usable
  # static libraries.

  ## libusb
  wget https://github.com/libusb/libusb/releases/download/v${LIBUSB_VERSION}/libusb-${LIBUSB_VERSION}.tar.bz2
  tar xvf libusb-${LIBUSB_VERSION}.tar.bz2
  mkdir build-libusb
  pushd build-libusb
  ../libusb-${LIBUSB_VERSION}/configure \
    --prefix=${BUILD_SYSROOT} \
    --enable-static \
    --disable-shared
  make -j
  make install
  popd

  ## hidapi
  wget https://github.com/libusb/hidapi/archive/refs/tags/hidapi-${HIDAPI_VERSION}.tar.gz
  tar xvf hidapi-${HIDAPI_VERSION}.tar.gz
  mkdir build-hidapi
  pushd build-hidapi
  cmake \
    -DCMAKE_INSTALL_PREFIX=${BUILD_SYSROOT} \
    -DBUILD_SHARED_LIBS=OFF \
    ../hidapi-hidapi-${HIDAPI_VERSION}
  cmake --build .
  cmake --install .
  popd

  ## libftdi
  wget https://www.intra2net.com/en/developer/libftdi/download/libftdi1-${LIBFTDI_VERSION}.tar.bz2
  tar xvf libftdi1-${LIBFTDI_VERSION}.tar.bz2
  mkdir build-libftdi
  pushd build-libftdi
  cmake \
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
    -DCMAKE_PREFIX_PATH=${BUILD_SYSROOT} \
    -DCMAKE_INSTALL_PREFIX=${BUILD_SYSROOT} \
    -DCMAKE_DISABLE_FIND_PACKAGE_Boost=ON \
    -DSTATICLIBS=ON \
    -DBUILD_TESTS=OFF \
    -DDOCUMENTATION=OFF \
    ../libftdi1-${LIBFTDI_VERSION}
  cmake --build .
  cmake --install .
  rm -f ${BUILD_SYSROOT}/lib/libftdi*.dylib
  popd
else
  echo "ERROR: Invalid build host '${BUILD_HOST}'"
  exit 1
fi

# Build OpenOCD
pushd ${BUILD_SOURCE}
./bootstrap
popd

mkdir build-openocd
pushd build-openocd

${BUILD_SOURCE}/configure \
  ${OPENOCD_FLAGS} \
  --prefix="${BUILD_PREFIX}"

make -j
make install

popd

# Copy required dynamic-link libraries for Windows
if [ "${BUILD_HOST}" == "windows-x86_64" ]; then
  OPENOCD_WIN_LIBS=" \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libftdi1.dll \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libhidapi.dll \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libusb-1.0.dll \
    "

  for l in ${OPENOCD_WIN_LIBS}; do
    cp -f ${l} ${BUILD_PREFIX}/bin
  done
fi

# Symlink OpenOCD executable for macOS
if [[ "${BUILD_HOST}" =~ ^macos-.* ]]; then
  mkdir -p ${BUILD_OUTPUT}/usr/bin
  pushd ${BUILD_OUTPUT}/usr/bin

  ln -sf ../../opt/openocd/bin/openocd openocd

  popd
fi
