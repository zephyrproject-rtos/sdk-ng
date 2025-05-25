#!/usr/bin/env bash

# Script to mimic how CI is building llvm toolchain.

# Default is to use current directory as the working directory.
# SDK is under ${WORKING_ROOT_DIR}/sdk-ng/
# Build directory is ${WORKING_ROOT_DIR}/build-workspace/
WORKING_ROOT_DIR="${PWD}"
SDK_DIR="${WORKING_ROOT_DIR}/sdk-ng"
BUILD_DIR="${WORKING_ROOT_DIR}/build-workspace"

pushd "${BUILD_DIR}"
mkdir -p llvm-build
mkdir -p llvm

#TEST=echo
cd llvm-build
$TEST cmake \
    -GNinja \
    --install-prefix="${BUILD_DIR}"/llvm \
    -DLLVM_ENABLE_ZSTD=OFF \
    ${LLVM_CMAKE_ARGS} \
    "${SDK_DIR}"/scripts/llvm || exit 1

# Build LLVM toolchain
$TEST ninja llvm-toolchain || exit 1

# Run LLVM tests
$TEST ninja check-llvm-toolchain || exit 1

# Install LLVM toolchain
$TEST ninja install-llvm-toolchain || exit 1
popd
