BBCLASSEXTEND = "nativesdk"

BPN = "qemu"

SUMMARY = "Fast open source processor emulator"
DESCRIPTION = "QEMU is a hosted virtual machine monitor: it emulates the \
machine's processor through dynamic binary translation and provides a set \
of different hardware and device models for the machine, enabling it to run \
a variety of guest operating systems"
HOMEPAGE = "http://qemu.org"
LICENSE = "GPL-2.0-only & LGPL-2.1-only"

DEPENDS += "bison-native meson-native ninja-native libslirp"

DEPENDS += "glib-2.0 zlib pixman"

CFLAGS += "${@bb.utils.contains('DISTRO_FEATURES', 'x11', '', '-DEGL_NO_X11=1', d)}"

RDEPENDS:${PN}-common:class-target += "bash"

DISABLE_STATIC = ""

PACKAGECONFIG ??= " \
    fdt sdl kvm pie slirp \
    ${@bb.utils.filter('DISTRO_FEATURES', 'alsa pulseaudio xen', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'virglrenderer epoxy', '', d)} \
    ${@bb.utils.filter('DISTRO_FEATURES', 'seccomp', d)} \
"
PACKAGECONFIG:class-nativesdk ??= "fdt sdl kvm pie slirp \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'virglrenderer epoxy', '', d)} \
"

# https://gitlab.com/qemu-project/qemu/-/commit/81e2b198a8cb4ee5fdf108bd438f44b193ee3a36 means
# we need a full python3-native setup
inherit pkgconfig systemd python3native

LIC_FILES_CHKSUM = "file://COPYING;md5=441c28d2cf86e15a37fa47e15a72fbac \
                    file://COPYING.LIB;endline=24;md5=8c5efda6cf1e1b03dcfd0e6c0d271c7f"

SRC_URI = "https://download.qemu.org/${BPN}-${PV}.tar.xz \
           file://powerpc_rom.bin \
           file://run-ptest \
	   file://0001-target-xtensa-add-translation-for-wsr.mpucfg.patch \
	   file://0002-target-xtensa-import-sample_controller32-core.patch        \
	   file://0003-tests-tcg-xtensa-tidy-test-linker-script.patch             \
	   file://0004-tests-tcg-xtensa-fix-SR-test-for-configs-with-MPU.patch    \
	   file://0005-target-xtensa-fix-sample_controller32-build-for-QEMU.patch \
	   file://0006-Revert-target-xtensa-Make-use-of-segment-in-pptlb-he.patch \
	   file://0007-qemu-Add-addition-environment-space-to-boot-loader-q.patch \
	   file://0008-apic-fixup-fallthrough-to-PIC.patch                        \
	   file://0009-qemu-Do-not-include-file-if-not-exists.patch               \
	   file://0010-qemu-Add-some-user-space-mmap-tweaks-to-address-musl.patch \
	   file://0011-qemu-Determinism-fixes.patch 				   \
	   file://0012-tests-meson.build-use-relative-path-to-refer-to-file.patch \
	   file://0013-Define-MAP_SYNC-and-MAP_SHARED_VALIDATE-on-needed-li.patch \
	   file://0014-configure-lookup-meson-exutable-from-PATH.patch            \
	   file://0015-qemu-Ensure-pip-and-the-python-venv-aren-t-used-for-.patch \
	   file://0016-target-riscv-kvm-do-not-use-non-portable-strerrornam.patch \
           file://qemu-guest-agent.init \
           file://qemu-guest-agent.udev \
           "
# file index at download.qemu.org isn't reliable: https://gitlab.com/qemu-project/qemu-web/-/issues/9
UPSTREAM_CHECK_URI = "https://www.qemu.org"
UPSTREAM_CHECK_REGEX = "qemu-(?P<pver>\d+(\.\d+)+)\.tar"

SRC_URI[sha256sum] = "ef786f2398cb5184600f69aef4d5d691efd44576a3cff4126d38d4c6fec87759"
CVE_STATUS[CVE-2007-0998] = "not-applicable-config: The VNC server can expose host files uder some circumstances. We don't enable it by default."

