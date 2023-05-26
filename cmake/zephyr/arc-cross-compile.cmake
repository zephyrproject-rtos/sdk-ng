# SPDX-License-Identifier: Apache-2.0

# ARC uses the same source tree for both ARCv2 & ARCv3 architectures,
# while toolchain differ significantly and so their cross-compile prefixes
if(CONFIG_ISA_ARCV3)
  set(CROSS_COMPILE_TARGET_arc       arc64-zephyr-elf)
else()
  set(CROSS_COMPILE_TARGET_arc         arc-zephyr-elf)
endif()
