SUMMARY = "BOSSA is a flash programming utility for Atmel's SAM family of flash-based ARM microcontrollers."
HOMEPAGE = "https://github.com/shumatech/BOSSA"

#
# Note: In order to build this recipe, you need wxWidgets libraries :
#     sudo apt-get install wx2.8-headers libwxgtk2.8-0 libwxgtk2.8-dev
#

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://LICENSE;md5=bcf9399f7b9b96149837290bcdc3ad39"

DEPENDS = "readline"

PR = "r0"
SRCREV = "3532de82efd28fadbabc2b258d84dddf14298107"
SRC_URI = "git://github.com/shumatech/BOSSA.git;protocol=https \
	   file://0001-Wait-for-EEFC-flash-to-complete-operations-before-re.patch \
	   file://0001-Flash.h-Add-flash-override-samba-error.patch \
	   file://0002-CalwFlash-Add-SAM4L-Flashcalw-controller.patch \
	   file://0003-Device-Introduce-support-to-SAM4L-SoC-family.patch \
	   file://0004-CalwFlash-Add-NVIC-reset-command.patch \
"

S = "${WORKDIR}/git"

do_compile() {
	oe_runmake bin/bossac bin/bossash
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${S}/bin/bossac ${D}${bindir}
	install -m 0755 ${S}/bin/bossash ${D}${bindir}
}

FILES:${PN} = "${bindir} "

BBCLASSEXTEND += "nativesdk"

