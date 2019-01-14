require recipes-devtools-riscv32/gcc/gcc-6.x.riscv32.inc
require recipes-devtools/gcc/gcc-cross.inc

DEPENDS_remove_libc-baremetal := "virtual/${TARGET_PREFIX}libc-for-gcc"
EXTRA_OECONF_append_libc-baremetal = " --without-headers"
EXTRA_OECONF_remove_libc-baremetal = "--with-sysroot=/not/exist"
EXTRA_OECONF_remove_libc-baremetal = "--enable-threads=posix"

COMPATIBLE_MACHINE = "riscv"

BBCLASSEXTEND = "nativesdk"
