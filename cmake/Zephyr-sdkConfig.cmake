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
set(ZEPHYR_TOOLCHAIN_VARIANT zephyr)

# Load additional components. Only components inside Zephyr SDK are allowed.
set(CURRENT_CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH})
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
foreach(component ${Zephyr-sdk_FIND_COMPONENTS})
  find_package(Zephyr-sdk_${component})
endforeach()
set(CMAKE_MODULE_PATH ${CURRENT_CMAKE_MODULE_PATH})

# Those are CMake package parameters.
set(Zephyr-sdk_FOUND True)
set(Zephyr-sdk_DIR   ${ZEPHYR_SDK_INSTALL_DIR})
