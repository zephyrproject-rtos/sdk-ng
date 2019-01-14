require recipes-devtools-arc/gcc/gcc-6.x.arc.inc
require recipes-devtools/gcc/libgcc.inc

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
COMPATIBLE_MACHINE = "arc"

#EXTRA_OECONF_append_arc = " --disable-multilib"
EXTRA_OECONF_append_arc = " --enable-multilib"

# ERROR: QA Issue: Architecture did not match (195 to 93) 
INSANE_SKIP_${PN}-dev += "arch"

# ERROR: QA Issue: non -staticdev package contains static .a library
INSANE_SKIP_${PN}-dev += "staticdev"
