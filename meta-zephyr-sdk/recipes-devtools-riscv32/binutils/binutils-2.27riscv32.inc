LIC_FILES_CHKSUM = "\
    file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552\
    file://COPYING.LIB;md5=9f604d8a4f8e74f4f5140845a21b6674\
    file://COPYING3;md5=d32239bcb673463ab874e80d47fae504\
    file://COPYING3.LIB;md5=6a6a8e020838b23406c81b19c1d46df6\
    file://gas/COPYING;md5=d32239bcb673463ab874e80d47fae504\
    file://include/COPYING;md5=59530bdf33659b29e73d4adb9f9f6552\
    file://include/COPYING3;md5=d32239bcb673463ab874e80d47fae504\
    file://libiberty/COPYING.LIB;md5=a916467b91076e631dd8edb7424769c7\
    file://bfd/COPYING;md5=d32239bcb673463ab874e80d47fae504\
    "

COMPATIBLE_MACHINE = "riscv32"

def binutils_branch_version(d):
    pvsplit = d.getVar('PV', True).split('.')
    return pvsplit[0] + "_" + pvsplit[1]

BINUPV = "${@binutils_branch_version(d)}"

PV = "2.27+gitriscv32"

SRCREV = "1d307f86616a965df6f3c6a2c4a5ecaae42b9d13"

SRC_URI = "\
    git://github.com/riscv/riscv-binutils-gdb.git;protocol=https;branch=__archive__ \
    file://add-old-eret-opcode.patch \
    "

S  = "${WORKDIR}/git"

do_configure_prepend () {
    rm -rf ${S}/gdb ${S}/libdecnumber ${S}/readline ${S}/sim
}

CONFIG_SHELL = "/bin/bash"

sysroot_stage_all_append() {
    sysroot_stage_dir ${D}${exec_prefix}/extlib ${SYSROOT_DESTDIR}${exec_prefix}/extlib
}
