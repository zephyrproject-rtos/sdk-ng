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
	echo "  $META_POKY_SOURCE/meta-yocto \\" >> $bblayers
	echo "  $META_POKY_SOURCE/meta-yocto-bsp \\" >> $bblayers
	echo "  $META_ZEPHYR_SDK_SOURCE \\" >> $bblayers
	echo "  \" " >> $bblayers

	# Common values for all builds
	localconf=conf/local.conf
	setconf_var "SSTATE_DIR" "$META_SSTATE" $localconf
	setconf_var "DL_DIR" "$META_DOWNLOADS" $localconf
	setconf_var "SDKMACHINE" "x86_64" $localconf
	setconf_var "DISTRO" "zephyr-sdk" $localconf
}


if [ "$1" = "tools" ]; then
header "Building Zephyr host tools..."
newbuild build-zephyr-tools  > /dev/null
setconf_var "MACHINE" "qemux86" $localconf
rm -f ./tmp/deploy/sdk/*.sh
bitbake hosttools-tarball -c clean  > /dev/null
bitbake hosttools-tarball
[ $? -ne 0 ] && echo "Error(s) encountered during bitbake." && exit 1
cp ./tmp/deploy/sdk/*.sh $TOOLCHAINS
[ $? -ne 0 ] && exit 1
echo "Building additional host tools...done"
fi

if [ "$1" = "xtensa" ]; then
# build Xtensa toolchain
header "Building Xtensa toolchain..."
newbuild build-zephyr-xtensa  > /dev/null
setconf_var "MACHINE" "xtensa" $localconf
setconf_var "TCLIBC" "baremetal" $localconf
setconf_var "TOOLCHAIN_TARGET_TASK_append" " newlib xtensa-hal-staticdev" $localconf
rm -f ./tmp/deploy/sdk/*.sh 
bitbake meta-toolchain -c clean  > /dev/null
bitbake meta-toolchain 
[ $? -ne 0 ] && echo "Error(s) encountered during bitbake." && exit 1
cp ./tmp/deploy/sdk/*.sh $TOOLCHAINS
[ $? -ne 0 ] && exit 1
header "Building Xtensa toolchain...done"
fi

if [ "$1" = "riscv32" ]; then
# build RISC-V toolchain
header "Building riscv32 toolchain..."
newbuild build-zephyr-riscv32  > /dev/null
setconf_var "MACHINE" "riscv32" $localconf
setconf_var "TCLIBC" "baremetal" $localconf
setconf_var "TOOLCHAIN_TARGET_TASK_append" " newlib" $localconf
rm -f ./tmp/deploy/sdk/*.sh 
bitbake meta-toolchain -c clean  > /dev/null
bitbake meta-toolchain 
[ $? -ne 0 ] && echo "Error(s) encountered during bitbake." && exit 1
cp ./tmp/deploy/sdk/*.sh $TOOLCHAINS
[ $? -ne 0 ] && exit 1
header "Building riscv32 toolchain...done"
fi

if [ "$1" = "nios2" ]; then
# build NIOS2 toolchain
header "Building Nios2 toolchain..."
newbuild build-zephyr-nios2  > /dev/null
setconf_var "MACHINE" "nios2" $localconf
setconf_var "TCLIBC" "baremetal" $localconf
setconf_var "TOOLCHAIN_TARGET_TASK_append" " newlib" $localconf
rm -f ./tmp/deploy/sdk/*.sh
bitbake meta-toolchain -c clean  > /dev/null
bitbake meta-toolchain
[ $? -ne 0 ] && echo "Error(s) encountered during bitbake." && exit 1
cp ./tmp/deploy/sdk/*.sh $TOOLCHAINS
[ $? -ne 0 ] && exit 1
header "Building Nios2 toolchain...done"
fi

if [ "$1" = "arm" ]; then
# build ARM toolchain
header "Building ARM toolchain..."
newbuild build-zephyr-arm  > /dev/null
setconf_var "MACHINE" "qemuarm" $localconf
setconf_var "TCLIBC" "baremetal" $localconf
setconf_var "TOOLCHAIN_TARGET_TASK_append" " newlib" $localconf
setconf_var "TUNE_FEATURES" "armv7m cortexm3" $localconf
rm -f ./tmp/deploy/sdk/*.sh
bitbake meta-toolchain -c clean  > /dev/null
bitbake meta-toolchain
[ $? -ne 0 ] && echo "Error(s) encountered during bitbake." && exit 1
cp ./tmp/deploy/sdk/*.sh $TOOLCHAINS
[ $? -ne 0 ] && exit 1
header "Building ARM toolchain...done"
fi

if [ "$1" = "x86" ]; then
# build x86 toolchain
header "Building x86 toolchain..."
newbuild build-zephyr-x86 > /dev/null
setconf_var "MACHINE" "qemux86" $localconf
setconf_var "TCLIBC" "baremetal" $localconf
setconf_var "TOOLCHAIN_TARGET_TASK_append" " newlib" $localconf
rm -f ./tmp/deploy/sdk/*.sh
bitbake meta-toolchain -c clean  > /dev/null
bitbake meta-toolchain
[ $? -ne 0 ] && echo "Error(s) encountered during bitbake." && exit 1
cp ./tmp/deploy/sdk/*.sh $TOOLCHAINS
[ $? -ne 0 ] && exit 1
header "Building x86 toolchain...done"
fi

if [ "$1" = "mips" ]; then
#  build MIPS toolchain
header "Building MIPS toolchain..."
newbuild build-zephyr-mips  > /dev/null
setconf_var "MACHINE" "qemumips" $localconf
setconf_var "TCLIBC" "baremetal" $localconf
setconf_var "TOOLCHAIN_TARGET_TASK_append" " newlib" $localconf
rm -f ./tmp/deploy/sdk/*.sh
bitbake meta-toolchain -c clean  > /dev/null
bitbake meta-toolchain
[ $? -ne 0 ] && echo "Error(s) encountered during bitbake." && exit 1
cp ./tmp/deploy/sdk/*.sh $TOOLCHAINS
[ $? -ne 0 ] && exit 1
header "Building MIPS toolchain...done"
fi

if [ "$1" = "arc" ]; then
# build ARC toolchain...
header "Building ARC toolchain..."
newbuild build-zephyr-arc  > /dev/null
setconf_var "MACHINE" "arc" $localconf
setconf_var "TCLIBC" "baremetal" $localconf
setconf_var "TOOLCHAIN_TARGET_TASK_append" " newlib" $localconf
rm -f ./tmp/deploy/sdk/*.sh
bitbake meta-toolchain -c clean  > /dev/null
bitbake meta-toolchain
[ $? -ne 0 ] && echo "Error(s) encountered during bitbake." && exit 1
cp ./tmp/deploy/sdk/*.sh $TOOLCHAINS
[ $? -ne 0 ] && exit 1
header "Building ARC toolchain...done"
fi

if [ "$1" = "iamcu" ]; then
#  build IAMCU toolchain
header "Building IAMCU  toolchain..."
newbuild build-zephyr-iamcu  > /dev/null
setconf_var "MACHINE" "iamcu" $localconf
setconf_var "TCLIBC" "baremetal" $localconf
setconf_var "TOOLCHAIN_TARGET_TASK_append" " newlib" $localconf
rm -f ./tmp/deploy/sdk/*.sh
bitbake meta-toolchain -c clean  > /dev/null
bitbake meta-toolchain
[ $? -ne 0 ] && echo "Error(s) encountered during bitbake." && exit 1
cp ./tmp/deploy/sdk/*.sh $TOOLCHAINS
[ $? -ne 0 ] && exit 1
header "Building IAMCU toolchain...done"
fi
