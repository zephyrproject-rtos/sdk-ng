require recipes-devtools/binutils/binutils.inc
require recipes-devtools-riscv32/binutils/binutils-2.27riscv32.inc
require recipes-devtools/binutils/binutils-cross-canadian.inc

do_install_append () {
    rm -f ${D}/${libdir}/../lib/libiberty*
}
