SUMMARY = "QEMU with the Renesas RH850 target"
HOMEPAGE = "https://github.com/linumiz/qemu-rh850"
LICENSE = "GPL-2.0-only & LGPL-2.1-only"

DEPENDS = "glib-2.0 zlib bison-native meson-native ninja-native"

LIC_FILES_CHKSUM = "file://COPYING;md5=441c28d2cf86e15a37fa47e15a72fbac \
                    file://COPYING.LIB;endline=24;md5=8c5efda6cf1e1b03dcfd0e6c0d271c7f"

SRCREV = "${ZEPHYR_SDK_QEMU_RH850_SRCREV}"
SRC_URI = "gitsm://github.com/linumiz/qemu-rh850.git;protocol=https;nobranch=1"

# https://gitlab.com/qemu-project/qemu/-/commit/81e2b198a8cb4ee5fdf108bd438f44b193ee3a36 means
# we need a full python3-native setup
inherit pkgconfig python3native

BBCLASSEXTEND = "nativesdk"

# Per https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg03873.html
# upstream states qemu doesn't work without optimization
DEBUG_BUILD = "0"

rh850_qemu_prefix = "${prefix}/rh850"

EXTRA_OECONF = " \
  --prefix=${rh850_qemu_prefix} \
  --with-suffix=${BPN} \
  --extra-cflags='${CFLAGS}' \
  --extra-ldflags='${LDFLAGS}' \
  --host-cc='${BUILD_CC}' \
  --disable-strip --disable-werror --disable-docs \
  --without-default-features --disable-tools --disable-install-blobs \
  "

QEMU_TARGETS = "rh850-softmmu"

EXTRA_OECONF:append:class-target = " --cross-prefix=${HOST_PREFIX}"
EXTRA_OECONF:append:class-nativesdk = " --cross-prefix=${HOST_PREFIX}"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"

do_configure() {
        export PKG_CONFIG=pkg-config
        unset libdir
        unset libexecdir
        unset includedir
        unset bindir
        unset mandir
        unset datadir
        unset docdir
        unset sysconfdir
        unset local_statedir
        unset firmwarepath
        unset localedir
        ${S}/configure ${EXTRA_OECONF} --target-list="${QEMU_TARGETS}"
}
do_configure[cleandirs] += "${B}"
do_configure[network] = "1"

do_install () {
	export STRIP=""
	oe_runmake 'DESTDIR=${D}' install
}

FILES:${PN} = " \
   ${rh850_qemu_prefix} \
  "