# https://bugzilla.redhat.com/show_bug.cgi?id=1609015#c11
CVE_STATUS[CVE-2018-18438] = "disputed: The issues identified by this CVE were determined to not constitute a vulnerability."

# As per https://bugzilla.redhat.com/show_bug.cgi?id=2203387
CVE_STATUS[CVE-2023-2680] = "not-applicable-platform: RHEL specific issue."

# NVD DB has this CVE as version-less (with "-")
CVE_STATUS[CVE-2024-6505] = "fixed-version: this CVE is fixed since 9.1.0"

COMPATIBLE_HOST:mipsarchn32 = "null"
COMPATIBLE_HOST:mipsarchn64 = "null"
COMPATIBLE_HOST:riscv32 = "null"

# Per https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg03873.html
# upstream states qemu doesn't work without optimization
DEBUG_BUILD = "0"

do_install:append() {
    # Prevent QA warnings about installed ${localstatedir}/run
    if [ -d ${D}${localstatedir}/run ]; then rmdir ${D}${localstatedir}/run; fi
}

EXTRA_OECONF = " \
    --prefix=${prefix} \
    --bindir=${bindir} \
    --includedir=${includedir} \
    --libdir=${libdir} \
    --mandir=${mandir} \
    --datadir=${datadir} \
    --docdir=${docdir}/${BPN} \
    --sysconfdir=${sysconfdir} \
    --libexecdir=${libexecdir} \
    --localstatedir=${localstatedir} \
    --with-suffix=${BPN} \
    --disable-strip \
    --disable-werror \
    --extra-cflags='${CFLAGS}' \
    --extra-ldflags='${LDFLAGS}' \
    --disable-download \
    --disable-docs \
    --host-cc='${BUILD_CC}' \
    --disable-af-xdp \
    ${PACKAGECONFIG_CONFARGS} \
    "
QEMU_TARGETS = "aarch64-softmmu arm-softmmu i386-softmmu or1k-softmmu mips-softmmu mipsel-softmmu xtensa-softmmu riscv32-softmmu riscv64-softmmu x86_64-softmmu rx-softmmu"

EXTRA_OECONF:append:class-target = " --cross-prefix=${HOST_PREFIX}"
EXTRA_OECONF:append:class-nativesdk = " --cross-prefix=${HOST_PREFIX}"

B = "${WORKDIR}/build"

#EXTRA_OECONF:append = " --python=${HOSTTOOLS_DIR}/python3"

do_configure:prepend:class-native() {
	# Append build host pkg-config paths for native target since the host may provide sdl
	BHOST_PKGCONFIG_PATH=$(PATH=/usr/bin:/bin pkg-config --variable pc_path pkg-config || echo "")
	if [ ! -z "$BHOST_PKGCONFIG_PATH" ]; then
		export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$BHOST_PKGCONFIG_PATH
	fi
}

do_configure() {
    export PKG_CONFIG=pkg-config
    ${S}/configure ${EXTRA_OECONF}  --target-list="${QEMU_TARGETS}"
}
do_configure[cleandirs] += "${B}"

do_install () {
	export STRIP=""
	oe_runmake 'DESTDIR=${D}' install
        install -m 0755 ${WORKDIR}/build/contrib/ivshmem-server/ivshmem-server ${D}${bindir}
        install -m 0755 ${WORKDIR}/build/contrib/ivshmem-client/ivshmem-client ${D}${bindir}

	# If we built the guest agent, also install startup/udev rules
	if [ -e "${D}${bindir}/qemu-ga" ]; then
		install -d ${D}${sysconfdir}/init.d/
		install -m 0755 ${WORKDIR}/qemu-guest-agent.init ${D}${sysconfdir}/init.d/qemu-guest-agent
		sed -i 's:@bindir@:${bindir}:' ${D}${sysconfdir}/init.d/qemu-guest-agent

		install -d ${D}${sysconfdir}/udev/rules.d/
		install -m 0644 ${WORKDIR}/qemu-guest-agent.udev ${D}${sysconfdir}/udev/rules.d/60-qemu-guest-agent.rules

		install -d ${D}${systemd_unitdir}/system/
		install -m 0644 ${S}/contrib/systemd/qemu-guest-agent.service ${D}${systemd_unitdir}/system
		sed -i -e 's,-/usr/bin/,-${bindir}/,g' ${D}${systemd_unitdir}/system/qemu-guest-agent.service
	fi
	# ELF binary /usr/share/qemu/s390-netboot.img has relocations in .text
	rm ${D}${datadir}/qemu/s390-netboot.img -f
	# ELF binary /usr/share/qemu/s390-ccw.img has relocations in .text [textrel]
	rm ${D}${datadir}/qemu/s390-ccw.img -f
	# We don't support PARISC and these cause strip and SDK relocation errors
	rm ${D}${datadir}/qemu/hppa* -f

        # remove icons
        rm -rf ${D}${datadir}/icons
}

