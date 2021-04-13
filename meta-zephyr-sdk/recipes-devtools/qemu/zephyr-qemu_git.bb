
DEPENDS = "glib-2.0 zlib pixman gnutls dtc"
LICENSE = "GPLv2"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
LIC_FILES_CHKSUM = "file://COPYING;md5=441c28d2cf86e15a37fa47e15a72fbac \
                    file://COPYING.LIB;endline=24;md5=8c5efda6cf1e1b03dcfd0e6c0d271c7f"

SRCREV = "5f41564d19d9d16148fef612c73e0dd6dfc50a57"
SRC_URI = "git://github.com/zephyrproject-rtos/qemu.git;protocol=https \
	   https://github.com/zephyrproject-rtos/seabios/releases/download/zephyr-v1.0.0/bios-128k.bin;name=bios-128k \
	   https://github.com/zephyrproject-rtos/seabios/releases/download/zephyr-v1.0.0/bios-256k.bin;name=bios-256k \
"

SRC_URI[bios-128k.sha256sum] = "943c077c3925ee7ec85601fb12937a0988c478a95523a628cd7e61c639dd6e81"
SRC_URI[bios-256k.sha256sum] = "19133167cc0bfb2a9e8ce9567efcd013a4ab80d2f3522ac66df0c23c68c18984"

BBCLASSEXTEND = "native nativesdk"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"

S = "${WORKDIR}/git"

inherit autotools pkgconfig

