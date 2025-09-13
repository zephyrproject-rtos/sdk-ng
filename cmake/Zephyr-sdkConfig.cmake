# SPDX-License-Identifier: Apache-2.0

# This file provides Zephyr sdk config version package functionality.
#

# Those are Zephyr variables used.
set(SDK_VERSION ${Zephyr-sdk_VERSION})
set(SDK_MAJOR_MINOR ${Zephyr-sdk_VERSION_MAJOR}.${Zephyr-sdk_VERSION_MINOR})
set(SDK_VERSION ${Zephyr-sdk_VERSION_MAJOR}.${Zephyr-sdk_VERSION_MINOR}.${Zephyr-sdk_VERSION_PATCH})
set(SDK_MAJOR_MINOR_MICRO ${SDK_VERSION})

get_filename_component(ZEPHYR_SDK_INSTALL_DIR ${CMAKE_CURRENT_LIST_DIR}/.. ABSOLUTE)
set(ZEPHYR_SDK_INSTALL_DIR ${ZEPHYR_SDK_INSTALL_DIR})

# Check and see if the user specified a toolchain
if(DEFINED ZEPHYR_TOOLCHAIN_VARIANT)
  # Check and see if the specified toolchain includes a compiler
  if(ZEPHYR_TOOLCHAIN_VARIANT MATCHES "^([^/])+/([^/]+)$")
    # Replace any existing values with the provided components
    set(ZEPHYR_TOOLCHAIN_VARIANT "${CMAKE_MATCH_1}" CACHE STRING "toolchain" FORCE)
    set(TOOLCHAIN_VARIANT_COMPILER "${CMAKE_MATCH_2}" CACHE STRING "compiler" FORCE)
  endif()
else()
  set(ZEPHYR_TOOLCHAIN_VARIANT "zephyr")
endif()

# When using the Zephyr SDK, use the gnu compiler by default
if(ZEPHYR_TOOLCHAIN_VARIANT STREQUAL "zephyr" AND NOT DEFINED TOOLCHAIN_VARIANT_COMPILER)
  set(TOOLCHAIN_VARIANT_COMPILER "gnu")
endif()

set(ENV{ZEPHYR_TOOLCHAIN_VARIANT} "${ZEPHYR_TOOLCHAIN_VARIANT}")
set(ENV{TOOLCHAIN_VARIANT_COMPILER} "${TOOLCHAIN_VARIANT_COMPILER}")

# Those are CMake package parameters.
set(Zephyr-sdk_FOUND True)
set(Zephyr-sdk_DIR   ${ZEPHYR_SDK_INSTALL_DIR})
