HOMEPAGE = "https://sourceware.org/newlib/"
SUMMARY = "C library for embedded systems"
DESCRIPTION = "Newlib is a conglomeration of several library parts, all under free software licenses that make them easily usable on embedded products."

PV = "2.4.0"

LICENSE = "GPLv2 & LGPLv3 & GPLv3 & LGPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=59530bdf33659b29e73d4adb9f9f6552 \
                    file://COPYING3.LIB;md5=6a6a8e020838b23406c81b19c1d46df6 \
                    file://COPYING3;md5=d32239bcb673463ab874e80d47fae504 \
                    file://COPYING.LIBGLOSS;md5=73f5c98779aea7dba4a6c94a74ab0ae2 \
                    file://COPYING.LIB;md5=2d5025d4aa3495befef8f17206a5b0a1 \
                    file://COPYING.NEWLIB;md5=fced02ba02d66f274d4847d27e80af74 \
                    file://newlib/libc/posix/COPYRIGHT;md5=103468ff1982be840fdf4ee9f8b51bbf \
                    file://newlib/libc/sys/linux/linuxthreads/LICENSE;md5=73640207fbc79b198c7ffd4ad4d97aa0"

SRC_URI = "ftp://sourceware.org/pub/newlib/newlib-${PV}.tar.gz"
SRC_URI[md5sum] = "37c07a65c6effdb4822fb6f83067f37e"
SRC_URI[sha256sum] = "545b3d235e350d2c61491df8b9f775b1b972f191380db8f52ec0b1c829c52706"
SRC_URI += "file://gettimeofday-header-fix.patch"
SRC_URI += "file://assert-fiprintf.patch"
SRC_URI += "file://iamcu-commit-5d3ad3b.patch"

S = "${WORKDIR}/newlib-${PV}"

DEPENDS = "flex-native bison-native m4-native"
DEPENDS_remove = "virtual/libc virtual/${TARGET_PREFIX}compilerlibs"
PACKAGES = "${PN}"

# x86 specific settings
TUNE_CCARGS_x86 := " -nostdlib"

# MIPS specific settings
TUNE_CCARGS_mips := "-nostdlib"

# ARM specific settings
TUNE_CCARGS_arm := "-nostdlib"

# NIOS2 specific settings
TUNE_CCARGS_nios2 := " -nostdlib"

# IAMCU specific settings
TUNE_CCARGS_iamcu := " -nostdlib -miamcu -m32"

# This will determine the name of the folder with libc as well.
NEWLIB_HOST = "${TARGET_SYS}"

CFLAGS += " -DMISSING_SYSCALL_NAMES "

# Specify any options you want to pass to the configure script using EXTRA_OECONF:
EXTRA_OECONF = " --enable-languages=c \
    --host=${NEWLIB_HOST} \
    --with-newlib --with-gnu-as --with-gnu-ld -v \
    --disable-newlib-supplied-syscalls \
    --disable-newlib-wide-orient \
    --disable-newlib-fseek-optimization \
    --enable-newlib-nano-formatted-io \
    --enable-newlib-nano-malloc \
    --disable-newlib-fvwrite-in-streamio \
    --disable-newlib-unbuf-stream-opt --enable-lite-exit \
    --enable-newlib-global-atexit \
"

do_configure () {
    # If we're being rebuilt due to a dependency change, we need to make sure
    # everything is clean before we configure and build -- if we haven't previously
    # built this will fail and be ignored.
    make distclean || :
    export CC_FOR_TARGET="${CC}"
    ${S}/configure ${EXTRA_OECONF}
}

do_install () {
    oe_runmake 'DESTDIR=${D}' install

    # Delete standards.info, configure.info
    rm -rf ${D}/usr/share/
    # Place the libraries where gcc can find them
    # usr/${NEWLIB_HOST}/lib -> usr/lib
    # usr/${NEWLIB_HOST}/include ->usr/include

    mv -v ${D}/usr/local/${NEWLIB_HOST}/lib* ${D}/usr/lib
    mv -v ${D}/usr/local/${NEWLIB_HOST}/include* ${D}/usr/include
    rm -rf ${D}/usr/local/${NEWLIB_HOST}
    rm -rf ${D}/usr/local
}

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"

FILES_${PN} = "/usr/lib /usr/include"

INSANE_SKIP_${PN} += " staticdev"
INSANE_SKIP_${PN}-dev += " staticdev"

