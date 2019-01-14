########################################################################
#
# ARC specific
#
########################################################################
LIC_FILES_CHKSUM_arc = "file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552 \
                    file://COPYING3.LIB;md5=6a6a8e020838b23406c81b19c1d46df6 \
                    file://COPYING3;md5=d32239bcb673463ab874e80d47fae504 \
                    file://COPYING.LIB;md5=9f604d8a4f8e74f4f5140845a21b6674 \
                    file://COPYING.NEWLIB;md5=fced02ba02d66f274d4847d27e80af74 \
                    file://newlib/libc/posix/COPYRIGHT;md5=103468ff1982be840fdf4ee9f8b51bbf \
                    file://newlib/libc/sys/linux/linuxthreads/LICENSE;md5=73640207fbc79b198c7ffd4ad4d97aa0"

#Tag arc-2016.03
SRCREV_arc = "e4da0f88abe8dd2a0b947bcf7cb8b3736ab94f33"
SRC_URI_arc = "git://github.com/foss-for-synopsys-dwc-arc-processors/newlib.git;branch=arc-2.3"
SRC_URI_arc += "file://assert-fiprintf.patch"
S_arc  = "${WORKDIR}/git"

EXTRA_OECONF_append_arc = " --enable-multilib "
TUNE_CCARGS_arc := " -nostdlib -mno-sdata "

# ERROR: QA Issue: Architecture did not match (195 to 93)
INSANE_SKIP_${PN}_arc += " arch "
INSANE_SKIP_${PN}_arc += " staticdev "

########################################################################
#
# XTENSA specific
#
########################################################################
PV_xtensa = "2.2.0"
FILESEXTRAPATHS_prepend_xtensa := "${THISDIR}/${PN}:"
LIC_FILES_CHKSUM_xtensa = "file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552 \
                    file://COPYING3.LIB;md5=6a6a8e020838b23406c81b19c1d46df6 \
                    file://COPYING3;md5=d32239bcb673463ab874e80d47fae504 \
                    file://COPYING.LIB;md5=9f604d8a4f8e74f4f5140845a21b6674 \
                    file://COPYING.NEWLIB;md5=3e3652588619359190b26489933b4334 \
                    file://newlib/libc/posix/COPYRIGHT;md5=103468ff1982be840fdf4ee9f8b51bbf \
                    file://newlib/libc/sys/linux/linuxthreads/LICENSE;md5=73640207fbc79b198c7ffd4ad4d97aa0"

SRC_URI_xtensa = "git://github.com/jcmvbkbc/newlib-xtensa.git;protocol=https;branch=xtensa"

SRCREV_xtensa = "b06f1b57cdf0c6dbe20caaca2da0f78004d71ec4"
SRC_URI_xtensa += "file://assert-fiprintf.patch"
S_xtensa = "${WORKDIR}/git"

# XTENSA specific settings
TUNE_CCARGS_xtensa := " -nostdlib"

# Copy newlib overlay files into the source tree before applying patches.
# There's no overlay when building for other architectures, so don't do
# anything if there are no files to copy.

python do_patch_prepend_xtensa () {
    os.system('tar -xf ' + d.getVar('STAGING_DIR_TARGET', True) +
              '/usr/src/xtensa-config/xtensa-overlay.tar.gz --strip-components=1 -C ' +
              d.getVar('S', True) + ' newlib')
}

do_patch[depends] += "xtensa-config:do_populate_sysroot"

########################################################################
#
# RISC-V specific
#
########################################################################
PV_riscv32 = "2.2.0"

LIC_FILES_CHKSUM_riscv32 = "file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552 \
                    file://COPYING3.LIB;md5=6a6a8e020838b23406c81b19c1d46df6 \
                    file://COPYING3;md5=d32239bcb673463ab874e80d47fae504 \
                    file://COPYING.LIB;md5=9f604d8a4f8e74f4f5140845a21b6674 \
                    file://COPYING.NEWLIB;md5=27039641b800547bbcea82a8a5b707ad \
                    file://newlib/libc/posix/COPYRIGHT;md5=103468ff1982be840fdf4ee9f8b51bbf \
                    file://newlib/libc/sys/linux/linuxthreads/LICENSE;md5=73640207fbc79b198c7ffd4ad4d97aa0"

SRC_URI_riscv32 = "git://github.com/riscv/riscv-newlib.git;protocol=https;branch=riscv-newlib-2.2.0"
SRC_URI_riscv32 += "file://riscv32-newlib.patch"
SRC_URI_riscv32 += "file://assert-fiprintf.patch"
SRC_URI_riscv32 += "file://riscv32-config.sub.patch"

SRCREV_riscv32 = "77f0072999addb5d5b5c551baec21565aaf3a9e0"
S_riscv32 = "${WORKDIR}/git"

EXTRA_OECONF_append_riscv32 = " --disable-multilib "

# RISC-V specific settings
TUNE_CCARGS_riscv32 := " -nostdlib"
