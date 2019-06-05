LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"
DEPENDS = "libusb-compat hidapi-libraw"
RDEPENDS_${PN} = "libusb1 hidapi-libraw"

# The various arc files are based on the commit e781e73a39bc5c845b73dc96b751d867278a7583
# of https://github.com/foss-for-synopsys-dwc-arc-processors/openocd

SRC_URI = " \
	git://github.com/zephyrproject-rtos/openocd.git;protocol=https;nobranch=1 \
	"
SRCREV = "1df07a9a442a3839e29a295e67bb057deb08f058"

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

