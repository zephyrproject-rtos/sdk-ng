
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"
DEPENDS = "openssl"

SRCREV = "04a535d508e60e4dbfeccb07b362d8f5d4f8cbf1"
SRC_URI = "git://git.alsa-project.org/sound-open-firmware-tools.git"

S = "${WORKDIR}/git"

inherit autotools

BBCLASSEXTEND += "nativesdk"

do_configure_prepend() {
    cd ${S}
    ${S}/autogen.sh
}

do_configure() {
    make distclean || :
    oe_runconf
}

do_compile() {
    cd ${S}
    oe_runmake
}

do_install() {
    cd ${S}
    oe_runmake DESTDIR=${D} install
}

