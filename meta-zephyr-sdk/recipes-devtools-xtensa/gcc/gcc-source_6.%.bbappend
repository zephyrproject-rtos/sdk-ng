# Copy gcc overlay files into the source tree before applying patches.

python do_patch_prepend_xtensa () {
    os.system('tar -xf ' + d.getVar('STAGING_DIR_TARGET', True) +
              '/usr/src/xtensa-config/xtensa-overlay.tar.gz --strip-components=1 -C ' +
              d.getVar('S', True) + ' gcc')
}

do_patch[depends] += "xtensa-config:do_populate_sysroot"
