# Override the source URL for libpcre since the old mirror specified in the
# meta layer is no longer available.

SRC_URI_prepend = "${SOURCEFORGE_MIRROR}/pcre/pcre-${PV}.tar.bz2 "
