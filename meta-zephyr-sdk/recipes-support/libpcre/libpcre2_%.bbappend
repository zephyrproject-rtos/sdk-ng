# Override the source URL for libpcre2 since the old mirror specified in the
# meta layer is no longer available.

SRC_URI:prepend = "https://github.com/PhilipHazel/pcre2/releases/download/pcre2-${PV}/pcre2-${PV}.tar.bz2 "