do_install:append() {
    # Link Xilinx QEMU executables
    ln -sf ../xilinx/bin/qemu-system-aarch64 ${D}${bindir}/qemu-system-xilinx-aarch64
    ln -sf ../xilinx/bin/qemu-system-microblazeel ${D}${bindir}/qemu-system-xilinx-microblazeel

    ln -sf ../xilinx/bin/qemu-system-riscv32 ${D}${bindir}/qemu-system-xilinx-riscv32
    ln -sf ../xilinx/bin/qemu-system-riscv64 ${D}${bindir}/qemu-system-xilinx-riscv64

    # Link ARC (Synopsys) QEMU executables
    ln -sf ../synopsys/bin/qemu-system-arc ${D}${bindir}/qemu-system-arc
    ln -sf ../synopsys/bin/qemu-system-arc64 ${D}${bindir}/qemu-system-arc64

    # Link other legacy QEMU executables
    ln -sf ../legacy/bin/qemu-system-sparc ${D}${bindir}/qemu-system-sparc
}

# Disable kvm/virgl/mesa on targets that do not support it
PACKAGECONFIG:remove:darwin = "kvm virglrenderer epoxy gtk+"
PACKAGECONFIG:remove:mingw32 = "kvm virglrenderer epoxy gtk+ pie"

