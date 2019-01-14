SRCREV = "78e113e81c9d33d0f33704b187a46399d5a75419"
PV = "1.4.7+git"
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

do_install () {
        oe_runmake install NO_PYTHON=1
}

FILES_${PN}-misc_append = "${bindir}/fdtoverlay ${bindir}/fdtput ${bindir}/fdtget"
