SUMMARY = "Open source flash program using STM32 ARM microcontrollers using the built-in ST serial bootloader"
HOMEPAGE = "https://sourceforge.net/projects/stm32flash/"
LICENSE = "GPL-2.0+"
LIC_FILES_CHKSUM = "file://gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = "${SOURCEFORGE_MIRROR}/${BPN}/${BP}.tar.gz"
SRCREV = "b89d626c64d8674e2a8b767915e0c6fd51ac8147"

S = "${WORKDIR}/${BPN}"

do_install() {
	oe_runmake install DESTDIR=${D} PREFIX=${prefix}
}