# Standard options:
#  --prefix=PREFIX          install in PREFIX [$prefix]
#  --interp-prefix=PREFIX   where to find shared libraries, etc.
#                           use %M for cpu name [$interp_prefix]
#  --target-list=LIST       set target list (default: build everything)
# $(echo Available targets: $default_target_list | \
#  fold -s -w 53 | sed -e 's/^/                           /')
#
# Advanced options (experts only):
#  --source-path=PATH       path of source code [$source_path]
#  --cross-prefix=PREFIX    use PREFIX for compile tools [$cross_prefix]
#  --cc=CC                  use C compiler CC [$cc]
#  --iasl=IASL              use ACPI compiler IASL [$iasl]
#  --host-cc=CC             use C compiler CC [$host_cc] for code run at
#                           build time
#  --cxx=CXX                use C++ compiler CXX [$cxx]
#  --objcc=OBJCC            use Objective-C compiler OBJCC [$objcc]
#  --extra-cflags=CFLAGS    append extra C compiler flags QEMU_CFLAGS
#  --extra-ldflags=LDFLAGS  append extra linker flags LDFLAGS
#  --make=MAKE              use specified make [$make]
#  --install=INSTALL        use specified install [$install]
#  --python=PYTHON          use specified python [$python]
#  --smbd=SMBD              use specified smbd [$smbd]
#  --static                 enable static build [$static]
#  --mandir=PATH            install man pages in PATH
#  --datadir=PATH           install firmware in PATH$confsuffix
#  --docdir=PATH            install documentation in PATH$confsuffix
#  --bindir=PATH            install binaries in PATH
#  --libdir=PATH            install libraries in PATH
#  --sysconfdir=PATH        install config in PATH$confsuffix
#  --localstatedir=PATH     install local state in PATH (set at runtime on win32)
#  --with-confsuffix=SUFFIX suffix for QEMU data inside datadir/libdir/sysconfdir [$confsuffix]
#  --enable-modules         enable modules support
#  --enable-debug-tcg       enable TCG debugging
#  --disable-debug-tcg      disable TCG debugging (default)
#  --enable-debug-info      enable debugging information (default)
#  --disable-debug-info     disable debugging information
#  --enable-debug           enable common debug build options
#  --enable-sparse          enable sparse checker
#  --disable-sparse         disable sparse checker (default)
#  --disable-strip          disable stripping binaries
#  --disable-werror         disable compilation abort on warning
#  --disable-stack-protector disable compiler-provided stack protection
#  --disable-sdl            disable SDL
#  --enable-sdl             enable SDL
#  --with-sdlabi            select preferred SDL ABI 1.2 or 2.0
#  --disable-gtk            disable gtk UI
#  --enable-gtk             enable gtk UI
#  --with-gtkabi            select preferred GTK ABI 2.0 or 3.0
#  --disable-virtfs         disable VirtFS
#  --enable-virtfs          enable VirtFS
#  --disable-vnc            disable VNC
#  --enable-vnc             enable VNC
#  --disable-cocoa          disable Cocoa (Mac OS X only)
#  --enable-cocoa           enable Cocoa (default on Mac OS X)
#  --audio-drv-list=LIST    set audio drivers list:
#                           Available drivers: $audio_possible_drivers
#  --block-drv-whitelist=L  Same as --block-drv-rw-whitelist=L
#  --block-drv-rw-whitelist=L
#                           set block driver read-write whitelist
#                           (affects only QEMU, not qemu-img)
#  --block-drv-ro-whitelist=L
#                           set block driver read-only whitelist
#                           (affects only QEMU, not qemu-img)
#  --disable-xen            disable xen backend driver support
#  --enable-xen             enable xen backend driver support
#  --disable-xen-pci-passthrough
#  --enable-xen-pci-passthrough
#  --disable-brlapi         disable BrlAPI
#  --enable-brlapi          enable BrlAPI
#  --disable-vnc-tls        disable TLS encryption for VNC server
#  --enable-vnc-tls         enable TLS encryption for VNC server
#  --disable-vnc-sasl       disable SASL encryption for VNC server
#  --enable-vnc-sasl        enable SASL encryption for VNC server
#  --disable-vnc-jpeg       disable JPEG lossy compression for VNC server
#  --enable-vnc-jpeg        enable JPEG lossy compression for VNC server
#  --disable-vnc-png        disable PNG compression for VNC server (default)
#  --enable-vnc-png         enable PNG compression for VNC server
#  --disable-vnc-ws         disable Websockets support for VNC server
#  --enable-vnc-ws          enable Websockets support for VNC server
#  --disable-curses         disable curses output
#  --enable-curses          enable curses output
#  --disable-curl           disable curl connectivity
#  --enable-curl            enable curl connectivity
#  --disable-fdt            disable fdt device tree
#  --enable-fdt             enable fdt device tree
#  --disable-bluez          disable bluez stack connectivity
#  --enable-bluez           enable bluez stack connectivity
#  --disable-slirp          disable SLIRP userspace network connectivity
#  --disable-kvm            disable KVM acceleration support
#  --enable-kvm             enable KVM acceleration support
#  --disable-rdma           disable RDMA-based migration support
#  --enable-rdma            enable RDMA-based migration support
#  --enable-tcg-interpreter enable TCG with bytecode interpreter (TCI)
#  --enable-system          enable all system emulation targets
#  --disable-system         disable all system emulation targets
#  --enable-user            enable supported user emulation targets
#  --disable-user           disable all user emulation targets
#  --enable-linux-user      enable all linux usermode emulation targets
#  --disable-linux-user     disable all linux usermode emulation targets
#  --enable-bsd-user        enable all BSD usermode emulation targets
#  --disable-bsd-user       disable all BSD usermode emulation targets
#  --enable-guest-base      enable GUEST_BASE support for usermode
#                           emulation targets
#  --disable-guest-base     disable GUEST_BASE support
#  --enable-pie             build Position Independent Executables
#  --disable-pie            do not build Position Independent Executables
#  --fmod-lib               path to FMOD library
#  --fmod-inc               path to FMOD includes
#  --oss-lib                path to OSS library
#  --cpu=CPU                Build for host CPU [$cpu]
#  --enable-uuid            enable uuid support
#  --disable-vde            disable support for vde network
#  --enable-vde             enable support for vde network
#  --disable-netmap         disable support for netmap network
#  --enable-netmap          enable support for netmap network
#  --disable-linux-aio      disable Linux AIO support
#  --enable-linux-aio       enable Linux AIO support
#  --disable-cap-ng         disable libcap-ng support
#  --enable-cap-ng          enable libcap-ng support
#  --disable-attr           disables attr and xattr support
#  --enable-attr            enable attr and xattr support
#  --disable-blobs          disable installing provided firmware blobs
#  --enable-docs            enable documentation build
#  --disable-docs           disable documentation build
#  --disable-vhost-net      disable vhost-net acceleration support
#  --enable-vhost-net       enable vhost-net acceleration support
#  --enable-trace-backends=B Set trace backend
#                           Available backends: $($python $source_path/scripts/tracetool.py --list-backends)
#  --with-trace-file=NAME   Full PATH,NAME of file to store traces
#                           Default:trace-<pid>
#  --disable-spice          disable spice
#  --enable-spice           enable spice
#  --enable-rbd             enable building the rados block device (rbd)
#  --disable-libiscsi       disable iscsi support
#  --enable-libiscsi        enable iscsi support
#  --disable-libnfs         disable nfs support
#  --enable-libnfs          enable nfs support
#  --disable-smartcard-nss  disable smartcard nss support
#  --enable-smartcard-nss   enable smartcard nss support
#  --disable-libusb         disable libusb (for usb passthrough)
#  --enable-libusb          enable libusb (for usb passthrough)
#  --disable-usb-redir      disable usb network redirection support
#  --enable-usb-redir       enable usb network redirection support
#  --enable-lzo             enable the support of lzo compression library
#  --enable-snappy          enable the support of snappy compression library
#  --disable-guest-agent    disable building of the QEMU Guest Agent
#  --enable-guest-agent     enable building of the QEMU Guest Agent
#  --with-vss-sdk=SDK-path  enable Windows VSS support in QEMU Guest Agent
#  --with-win-sdk=SDK-path  path to Windows Platform SDK (to build VSS .tlb)
#  --disable-seccomp        disable seccomp support
#  --enable-seccomp         enables seccomp support
#  --with-coroutine=BACKEND coroutine backend. Supported options:
#                           gthread, ucontext, sigaltstack, windows
#  --disable-coroutine-pool disable coroutine freelist (worse performance)
#  --enable-coroutine-pool  enable coroutine freelist (better performance)
#  --enable-glusterfs       enable GlusterFS backend
#  --disable-glusterfs      disable GlusterFS backend
#  --enable-gcov            enable test coverage analysis with gcov
#  --gcov=GCOV              use specified gcov [$gcov_tool]
#  --disable-tpm            disable TPM support
#  --enable-tpm             enable TPM support
#  --disable-libssh2        disable ssh block device support
#  --enable-libssh2         enable ssh block device support
#  --disable-vhdx           disables support for the Microsoft VHDX image format
#  --enable-vhdx            enable support for the Microsoft VHDX image format
#  --disable-quorum         disable quorum block filter support
#  --enable-quorum          enable quorum block filter support
#  --disable-numa           disable libnuma support
#  --enable-numa            enable libnuma support


