#!/bin/bash
#
# Copyright (C) 2015-2016, Intel Corporation.
# All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
#

META_ZEPHYR_SDK_SOURCE=${SDK_SOURCE:-"meta-zephyr-sdk"}
META_POKY_SOURCE=${POKY_SOURCE:-"poky"}
META_ZEPHYR_SDK_SOURCE=$(readlink -f $META_ZEPHYR_SDK_SOURCE)
META_POKY_SOURCE=$(readlink -f $META_POKY_SOURCE)

TOOLCHAINS="${META_ZEPHYR_SDK_SOURCE}/scripts/toolchains"
META_DOWNLOADS=${META_DOWNLOADS:-"$META_POKY_SOURCE/downloads"}
META_SSTATE=${SSTATE_LOCATION:-"$META_POKY_SOURCE/sstate"}

MACHINE=${MACHINE:-$(uname -m)}

if [ ! -d $META_ZEPHYR_SDK_SOURCE ] ; then
	echo "ERROR: could not find $META_ZEPHYR_SDK_SOURCE"
	exit 1
fi

if [ ! -d $META_POKY_SOURCE ] ; then
	echo "ERROR: could not find $META_POKY_SOURCE"
	exit 1
fi

if [ ! -d $META_DOWNLOADS ] ; then
	mkdir -p $META_DOWNLOADS
fi
export DL_DIR=$META_DOWNLOADS

if [ ! -d $TOOLCHAINS ] ; then
	mkdir -p $TOOLCHAINS
fi
rm -rf $TOOLCHAINS/*

export ZEPHYR_SDK_QEMU_SRCREV=$(cd qemu; git rev-parse HEAD)
export BB_ENV_PASSTHROUGH_ADDITIONS="${BB_ENV_PASSTHROUGH_ADDITIONS} ZEPHYR_SDK_QEMU_SRCREV"

# setconf_var, i.e. "MACHINE","qemuarm",$localconf
setconf_var()
{
	sed -i "/^$1=/d" $3
	echo "$1=\"$2\"" >> $3
	echo $1="$2"
}

header ()
{
echo ""
echo "########################################################################"
echo "    $1"
echo "########################################################################"
}

newbuild()
{
	cd $META_POKY_SOURCE
	source oe-init-build-env $1

	# Create bblayers.conf
	bblayers=conf/bblayers.conf

	echo "# LAYER_CONF_VERSION is increased each time build/conf/bblayers.conf" > $bblayers
	echo "# changes incompatibly" >> $bblayers
	echo "LCONF_VERSION = \"6\"" >> $bblayers
	echo "" >> $bblayers
	echo "BBPATH = \"\${TOPDIR}\"" >> $bblayers
	echo "BBFILES ?= \"\"" >> $bblayers
	echo "BBLAYERS ?= \" \\" >> $bblayers
	echo "  $META_POKY_SOURCE/meta \\" >> $bblayers
	echo "  $META_POKY_SOURCE/meta-poky \\" >> $bblayers
	echo "  $META_POKY_SOURCE/meta-yocto-bsp \\" >> $bblayers
	echo "  $META_ZEPHYR_SDK_SOURCE \\" >> $bblayers
	echo "  \" " >> $bblayers

	# Common values for all builds
	localconf=conf/local.conf
	setconf_var "SSTATE_DIR" "$META_SSTATE" $localconf
	setconf_var "DL_DIR" "$META_DOWNLOADS" $localconf
	setconf_var "SDKMACHINE" "$MACHINE" $localconf
	setconf_var "DISTRO" "zephyr-sdk" $localconf
}


if [ "$1" = "tools" ]; then
header "Building Zephyr host tools..."
newbuild build-zephyr-tools  > /dev/null
	if [ "$MACHINE" = "aarch64" ]; then
		POKY_MACHINE=qemuarm64
	else
		POKY_MACHINE=qemux86
	fi
setconf_var "MACHINE" "$POKY_MACHINE" $localconf
rm -f ./tmp/deploy/sdk/*.sh
bitbake hosttools-tarball -c clean  > /dev/null
bitbake hosttools-tarball
[ $? -ne 0 ] && echo "Error(s) encountered during bitbake." && exit 1
cp ./tmp/deploy/sdk/*.sh $TOOLCHAINS
[ $? -ne 0 ] && exit 1
echo "Building additional host tools...done"
fi
