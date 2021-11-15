LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://LICENSES/preferred/GPL-2.0;md5=71ce3767d42ca42cd575f91c56eefe79"
DEPENDS = "libusb-compat hidapi libftdi"
RDEPENDS_${PN} = "libusb1 hidapi"

# The various arc files are based on the commit e781e73a39bc5c845b73dc96b751d867278a7583
# of https://github.com/foss-for-synopsys-dwc-arc-processors/openocd

SRC_URI = " \
	git://github.com/zephyrproject-rtos/openocd.git;protocol=https;nobranch=1 \
	"
SRCREV = "7e3dbbbe231903ca25e7f7a5a782a34111ccc8bd"

S = "${WORKDIR}/git"

inherit pkgconfig autotools gettext

BBCLASSEXTEND += "nativesdk"

EXTRA_OECONF = "--enable-ftdi --enable-cmsis-dap --enable-jlink --enable-stlink --disable-doxygen-html "

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

