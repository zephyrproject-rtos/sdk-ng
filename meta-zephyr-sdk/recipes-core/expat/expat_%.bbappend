# Override the source URL for expat since the old mirror specified in the meta
# layer is no longer available.

VERSION_TAG = "${@d.getVar('PV').replace('.', '_')}"

SRC_URI_prepend = "https://github.com/libexpat/libexpat/releases/download/R_${VERSION_TAG}/expat-${PV}.tar.bz2 "
