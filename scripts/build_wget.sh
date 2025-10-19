#!/usr/bin/env bash

set -e

WGET_VERSION="1.25.0"

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
WGET_FLAGS=" \
  --with-ssl=openssl \
  --disable-pcre2 \
  "

if [ "${BUILD_HOST}" == "windows-x86_64" ]; then
  BUILD_PREFIX="${BUILD_OUTPUT}/wget"

  WGET_FLAGS+="--host=x86_64-w64-mingw32"
elif [[ "${BUILD_HOST}" =~ ^macos-.* ]]; then
  BUILD_PREFIX="${BUILD_OUTPUT}/opt/wget"

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
  export LIBIDN2_LIBS=" \
    ${HOMEBREW_PREFIX}/lib/libidn2.a \
    ${HOMEBREW_PREFIX}/lib/libunistring.a \
    "

  export OPENSSL_LIBS=" \
    ${HOMEBREW_PREFIX}/lib/libssl.a \
    ${HOMEBREW_PREFIX}/lib/libcrypto.a \
    "
else
  echo "ERROR: Invalid build host '${BUILD_HOST}'"
  exit 1
fi

# Download and extract wget source code
mkdir -p ${BUILD_SOURCE}
pushd ${BUILD_SOURCE}
wget -O wget.tar.gz https://ftp.gnu.org/gnu/wget/wget-${WGET_VERSION}.tar.gz
tar --strip-components=1 -xvf wget.tar.gz
popd

# Build wget
${BUILD_SOURCE}/configure \
  ${WGET_FLAGS} \
  --prefix="${BUILD_PREFIX}"

make -j
make install

# Install root CA certificates (Mozilla CA certificate store)
mkdir -p ${BUILD_PREFIX}/etc/ssl
wget \
  -O ${BUILD_PREFIX}/etc/ssl/cert.pem \
  https://curl.se/ca/cacert.pem

# Copy required dynamic-link libraries for Windows
if [ "${BUILD_HOST}" == "windows-x86_64" ]; then
  WGET_WIN_LIBS=" \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libcrypto-3-x64.dll \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libiconv-2.dll \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libidn2-0.dll \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libintl-8.dll \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libssl-3-x64.dll \
    /opt/mingw-w64-win32/x86_64-w64-mingw32/bin/libunistring-5.dll \
    "

  for l in ${WGET_WIN_LIBS}; do
    cp -f ${l} ${BUILD_PREFIX}/bin
  done
fi

# Symlink wget executable for macOS
if [[ "${BUILD_HOST}" =~ ^macos-.* ]]; then
  mkdir -p ${BUILD_OUTPUT}/usr/bin
  pushd ${BUILD_OUTPUT}/usr/bin

  ln -sf ../../opt/wget/bin/wget wget

  popd
fi
