DESCRIPTION = "Standalone tarball containing various host SDK packages for Zephyr development."
SUMMARY = "Standalone tarball for running Zephyr SDK builds on all systems"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

TOOLCHAIN_TARGET_TASK ?= ""

TOOLCHAIN_HOST_TASK ?= "\
    nativesdk-zephyr-qemu \
    nativesdk-xilinx-qemu \
    nativesdk-openocd \
    nativesdk-bossa \
    nativesdk-dtc \
    "

TOOLCHAIN_OUTPUTNAME ?= "${DISTRO}-${SDKMACHINE}-hosttools-standalone-${DISTRO_VERSION}"

RDEPENDS = "${TOOLCHAIN_HOST_TASK}"

inherit nopackages
inherit populate_sdk
inherit toolchain-scripts

create_sdk_files:append () {
	rm -f ${SDK_OUTPUT}/${SDKPATH}/site-config-*
	rm -f ${SDK_OUTPUT}/${SDKPATH}/environment-setup-*
	rm -f ${SDK_OUTPUT}/${SDKPATH}/version-*

	# Remove unused qemu firmware binaries
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/usr/share/qemu/edk2*
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/usr/share/qemu/skiboot.lid
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/usr/share/qemu/openbios-*
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/usr/share/qemu/ppc_rom.bin
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/usr/share/qemu/slof.bin
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/usr/share/qemu/hppa-firmware.img

	# Remove mime
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/usr/share/mime

	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/usr/share/readline
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/usr/share/glib-2.0
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/etc
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/var
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/sbin

	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${MULTIMACH_TARGET_SYS}

	# Generate new sdk-environment-setup stub file
	script=${1:-${SDK_OUTPUT}/${SDKPATH}/environment-setup-${SDK_SYS}}
	touch $script
	echo 'export PATH=${SDKPATHNATIVE}${bindir_nativesdk}:$PATH' >> $script
	# In order for the self-extraction script to correctly extract and set up things,
	# we need a 'OECORE_NATIVE_SYSROOT=xxx' line in environment setup script.
	# However, this tarball is inherently a tool set instead of a fully functional SDK,
	# so instead of exporting the variable, we use a comment here.
	echo '#OECORE_NATIVE_SYSROOT="${SDKPATHNATIVE}"' >> $script
	toolchain_create_sdk_version ${SDK_OUTPUT}/${SDKPATH}/version-${SDK_SYS}
}
