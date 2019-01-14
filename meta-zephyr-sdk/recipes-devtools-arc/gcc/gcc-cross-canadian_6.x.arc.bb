require recipes-devtools-arc/gcc/gcc-${PV}.inc
require recipes-devtools/gcc/gcc-cross-canadian.inc

EXTRA_OECONF_append_libc-baremetal = " --without-headers"
EXTRA_OECONF_remove_libc-baremetal = "--with-sysroot=/not/exist"
EXTRA_OECONF_remove_libc-baremetal = "--with-build-sysroot=${STAGING_DIR_TARGET}"
EXTRA_OECONF_append_libc-baremetal = " --enable-plugin "

