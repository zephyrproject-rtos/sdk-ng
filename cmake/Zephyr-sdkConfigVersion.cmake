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
  # Currently, this Zephyr SDK is expected to work with any Zephyr project
  # requiring this version or any older version.
  #
  # In case this version of Zephyr SDK is no longer backwards compatible with
  # previous versions of Zephyr SDK, this is the place to test if the caller
  # requested an older (incompatible) revision.
  # For example, imagine caller requests Zephyr SDK v0.10, and this Zephyr SDK
  # is revision v0.11, then the below snippet can be activated to ensure that
  # this Zephyr SDK (v0.11) is marked as not compatible if caller requested an
  # older version, like v0.10
  # set(ZEPHYR_SDK_MINIMUM_COMPATIBLE_VERSION 0.11)
  # if(PACKAGE_FIND_VERSION VERSION_LESS ZEPHYR_SDK_MINIMUM_COMPATIBLE_VERSION)
  #   set(PACKAGE_VERSION_COMPATIBLE FALSE)
  #   return()
  # endif()

  set(PACKAGE_VERSION_COMPATIBLE TRUE)
  if(PACKAGE_FIND_VERSION STREQUAL PACKAGE_VERSION)
    set(PACKAGE_VERSION_EXACT TRUE)
  endif()
endif()
