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

if(ZEPHYR_TOOLCHAIN_VARIANT STREQUAL "zephyr")
  set(ZEPHYR_TOOLCHAIN_VARIANT "zephyr-gnu")
endif()

if(NOT DEFINED ZEPHYR_TOOLCHAIN_VARIANT)
  file(GLOB use_gnu "${ZEPHYR_SDK_INSTALL_DIR}/gnu/*/bin/*zephyr-*-gcc")
  if(use_gnu)
    set(ZEPHYR_TOOLCHAIN_VARIANT zephyr-gnu)
  elseif(EXISTS "${ZEPHYR_SDK_INSTALL_DIR}/llvm/bin/clang")
    set(ZEPHYR_TOOLCHAIN_VARIANT zephyr-llvm)
  else()
    # We are in a Zephyr-sdk but gnu nor llvm was properly detected.
    # Warn the user and set toolchain to zephyr-gnu.
    message(WARNING
      "Zephyr SDK found in ${ZEPHYR_SDK_INSTALL_DIR} but gcc nor clang was properly detected.\n"
      "Please check you Zephyr SDK installation. Defaulting to 'zephyr-gnu'"
    )
    set(ZEPHYR_TOOLCHAIN_VARIANT zephyr-gnu)
  endif()
endif()

# Those are CMake package parameters.
set(Zephyr-sdk_FOUND True)
set(Zephyr-sdk_DIR   ${ZEPHYR_SDK_INSTALL_DIR})
