SANITY_TESTED_DISTROS = " \
            Ubuntu-14.04 \n \
            Ubuntu-15.04 \n \
            Ubuntu-16.04 \n \
            Fedora-23 \n \
            "

DISTRO = "zephyr-sdk"
DISTRO_CODENAME = "zephyr-sdk"
DISTRO_NAME = "Zephyr Yocto Toolchain"
MAINTAINER = "Intel Yocto team"

SSTATE_DIR ?= "${TOPDIR}/../zephyr-cache/sstate-cache"
CACHE_forcevariable = "${TOPDIR}/../zephyr-cache/cache"
PERSISTENT_DIR = "${TOPDIR}/../zephyr-cache/persistent"
DL_DIR ?= "${TOPDIR}/../zephyr-downloads"
