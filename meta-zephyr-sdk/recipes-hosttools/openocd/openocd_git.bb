LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://LICENSES/preferred/GPL-2.0;md5=71ce3767d42ca42cd575f91c56eefe79"
DEPENDS = "hidapi libftdi"
RDEPENDS_${PN} = "libusb1 hidapi"

SRC_URI = " \
	gitsm://github.com/zephyrproject-rtos/openocd.git;protocol=https;nobranch=1 \
	"
SRCREV = "662bf274f881afa0aec2c21040eedb91146d8c4a"

S = "${WORKDIR}/git"

inherit pkgconfig autotools gettext

BBCLASSEXTEND += "nativesdk"

EXTRA_OECONF = "--enable-ftdi --enable-cmsis-dap --enable-jlink --enable-stlink --disable-doxygen-html --disable-git-update"

do_configure() {
    cd ${S}
    export ALL_PROXY="${ALL_PROXY}"
    export GIT_PROXY_COMMAND=${GIT_PROXY_COMMAND}
    ./bootstrap
    oe_runconf ${EXTRA_OECONF}
}

do_compile() {
    :
}

do_install() {
    cd ${S}
    oe_runmake DESTDIR=${D} install
    if [ -e "${D}${infodir}" ]; then
      rm -Rf ${D}${infodir}
    fi
    if [ -e "${D}${mandir}" ]; then
      rm -Rf ${D}${mandir}
    fi
    if [ -e "${D}${bindir}/.debug" ]; then
      rm -Rf ${D}${bindir}/.debug
    fi
}

