SUMMARY = "BOSSA is a flash programming utility for Atmel's SAM family of flash-based ARM microcontrollers."
HOMEPAGE = "https://github.com/shumatech/BOSSA"

#
# Note: In order to build this recipe, you need wxWidgets libraries :
#     sudo apt-get install wx2.8-headers libwxgtk2.8-0 libwxgtk2.8-dev
#

LICENSE = "SHUMATECH"
LIC_FILES_CHKSUM = "file://LICENSE;md5=94411054a7f6921218ab9c05b6b4b15b"

DEPENDS = "readline"

PR = "r0"
SRCREV = "5cae9fee241bd3c95c197b2464e9b83240994c43"
SRC_URI = "git://github.com/shumatech/BOSSA.git;protocol=https"

S = "${WORKDIR}/git"

do_compile() {
	oe_runmake bin/bossac bin/bossash
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${S}/bin/bossac ${D}${bindir}
	install -m 0755 ${S}/bin/bossash ${D}${bindir}
}

FILES_${PN} = "${bindir} "

BBCLASSEXTEND += "nativesdk"

