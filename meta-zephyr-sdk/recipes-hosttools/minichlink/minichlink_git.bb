SUMMARY = "A free, open mechanism to use the CH-LinkE $4 programming dongle for the CH32V003."
HOMEPAGE = "https://github.com/cnlohr/ch32v003fun"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=08d32be0f39cc2231a746a21a7c0cefa"

DEPENDS = "eudev libusb"

BBCLASSEXTEND += "nativesdk"

SRC_URI = "git://github.com/cnlohr/ch32v003fun.git;protocol=https \
	   file://0001-Use-CFLAGS-LDFLAGS.patch"
SRCREV = "d8fe188769be7821908751b785e09032e6578a7a"

S = "${WORKDIR}/git"

do_compile() {
	oe_runmake -C minichlink minichlink
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${S}/minichlink/minichlink ${D}${bindir}
}
