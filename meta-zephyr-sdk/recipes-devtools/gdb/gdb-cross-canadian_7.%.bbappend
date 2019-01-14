FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://Add-Intel-MCU-support-to-gdb.patch"
SRC_URI += "file://0001-gdb-xtensa-handle-privileged-registers.patch"

EXTRA_OECONF_remove = "--disable-tui"
EXTRA_OECONF_append = " --enable-tui"
EXTRA_OECONF_remove = "--disable-gdbmi"
EXTRA_OECONF_append = " --enable-gdbmi"
