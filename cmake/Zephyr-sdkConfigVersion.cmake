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
  # SDK 1.0 is not backward compatible with older SDK releases. When Zephyr
  # looks for an SDK version less than 1.0, this declares incompatibility to
  # prevent older incompatible Zephyr releases from picking up SDK 1.0.
  set(ZEPHYR_SDK_MINIMUM_COMPATIBLE_VERSION 1.0)
  if(PACKAGE_FIND_VERSION VERSION_LESS ZEPHYR_SDK_MINIMUM_COMPATIBLE_VERSION)
    set(PACKAGE_VERSION_COMPATIBLE FALSE)
    return()
  else()
    set(PACKAGE_VERSION_COMPATIBLE TRUE)
  endif()

  if(PACKAGE_FIND_VERSION STREQUAL PACKAGE_VERSION)
    set(PACKAGE_VERSION_EXACT TRUE)
  endif()
endif()
