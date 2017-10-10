#!/bin/bash

TARGET=${1}

if [ -z "$TARGET" ]; then
	echo "Please specify target"
	exit 1
fi
REQUIRED_VERSION=1.23.0
GITDIR=${PWD}
ct-ng > /dev/null 2>&1 | grep crosstool-ng-${REQUIRED_VERSION}
if [ "$?" == "0" ]; then
	CTNG_INSTALLED=1
fi

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [ "$machine" == "Mac" ]; then
	ImageName=CrossToolNG
	ImageNameExt=${ImageName}.sparseimage
	if [ ! -e "$ImageNameExt" ]; then
	diskutil umount force /Volumes/${ImageName} && true
	rm -f ${ImageNameExt} && true
	hdiutil create ${ImageName} -volname ${ImageName} -type SPARSE -size 8g -fs HFSX
	fi
	if [ ! -d "/Volumes/$ImageName" ]; then
		hdiutil mount ${ImageNameExt}
	fi
	cd /Volumes/$ImageName
fi

if [ -n "$CTNG_INSTALLED" ]; then
	if [ ! -e "crosstool-ng-${REQUIRED_VERSION}.tar.bz2" ]; then
		wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-${REQUIRED_VERSION}.tar.bz2
	fi
	rm -rf crosstool-ng-${REQUIRED_VERSION}
	tar xf crosstool-ng-${REQUIRED_VERSION}.tar.bz2


	pushd crosstool-ng-${REQUIRED_VERSION}/
	patch -p1 < ${GITDIR}/patches/0001-iamcu-support-x86-iamcu-ABIs.patch
	./configure
	make && make install
	popd
fi

mkdir -p build
cd build
export CT_PREFIX=`pwd`/output
mkdir -p ${CT_PREFIX}/sources
ct-ng clean
cp ${GITDIR}/configs/${TARGET}.config .config
ct-ng oldconfig
ct-ng build
