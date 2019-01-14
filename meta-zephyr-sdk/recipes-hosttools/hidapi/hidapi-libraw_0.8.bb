SUMMARY = "HIDAPI is a library which allows an application to interface with USB and Bluetooth HID-Class devices"
HOMEPAGE = "https://github.com/signal11/hidapi"
SECTION = "libs"

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://LICENSE-bsd.txt;md5=b5fa085ce0926bb50d0621620a82361f"

DEPENDS += "udev"
RDEPENDS_${PN} += "udev"

PR = "r0"
SRCREV = "b5b2e1779b6cd2edda3066bbbf0921a2d6b1c3c0"
SRC_URI = "git://github.com/signal11/hidapi.git;protocol=https \
        file://libusb.h \
        "

BBCLASSEXTEND += " native nativesdk"

S = "${WORKDIR}/git"

inherit autotools pkgconfig

EXTRA_OECONF = " --libdir=${base_libdir}"

do_configure() {
	cd ${S}
	./bootstrap
	export PKG_CONFIG_DIR=
	export PKG_CONFIG_LIBDIR=${prefix}/lib/pkgconfig:${prefix}/share/pkgconfig
	export PKG_CONFIG_SYSROOT_DIR=${prefix}
	oe_runconf ${EXTRA_OECONF}
}

do_compile() {
	cp ${WORKDIR}/libusb.h* ${S}/libusb
	cd ${S}/linux
	make Makefile-manual
}

do_install() {
	cd ${S}/linux
	oe_runmake DESTDIR=${D} install

	# pkgconfig is needed to keep OpenOCD happy.
	# (OpenOCD searches for HIDAPI via pkgconfig)
	install -d ${D}${libdir}/pkgconfig
	cp ${S}/pc/hidapi-hidraw.pc ${D}${libdir}/pkgconfig
	#rm ${D}${includedir}/hidapi/hidapi.h
}

FILES_${PN} += "${base_libdir}/*.so.*"

FILES_${PN}-dev += "${base_libdir}/*.so ${base_libdir}/*.a"
FILES_${PN}-dev += "${includedir}"

