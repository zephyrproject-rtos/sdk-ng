# SPDX-License-Identifier: Apache-2.0

cmake_host_system_information(RESULT TOOLCHAIN_ARCH QUERY OS_PLATFORM)

if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL Linux)
  # For Linux SDK, host tool components are built using Yocto and placed into
  # the Poky sysroot.  The host tool directory layout follows the standard UNIX
  # filesystem hierarchy.
  set(HOST_TOOLS_HOME ${ZEPHYR_SDK_INSTALL_DIR}/hosttools/sysroots/${TOOLCHAIN_ARCH}-pokysdk-linux)

  # Path used for searching by the find_*() functions, with appropriate
  # suffixes added. Ensures that the SDK's host tools will be found when
  # we call, e.g. find_program(QEMU qemu-system-x86)
  list(APPEND CMAKE_PREFIX_PATH ${HOST_TOOLS_HOME}/usr)

  set_ifndef(QEMU_BIOS            ${HOST_TOOLS_HOME}/usr/share/qemu)
  set_ifndef(OPENOCD_DEFAULT_PATH ${HOST_TOOLS_HOME}/usr/share/openocd/scripts)
elseif(${CMAKE_HOST_SYSTEM_NAME} STREQUAL Darwin)
  # For macOS SDK, each host tool component is placed in its own directory under
  # the 'opt' directory, with all executable binaries symlinked to 'usr/bin'
  # directory.
  set(HOST_TOOLS_HOME ${ZEPHYR_SDK_INSTALL_DIR}/hosttools)

  # Make executable symlinks under 'usr/bin' directory discoverable by the
  # find_*() functions.
  list(APPEND CMAKE_PREFIX_PATH ${HOST_TOOLS_HOME}/usr)

  set_ifndef(QEMU_BIOS            ${HOST_TOOLS_HOME}/opt/qemu/share/qemu)
  set_ifndef(OPENOCD_DEFAULT_PATH ${HOST_TOOLS_HOME}/opt/openocd/share/openocd/scripts)
elseif(${CMAKE_HOST_SYSTEM_NAME} STREQUAL Windows)
  # For Windows SDK, each host tool component is placed in its own directory
  # under the host tools home directory.
  set(HOST_TOOLS_HOME ${ZEPHYR_SDK_INSTALL_DIR}/hosttools)

  # Add host tool component binary directories to the prefix paths for
  # discovery by the find_program() function.
  list(APPEND CMAKE_PREFIX_PATH ${HOST_TOOLS_HOME}/qemu)
  list(APPEND CMAKE_PREFIX_PATH ${HOST_TOOLS_HOME}/qemu-arc)
  list(APPEND CMAKE_PREFIX_PATH ${HOST_TOOLS_HOME}/openocd)

  set_ifndef(QEMU_BIOS            ${HOST_TOOLS_HOME}/qemu/share)
  set_ifndef(OPENOCD_DEFAULT_PATH ${HOST_TOOLS_HOME}/openocd/share/openocd/scripts)
endif()
