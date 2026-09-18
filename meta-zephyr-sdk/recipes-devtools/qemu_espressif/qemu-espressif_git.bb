DEPENDS = "glib-2.0 zlib dtc pixman bison-native meson-native ninja-native libgcrypt libslirp"
LICENSE = "GPL-2.0-only & LGPL-2.1-only"

RDEPENDS:${PN}-common:class-target += "bash"

LIC_FILES_CHKSUM = "file://COPYING;md5=441c28d2cf86e15a37fa47e15a72fbac \
                    file://COPYING.LIB;endline=24;md5=8c5efda6cf1e1b03dcfd0e6c0d271c7f"

SRCREV_qemu = "${ZEPHYR_SDK_QEMU_ESPRESSIF_SRCREV}"
SRCREV_FORMAT = "qemu"

SRC_URI += "git://github.com/espressif/qemu.git;protocol=https;nobranch=1;name=qemu \
            file://0001-configure-lookup-meson-from-PATH.patch \
            file://0002-configure-disable-python-venv-for-meson.patch \
"

# Deal with the broken --disable-download
SRCREV_berkeley-softfloat-3 = "b64af41c3276f97f0e181920400ee056b9c88037"
SRCREV_berkeley-testfloat-3 = "e7af9751d9f9fd3b47911f51a5cfd08af256a9ab"
SRCREV_keycodemapdb = "f5772a62ec52591ff6870b7e8ef32482371f22c6"
SRC_URI += "\
           gitsm://gitlab.com/qemu-project/berkeley-softfloat-3;protocol=https;nobranch=1;destsuffix=git/subprojects/berkeley-softfloat-3;name=berkeley-softfloat-3 \
           gitsm://gitlab.com/qemu-project/berkeley-testfloat-3;protocol=https;nobranch=1;destsuffix=git/subprojects/berkeley-testfloat-3;name=berkeley-testfloat-3 \
           gitsm://gitlab.com/qemu-project/keycodemapdb.git;protocol=https;nobranch=1;destsuffix=git/subprojects/keycodemapdb;name=keycodemapdb \
"

# https://gitlab.com/qemu-project/qemu/-/commit/81e2b198a8cb4ee5fdf108bd438f44b193ee3a36 means
# we need a full python3-native setup
inherit autotools pkgconfig systemd python3native

BBCLASSEXTEND = "nativesdk"

DISABLE_STATIC = ""

# Per https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg03873.html
# upstream states qemu doesn't work without optimization
DEBUG_BUILD = "0"

espressif_qemu_prefix = "${prefix}/espressif"

EXTRA_OECONF = " \
  --prefix=${espressif_qemu_prefix} \
  --with-suffix= \
  --extra-cflags='${CFLAGS}' \
  --extra-ldflags='${LDFLAGS}' \
  --host-cc='${BUILD_CC}' \
  --without-default-features \
  --disable-docs \
  --disable-download \
  --disable-strip \
  --disable-user \
  --disable-werror \
  --enable-fdt=system \
  --enable-gcrypt \
  --enable-pixman \
  --enable-slirp \
  "

QEMU_TARGETS = "xtensa-softmmu riscv32-softmmu"

EXTRA_OECONF:append:class-target = " --cross-prefix=${HOST_PREFIX}"
EXTRA_OECONF:append:class-nativesdk = " --cross-prefix=${HOST_PREFIX}"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"

do_configure:prepend:class-native() {
        # Append build host pkg-config paths for native target since the host may provide sdl
        BHOST_PKGCONFIG_PATH=$(PATH=/usr/bin:/bin pkg-config --variable pc_path pkg-config || echo "")
        if [ ! -z "$BHOST_PKGCONFIG_PATH" ]; then
                export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$BHOST_PKGCONFIG_PATH
        fi
}

# Configure meson for disable-download
do_configure:prepend() {
        cp ${S}/subprojects/packagefiles/berkeley-softfloat-3/* ${S}/subprojects/berkeley-softfloat-3/.
        cp ${S}/subprojects/packagefiles/berkeley-testfloat-3/* ${S}/subprojects/berkeley-testfloat-3/.
}

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
        ${S}/configure ${EXTRA_OECONF}  --target-list="${QEMU_TARGETS}"
}
do_configure[cleandirs] += "${B}"

do_install () {
	export STRIP=""
	oe_runmake 'DESTDIR=${D}' install

	install -d ${D}${bindir}
	ln -sf ../espressif/bin/qemu-system-xtensa \
		${D}${bindir}/qemu-system-espressif-xtensa
	ln -sf ../espressif/bin/qemu-system-riscv32 \
		${D}${bindir}/qemu-system-espressif-riscv32
}

FILES:${PN} = " \
   ${espressif_qemu_prefix} \
   ${bindir}/qemu-system-espressif-* \
  "