#--disable-blobs : BIOS needed for x86
#--disable-fdt: Cannot use if supporting ARM

QEMUS_BUILT = "aarch64-softmmu arm-softmmu i386-softmmu mips-softmmu nios2-softmmu xtensa-softmmu riscv32-softmmu riscv64-softmmu sparc-softmmu x86_64-softmmu"
QEMU_FLAGS = "--disable-docs  --disable-sdl --disable-debug-info  --disable-cap-ng \
  --disable-libnfs --disable-libusb --disable-libiscsi --disable-usb-redir --disable-linux-aio\
  --disable-guest-agent --disable-libssh --disable-vnc-png  --disable-seccomp \
  --disable-tpm  --disable-numa --disable-glusterfs \
  --disable-virtfs --disable-xen --disable-curl --disable-attr --disable-curses --disable-iconv \
  --disable-kvm --disable-sheepdog --disable-parallels --disable-replication \
  --disable-live-block-migration --disable-dmg \
  "

copy_seabios() {
    cp ${WORKDIR}/bios-128k.bin ${S}/pc-bios/bios.bin
    cp ${WORKDIR}/bios-256k.bin ${S}/pc-bios/bios-256k.bin
}

do_unpack_append() {
    bb.build.exec_func('copy_seabios', d)
}

do_configure() {
    ${S}/configure ${QEMU_FLAGS} --target-list="${QEMUS_BUILT}" --prefix=${prefix}  \
        --sysconfdir=${sysconfdir} --libexecdir=${libexecdir} --localstatedir=${localstatedir}
}

do_install_append() {
    ln -sf ../xilinx/bin/qemu-system-aarch64 ${D}${bindir}/qemu-system-xilinx-aarch64
}

FILES_${PN} = " \
   /opt/zephyr-sdk \
  "

INSANE_SKIP_${PN} = "already-stripped"
