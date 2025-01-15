# SPDX-License-Identifier: Apache-2.0

# This file provides Zephyr sdk config package version information.
#
# The purpose of the version file is to ensure that CMake find_package can
# correctly locate the Zephyr sdk installation for building of applications.

file(READ ${CMAKE_CURRENT_LIST_DIR}/../sdk_version SDK_VERSION)
string(STRIP ${SDK_VERSION} PACKAGE_VERSION)

if(PACKAGE_VERSION VERSION_LESS PACKAGE_FIND_VERSION)
  set(PACKAGE_VERSION_COMPATIBLE FALSE)
else()
  # This Zephyr SDK will not work with Zephyr projects requiring Zephyr SDK <0.18.x
  set(ZEPHYR_SDK_MINIMUM_COMPATIBLE_VERSION 0.18)
  if(PACKAGE_FIND_VERSION VERSION_LESS ZEPHYR_SDK_MINIMUM_COMPATIBLE_VERSION)
    set(PACKAGE_VERSION_COMPATIBLE FALSE)
    return()
  endif()

  # Basic validation if user requests 'zephyr-gnu' ('zephyr') or 'zephyr-llvm'.
  # We must ensure gcc is available, likewise with clang.
  if(ZEPHYR_TOOLCHAIN_VARIANT STREQUAL "zephyr-gnu" OR ZEPHYR_TOOLCHAIN_VARIANT STREQUAL "zephyr")
    file(GLOB has_gnu "${CMAKE_CURRENT_LIST_DIR}/../gnu/*/bin/*zephyr-*-gcc")
    if(NOT has_gnu)
      set(PACKAGE_VERSION_COMPATIBLE FALSE)
      return()
    endif()
  elseif(ZEPHYR_TOOLCHAIN_VARIANT STREQUAL "zephyr-llvm")
    if(NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/../llvm/bin/clang")
      set(PACKAGE_VERSION_COMPATIBLE FALSE)
      return()
    endif()
  endif()

  set(PACKAGE_VERSION_COMPATIBLE TRUE)
  if(PACKAGE_FIND_VERSION STREQUAL PACKAGE_VERSION)
    set(PACKAGE_VERSION_EXACT TRUE)
  endif()
endif()
