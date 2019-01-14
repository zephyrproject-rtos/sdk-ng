require recipes-devtools/gcc/gcc-common.inc

# Third digit in PV should be incremented after a minor release

PV = "6.x.arc"

# BINV should be incremented to a revision after a minor gcc release

BINV = "6.2.1"

FILESEXTRAPATHS =. "${FILE_DIRNAME}/gcc:${COREBASE}/meta/recipes-devtools/gcc/gcc-6.2:"

DEPENDS =+ "mpfr gmp libmpc zlib"
NATIVEDEPS = "mpfr-native gmp-native libmpc-native zlib-native"

LICENSE = "GPL-3.0-with-GCC-exception & GPLv3"

LIC_FILES_CHKSUM = "\
    file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552 \
    file://COPYING3;md5=d32239bcb673463ab874e80d47fae504 \
    file://COPYING3.LIB;md5=6a6a8e020838b23406c81b19c1d46df6 \
    file://COPYING.LIB;md5=2d5025d4aa3495befef8f17206a5b0a1 \
    file://COPYING.RUNTIME;md5=fe60d87048567d4fe8c8a0ed2448bcc8 \
"

# tag=arc-2016.09-release (no branch)
SRCREV="11f277e211411c21808cbb9f6cf165902edefea3"

SRC_URI = "\
    git://github.com/foss-for-synopsys-dwc-arc-processors/gcc.git;protocol=https;nobranch=1 \
    file://0036-libcc1-fix-libcc1-s-install-path-and-rpath.patch \
    file://0039-Fix-various-_FOR_BUILD-and-related-variables.patch \
    file://cbd8e54244cd02bdcf4f1057be3ce96631f35ac3.patch \
"

S = "${TMPDIR}/work-shared/gcc-${PV}-${PR}/git"
B = "${WORKDIR}/gcc-${PV}/build.${HOST_SYS}.${TARGET_SYS}"

# Language Overrides
FORTRAN = ""
JAVA = ""

LTO = "--enable-lto"

EXTRA_OECONF_BASE = "\
    ${LTO} \
    --enable-libssp \
    --disable-bootstrap \
    --disable-libmudflap \
    --with-system-zlib \
    --enable-linker-build-id \
    --with-ppl=no \
    --with-cloog=no \
    --enable-checking=release \
    --enable-cheaders=c_global \
"

EXTRA_OECONF_INITIAL = "\
    --disable-libmudflap \
    --disable-libgomp \
    --disable-libssp \
    --disable-libquadmath \
    --with-system-zlib \
    --disable-lto \
    --disable-plugin \
    --enable-decimal-float=no \
"

EXTRA_OECONF_INTERMEDIATE = "\
    --disable-libmudflap \
    --disable-libgomp \
    --disable-libquadmath \
    --with-system-zlib \
    --disable-lto \
    --disable-plugin \
    --disable-libssp \
"

EXTRA_OECONF_append_libc-uclibc = " --disable-decimal-float "

EXTRA_OECONF_append_arc = ' --with-pkgversion="ARCompact/ARCv2 ISA elf32 toolchain ${SRCREV}"'

EXTRA_OECONF_PATHS = "\
    --with-gxx-include-dir=${STAGING_DIR_TARGET}${target_includedir}/c++/${BINV} \
    --with-sysroot=${STAGING_DIR_TARGET} \
    --with-build-sysroot=${STAGING_DIR_TARGET} \
"

