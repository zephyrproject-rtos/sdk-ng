# SPDX-License-Identifier: Apache-2.0
#
# Copyright (c) 2022, Nordic Semiconductor ASA

# FindZephyr-sdk_HostTools module for locating HostTools components in Zephyr SDK.
#
# The module defines the following variables:
#
# 'HOST_TOOLS_HOME'
# Path to host tools home if installed.
# Set to 'HOST_TOOLS_HOME-NOTFOUND' if not installed.
#
# 'Zephyr-sdk_HostTools_FOUND', 'ZEPHYR-SDK_HOSTTOOLS_FOUND'
#  True if the host tools are found.

cmake_host_system_information(RESULT TOOLCHAIN_ARCH QUERY OS_PLATFORM)
set(HOST_TOOLS_HOME ${ZEPHYR_SDK_INSTALL_DIR}/sysroots/${TOOLCHAIN_ARCH}-pokysdk-linux)
if(NOT EXISTS ${HOST_TOOLS_HOME})
  set(HOST_TOOLS_HOME_MISSING ${HOST_TOOLS_HOME})
  set(HOST_TOOLS_HOME HOST_TOOLS_HOME-NOTFOUND)
endif()

find_package_handle_standard_args(Zephyr-sdk_HostTools
                                  REQUIRED_VARS HOST_TOOLS_HOME ${HOST_TOOLS_HOME_MISSING}
                                  VERSION_VAR   Zephyr-sdk_VERSION
)

if(Zephyr-sdk_HostTools_FOUND)
  # Path used for searching by the find_*() functions, with appropriate
  # suffixes added. Ensures that the SDK's host tools will be found when
  # we call, e.g. find_program(QEMU qemu-system-x86)
  list(APPEND CMAKE_PREFIX_PATH ${HOST_TOOLS_HOME}/usr)

  # TODO: Use find_* somehow for these as well?
  set_ifndef(QEMU_BIOS            ${HOST_TOOLS_HOME}/usr/share/qemu)
  set_ifndef(OPENOCD_DEFAULT_PATH ${HOST_TOOLS_HOME}/usr/share/openocd/scripts)
endif()
