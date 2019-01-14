SUMMARY = "Xtensa compile/runtime HAL"
DESCRIPTION = "Xtensa compile/runtime HAL"

LICENSE = "MIT"
SECTION = "libs"
ALLOW_EMPTY_${PN} = "1"
do_patch[depends] += "xtensa-config:do_populate_sysroot"
#
# Drop these dependencies, otherwise xtensa-hal gets built with wrong compiler
# and fails at configuration step.
#
DEPENDS_remove = "virtual/libc virtual/${TARGET_PREFIX}compilerlibs gcc-runtime"

EXTRA_OECONF = "--host=${TARGET_SYS} \
		--prefix=${prefix}"

do_configure () {
    ${S}/configure ${EXTRA_OECONF}
}

do_install () {
    oe_runmake 'DESTDIR=${D}' install
}

python do_patch_prepend_xtensa () {
    os.system( d.getVar('S', True) + '/import-core.sh ' + d.getVar('STAGING_DIR_TARGET', True) + '/usr/src/xtensa-config/xtensa-build.tgz' )
}

PV = "RF-2015.2"
LIC_FILES_CHKSUM = "file://LICENSE;md5=db7d6b1e19d5108cef2fc957704f261d"

SRC_URI = "https://github.com/foss-xtensa/xtensa-hal/archive/RF-2015.2.tar.gz"
SRC_URI[md5sum] = "2ef7e9e8628c53b2d26eacd6a65e70c8"
