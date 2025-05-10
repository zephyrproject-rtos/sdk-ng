# SPDX-License-Identifier: Apache-2.0

if(CONFIG_ARM64)
  # Legacy target to support Zephyr versions before the ARM/ARM64 split
  set(CROSS_COMPILE_TARGET_arm         aarch64-zephyr-elf)
else()
  set(CROSS_COMPILE_TARGET_arm         arm-zephyr-eabi)
endif()
set(CROSS_COMPILE_TARGET_arm64   aarch64-zephyr-elf)
set(CROSS_COMPILE_TARGET_riscv   riscv64-zephyr-elf)
set(CROSS_COMPILE_TARGET_mips       mips-zephyr-elf)
set(CROSS_COMPILE_TARGET_rx           rx-zephyr-elf)
set(CROSS_COMPILE_TARGET_microblaze microblazeel-zephyr-elf)
set(CROSS_COMPILE_TARGET_xtensa   xtensa-${SOC_TOOLCHAIN_NAME}_zephyr-elf)

# ARC uses the same source tree for both ARCv2 & ARCv3 architectures,
# while toolchain differ significantly and so their cross-compile prefixes
if(CONFIG_ISA_ARCV3)
set(CROSS_COMPILE_TARGET_arc       arc64-zephyr-elf)
else()
set(CROSS_COMPILE_TARGET_arc         arc-zephyr-elf)
endif()
set(CROSS_COMPILE_TARGET_x86      x86_64-zephyr-elf)
set(CROSS_COMPILE_TARGET_sparc     sparc-zephyr-elf)

set(CROSS_COMPILE_TARGET ${CROSS_COMPILE_TARGET_${ARCH}})
set(SYSROOT_TARGET       ${CROSS_COMPILE_TARGET})

set(SYSROOT_DIR   ${ZEPHYR_SDK_INSTALL_DIR}/${SYSROOT_TARGET}/${SYSROOT_TARGET})
set(CROSS_COMPILE ${ZEPHYR_SDK_INSTALL_DIR}/${CROSS_COMPILE_TARGET}/bin/${CROSS_COMPILE_TARGET}-)

if("${ARCH}" STREQUAL "x86")
  if(CONFIG_X86_64)
    list(APPEND TOOLCHAIN_C_FLAGS -m64)
    list(APPEND TOOLCHAIN_LD_FLAGS -m64)
  else()
    list(APPEND TOOLCHAIN_C_FLAGS -m32)
    list(APPEND TOOLCHAIN_LD_FLAGS -m32)
  endif()
endif()
