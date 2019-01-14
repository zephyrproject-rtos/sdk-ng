FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://0043-arm-multilib.patch"
SRC_URI += "file://nios2-multilib.patch"

# Patches to implement soft-float (multilib) for x86
SRC_URI += "file://x86-multilib.patch"
SRC_URI += "file://config-x86-multi-gcc.patch"
SRC_URI += "file://config-libgcc-softfp.patch"
SRC_URI += "file://libgcc-t-zephyr.patch"

EXTRA_OECONF_append = " --enable-plugin "
