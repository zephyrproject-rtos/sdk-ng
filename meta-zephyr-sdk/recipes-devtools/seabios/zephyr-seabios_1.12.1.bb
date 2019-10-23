# Origin:
# http://git.yoctoproject.org/cgit/cgit.cgi/meta-virtualization/plain/recipes-extended/seabios/seabios_1.11.2.bb--2019-10-22

DESCRIPTION = "SeaBIOS"
HOMEPAGE = "http://www.coreboot.org/SeaBIOS"
LICENSE = "LGPLv3"
SECTION = "firmware"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_SYSROOT_STRIP = "1"

BBCLASSEXTEND = "native nativesdk"

SRCREV = "a5cab58e9a3fb6e168aba919c5669bea406573b4"
SRC_URI = " \
    git://git.seabios.org/seabios.git;protocol=https;branch=1.12-stable \
    file://hostcc.patch \
    file://0001-sercon-don-t-clear-screen-and-don-t-disable-line-wra.patch \
    file://config.seabios-128k \
    file://config.seabios-256k \
    "

S = "${WORKDIR}/git"

LIC_FILES_CHKSUM = "file://COPYING;md5=d32239bcb673463ab874e80d47fae504         \
                    file://COPYING.LESSER;md5=6a6a8e020838b23406c81b19c1d46df6  \
                    "

SRC_URI[md5sum] = "6cb6cba431fd725126ddb5ec529ab85c"
SRC_URI[sha256sum] = "89ba3f3e3436008992e2304ca1afa1a9527e77c309d896d1b0332e97339f6127"

DEPENDS = "util-linux-native file-native bison-native flex-native gettext-native python-native"

TUNE_CCARGS = ""
EXTRA_OEMAKE += "HOSTCC='${BUILD_CC}'"
EXTRA_OEMAKE += "CROSS_PREFIX=${TARGET_PREFIX}"
EXTRA_OEMAKE += "EXTRAVERSION='-zephyr'"

do_configure() {
    mkdir -p ${B}/128k
    cp ${WORKDIR}/config.seabios-128k ${B}/128k/.config
    oe_runmake KCONFIG_CONFIG=${B}/128k/.config OUT=${B}/128k/ oldnoconfig

    mkdir -p ${B}/256k
    cp ${WORKDIR}/config.seabios-256k ${B}/256k/.config
    oe_runmake KCONFIG_CONFIG=${B}/256k/.config OUT=${B}/256k/ oldnoconfig
}

do_compile() {
    unset CPP
    unset CPPFLAGS

    oe_runmake KCONFIG_CONFIG=${B}/128k/.config OUT=${B}/128k/
    oe_runmake KCONFIG_CONFIG=${B}/256k/.config OUT=${B}/256k/
}

do_install() {
    # install into staging are so these can be picked up by zephyr-qemu.
    install -d ${STAGING_DIR}/usr/share/firmware
    install -m 0644 ${B}/128k/bios.bin ${STAGING_DIR}/usr/share/firmware/bios.bin
    install -m 0644 ${B}/256k/bios.bin ${STAGING_DIR}/usr/share/firmware/bios-256k.bin
}

INSANE_SKIP_${PN} = "already-stripped"