PACKAGECONFIG[sdl] = "--enable-sdl,--disable-sdl,libsdl2"
PACKAGECONFIG[png] = "--enable-png,--disable-png,libpng"
PACKAGECONFIG[virtfs] = "--enable-virtfs --enable-attr --enable-cap-ng,--disable-virtfs,libcap-ng attr,"
PACKAGECONFIG[aio] = "--enable-linux-aio,--disable-linux-aio,libaio,"
PACKAGECONFIG[uring] = "--enable-linux-io-uring,--disable-linux-io-uring,liburing"
PACKAGECONFIG[xen] = "--enable-xen,--disable-xen,xen-tools,xen-tools-libxenstore xen-tools-libxenctrl xen-tools-libxenguest"
PACKAGECONFIG[vnc-sasl] = "--enable-vnc --enable-vnc-sasl,--disable-vnc-sasl,cyrus-sasl,"
PACKAGECONFIG[vnc-jpeg] = "--enable-vnc --enable-vnc-jpeg,--disable-vnc-jpeg,jpeg,"
PACKAGECONFIG[libcurl] = "--enable-curl,--disable-curl,curl,"
PACKAGECONFIG[nss] = "--enable-smartcard,--disable-smartcard,nss,"
PACKAGECONFIG[curses] = "--enable-curses,--disable-curses,ncurses,"
PACKAGECONFIG[gtk+] = "--enable-gtk,--disable-gtk,gtk+3 gettext-native"
PACKAGECONFIG[vte] = "--enable-vte,--disable-vte,vte gettext-native"
PACKAGECONFIG[libcap-ng] = "--enable-cap-ng,--disable-cap-ng,libcap-ng,"
PACKAGECONFIG[ssh] = "--enable-libssh,--disable-libssh,libssh,"
PACKAGECONFIG[gcrypt] = "--enable-gcrypt,--disable-gcrypt,libgcrypt,"
PACKAGECONFIG[nettle] = "--enable-nettle,--disable-nettle,nettle"
PACKAGECONFIG[libusb] = "--enable-libusb,--disable-libusb,libusb1"
PACKAGECONFIG[fdt] = "--enable-fdt,--disable-fdt,dtc"
PACKAGECONFIG[alsa] = "--audio-drv-list=default,,alsa-lib"
PACKAGECONFIG[epoxy] = "--enable-opengl,--disable-opengl,libepoxy"
PACKAGECONFIG[lzo] = "--enable-lzo,--disable-lzo,lzo"
PACKAGECONFIG[dax] = "--enable-libdaxctl,--disable-libdaxctl,ndctl"
PACKAGECONFIG[numa] = "--enable-numa,--disable-numa,numactl"
PACKAGECONFIG[gnutls] = "--enable-gnutls,--disable-gnutls,gnutls"
PACKAGECONFIG[bzip2] = "--enable-bzip2,--disable-bzip2,bzip2"
PACKAGECONFIG[libiscsi] = "--enable-libiscsi,--disable-libiscsi"
PACKAGECONFIG[kvm] = "--enable-kvm,--disable-kvm"
PACKAGECONFIG[virglrenderer] = "--enable-virglrenderer,--disable-virglrenderer,virglrenderer"
# spice will be in meta-networking layer
PACKAGECONFIG[spice] = "--enable-spice,--disable-spice,spice"
# usbredir will be in meta-networking layer
PACKAGECONFIG[dbus-display] = "--enable-dbus-display,--disable-dbus-display,glib-2.0-native,dbus"
PACKAGECONFIG[usb-redir] = "--enable-usb-redir,--disable-usb-redir,usbredir"
PACKAGECONFIG[snappy] = "--enable-snappy,--disable-snappy,snappy"
PACKAGECONFIG[glusterfs] = "--enable-glusterfs,--disable-glusterfs,glusterfs"
PACKAGECONFIG[xkbcommon] = "--enable-xkbcommon,--disable-xkbcommon,libxkbcommon"
PACKAGECONFIG[libudev] = "--enable-libudev,--disable-libudev,udev"
PACKAGECONFIG[attr] = "--enable-attr,--disable-attr,attr,"
PACKAGECONFIG[rbd] = "--enable-rbd,--disable-rbd,ceph,ceph"
PACKAGECONFIG[vhost] = "--enable-vhost-net,--disable-vhost-net,,"
PACKAGECONFIG[ust] = "--enable-trace-backends=ust,,lttng-ust,"
PACKAGECONFIG[pie] = "--enable-pie,--disable-pie,,"
PACKAGECONFIG[seccomp] = "--enable-seccomp,--disable-seccomp,libseccomp"
# libnfs is currently provided by meta-kodi
PACKAGECONFIG[libnfs] = "--enable-libnfs,--disable-libnfs,libnfs"
PACKAGECONFIG[pmem] = "--enable-libpmem,--disable-libpmem,pmdk"
PACKAGECONFIG[pulseaudio] = "--enable-pa,--disable-pa,pulseaudio"
PACKAGECONFIG[selinux] = "--enable-selinux,--disable-selinux"
PACKAGECONFIG[bpf] = "--enable-bpf,--disable-bpf,libbpf"
PACKAGECONFIG[capstone] = "--enable-capstone,--disable-capstone"
PACKAGECONFIG[rdma] = "--enable-rdma,--disable-rdma"
PACKAGECONFIG[vde] = "--enable-vde,--disable-vde"
PACKAGECONFIG[fuse] = "--enable-fuse --enable-fuse-lseek,--disable-fuse --disable-fuse-lseek,fuse3"
PACKAGECONFIG[slirp] = "--enable-slirp,--disable-slirp,libslirp"
PACKAGECONFIG[brlapi] = "--enable-brlapi,--disable-brlapi"
PACKAGECONFIG[jack] = "--enable-jack,--disable-jack,jack,"
PACKAGECONFIG[debuginfo] = "--enable-libdw,--disable-libdw,elfutils"
PACKAGECONFIG[pipewire] = "--enable-pipewire,--disable-pipewire,pipewire"
PACKAGECONFIG[sndio] = "--enable-sndio,--disable-sndio,sndio"

INSANE_SKIP:${PN}-common = "arch"
