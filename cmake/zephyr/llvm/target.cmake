# SPDX-License-Identifier: Apache-2.0

if("${ARCH}" STREQUAL "arm")
  if(DEFINED CONFIG_ARMV8_M_MAINLINE)
    # ARMv8-M mainline is ARMv7-M with additional features from ARMv8-M.
    set(triple armv8m.main-none-eabi)
  elseif(DEFINED CONFIG_ARMV8_M_BASELINE)
    # ARMv8-M baseline is ARMv6-M with additional features from ARMv8-M.
    set(triple armv8m.base-none-eabi)
  elseif(DEFINED CONFIG_ARMV7_M_ARMV8_M_MAINLINE)
    # ARMV7_M_ARMV8_M_MAINLINE means that ARMv7-M or backward compatible ARMv8-M
    # processor is used.
    set(triple armv7m-none-eabi)
  elseif(DEFINED CONFIG_ARMV6_M_ARMV8_M_BASELINE)
    # ARMV6_M_ARMV8_M_BASELINE means that ARMv6-M or ARMv8-M supporting the
    # Baseline implementation processor is used.
    set(triple armv6m-none-eabi)
  else()
    # Default ARM target supported by all processors.
    set(triple arm-none-eabi)
  endif()
elseif("${ARCH}" STREQUAL "arm64")
  set(triple aarch64-none-elf)
elseif("${ARCH}" STREQUAL "riscv")
  if(CONFIG_64BIT)
    set(triple riscv64-none-elf)
  else()
    set(triple riscv32-none-elf)
  endif()
endif()

if(DEFINED triple)
  set(CMAKE_C_COMPILER_TARGET   ${triple})
  set(CMAKE_ASM_COMPILER_TARGET ${triple})
  set(CMAKE_CXX_COMPILER_TARGET ${triple})

  unset(triple)
endif()

list(APPEND TOOLCHAIN_C_FLAGS --config
	${ZEPHYR_SDK_INSTALL_DIR}/cmake/zephyr/llvm/clang_compiler_rt.cfg)
list(APPEND TOOLCHAIN_LD_FLAGS --config
	${ZEPHYR_SDK_INSTALL_DIR}/cmake/zephyr/llvm/clang_compiler_rt.cfg)
