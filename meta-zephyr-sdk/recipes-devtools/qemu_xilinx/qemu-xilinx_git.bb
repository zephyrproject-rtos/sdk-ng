DEPENDS = "glib-2.0 zlib dtc pixman bison-native meson-native ninja-native libgcrypt libslirp"
LICENSE = "GPL-2.0-only & LGPL-2.1-only"

RDEPENDS:${PN}-common:class-target += "bash"

LIC_FILES_CHKSUM = "file://COPYING;md5=441c28d2cf86e15a37fa47e15a72fbac \
                    file://COPYING.LIB;endline=24;md5=8c5efda6cf1e1b03dcfd0e6c0d271c7f"

SRCREV_qemu = "b05c9752662eb4b8120a57454a323445d78d1463"
SRCREV_FORMAT = "qemu"

SRC_URI += "gitsm://github.com/Xilinx/qemu.git;protocol=https;nobranch=1;name=qemu \
           file://cross.patch \
           file://0004-configure-Add-pkg-config-handling-for-libgcrypt.patch \
           file://0008-tests-meson.build-use-relative-path-to-refer-to-file.patch \
           file://fixedmeson.patch \
           file://no-pip.patch \
"

# Deal with the broken --disable-download
SRCREV_berkeley-softfloat-3 = "b64af41c3276f97f0e181920400ee056b9c88037"
SRCREV_berkeley-testfloat-3 = "40619cbb3bf32872df8c53cc457039229428a263"
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

xilinx_qemu_prefix = "${prefix}/xilinx"

EXTRA_OECONF = " \
  --prefix=${xilinx_qemu_prefix} \
  --with-suffix=${BPN} \
  --extra-cflags='${CFLAGS}' \
  --extra-ldflags='${LDFLAGS}' \
  --host-cc='${BUILD_CC}' \
  --disable-strip --disable-libvduse --disable-vhost-user --disable-vnc \
  --enable-gcrypt --enable-plugins --disable-capstone --skip-meson \
  --disable-docs  --disable-sdl --disable-debug-info  --disable-cap-ng \
  --disable-capstone --disable-download --disable-libnfs \
  --disable-libusb --disable-libiscsi --disable-usb-redir --disable-linux-aio \
  --disable-guest-agent --disable-libssh --disable-seccomp --disable-tpm \
  --disable-numa --disable-glusterfs --disable-virtfs --disable-xen \
  --disable-curl --disable-attr --disable-curses --disable-iconv \
  --disable-kvm --disable-parallels --disable-replication \
  --disable-live-block-migration --disable-dmg --disable-werror \
  --enable-slirp \
  "

QEMU_TARGETS = "aarch64-softmmu riscv32-softmmu riscv64-softmmu microblazeel-softmmu"

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
}

FILES:${PN} = " \
   ${xilinx_qemu_prefix} \
  "
