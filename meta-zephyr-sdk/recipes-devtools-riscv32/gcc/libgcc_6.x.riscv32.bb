require recipes-devtools-riscv32/gcc/gcc-6.x.riscv32.inc
require recipes-devtools/gcc/libgcc.inc

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
COMPATIBLE_MACHINE = "riscv32"

# Until we support 'elf64-littleriscv' we need to disable multilib
EXTRA_OECONF_remove_riscv32 = "--enable-multilib"
EXTRA_OECONF_append_riscv32 = " --disable-multilib"

