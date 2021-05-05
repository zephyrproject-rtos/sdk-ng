# SPDX-License-Identifier: Apache-2.0

if(CONFIG_ARM64)
  # Legacy target to support Zephyr versions before the ARM/ARM64 split
  set(CROSS_COMPILE_TARGET_arm         aarch64-zephyr-elf)
else()
  set(CROSS_COMPILE_TARGET_arm         arm-zephyr-eabi)
endif()
set(CROSS_COMPILE_TARGET_arm64   aarch64-zephyr-elf)
set(CROSS_COMPILE_TARGET_nios2     nios2-zephyr-elf)
set(CROSS_COMPILE_TARGET_riscv   riscv64-zephyr-elf)
set(CROSS_COMPILE_TARGET_mips       mips-zephyr-elf)
set(CROSS_COMPILE_TARGET_xtensa   xtensa-zephyr-elf)

# ARC uses the same source tree for both ARCv2 & ARCv3 architectures,
# while toolchain differ significantly and so their cross-compile prefixes
if(CONFIG_ISA_ARCV3 AND CONFIG_64BIT)
set(CROSS_COMPILE_TARGET_arc       arc64-zephyr-elf)
else()
set(CROSS_COMPILE_TARGET_arc         arc-zephyr-elf)
endif()
set(CROSS_COMPILE_TARGET_x86      x86_64-zephyr-elf)
set(CROSS_COMPILE_TARGET_sparc     sparc-zephyr-elf)

set(CROSS_COMPILE_TARGET ${CROSS_COMPILE_TARGET_${ARCH}})
set(SYSROOT_TARGET       ${CROSS_COMPILE_TARGET})

if("${ARCH}" STREQUAL "xtensa")
  set(SYSROOT_DIR ${TOOLCHAIN_HOME}/xtensa/${SOC_TOOLCHAIN_NAME}/${SYSROOT_TARGET})
  set(CROSS_COMPILE ${TOOLCHAIN_HOME}/xtensa/${SOC_TOOLCHAIN_NAME}/${CROSS_COMPILE_TARGET}/bin/${CROSS_COMPILE_TARGET}-)
else()
  set(SYSROOT_DIR   ${TOOLCHAIN_HOME}/${SYSROOT_TARGET}/${SYSROOT_TARGET})
  set(CROSS_COMPILE ${TOOLCHAIN_HOME}/${CROSS_COMPILE_TARGET}/bin/${CROSS_COMPILE_TARGET}-)
endif()

if("${ARCH}" STREQUAL "x86")
  if(CONFIG_X86_64)
    list(APPEND TOOLCHAIN_C_FLAGS -m64)
    list(APPEND TOOLCHAIN_LD_FLAGS -m64)
  else()
    list(APPEND TOOLCHAIN_C_FLAGS -m32)
    list(APPEND TOOLCHAIN_LD_FLAGS -m32)
  endif()
endif()
