LICENSE = "MIT"
PN = "xtensa-config"
S = "${WORKDIR}/git"
LIC_FILES_CHKSUM = "file://LICENSE;md5=947dd7ded6ae6083f19f229781602891"
#
# Avoid circular dependencies when xtensa-config needs gcc and libs, but is
# itself needed for building binutils and gcc.
#
DEPENDS_remove = "virtual/libc virtual/${TARGET_PREFIX}compilerlibs virtual/${TARGET_PREFIX}gcc gcc-runtime"

xtensa_core_name ?= "sample_controller"
xtensa_build_url ?= "https://github.com/foss-xtensa/xtensa-config/releases/download/201702/sample_controller_linux.tgz"
xtensa_build_checksum ?= "md5sum=d82ae3939f31f14bc8542c4b741e064a"

SRCREV = "ca2bbcaf57dbef2bcc55a0b6fbf2b0b3cf143533"
SRC_URI = "git://github.com/foss-xtensa/xtensa-config.git \
	   ${xtensa_build_url};${xtensa_build_checksum};unpack=0 \
	  "
#
# Download xtensa core build. Extract the original configuration overlay
# from it. Use make-overlay.sh script to repackage it for easy application.
# The results are:
#  ${S}/xtensa-build.tgz -- xtensa core build
#  ${S}/xtensa-overlay.tar.gz -- repackaged xtensa configuration overlay
#
do_configure () {
	cp -a "${@bb.fetch2.Fetch([xtensa_build_url], d).localpath(xtensa_build_url)}" "${S}/xtensa-build.tgz"
	tar -xf "${S}/xtensa-build.tgz" `tar -tf "${S}/xtensa-build.tgz" | grep xtensa-config-overlay.tar.gz` -O > "${S}/xtensa-config-overlay.tar.gz"
	${S}/make-overlay.sh ${xtensa_core_name} "${S}/xtensa-config-overlay.tar.gz" "${S}"
	mv "${S}/xtensa_${xtensa_core_name}.tar.gz" "${S}/xtensa-overlay.tar.gz"
}

#
# Install build and overlay into /usr/src/xtensa-config under sysroot.
#
do_install () {
	installdir=${D}/usr/src/xtensa-config
	install -d "$installdir"
	cp ${S}/xtensa-build.tgz "$installdir"
	cp ${S}/xtensa-overlay.tar.gz "$installdir"
}

PACKAGES = "${PN}"
FILES_${PN} = "/usr/src/xtensa-config"

SYSROOT_DIRS += "/usr/src/xtensa-config"
BBCLASSEXTEND ="native"
