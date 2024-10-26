# SPDX-License-Identifier: Apache-2.0

set(LLVM_TOOLCHAIN_PATH ${ZEPHYR_SDK_INSTALL_DIR}/llvm)

set(TOOLCHAIN_HOME ${ZEPHYR_SDK_INSTALL_DIR}/llvm/bin)

set(COMPILER clang)
set(LINKER lld)
set(BINTOOLS llvm)

set(TOOLCHAIN_HAS_PICOLIBC ON CACHE BOOL "True if toolchain supports picolibc")
set(TOOLCHAIN_HAS_LIBCXX ON CACHE BOOL "True if toolchain supports libc++")
