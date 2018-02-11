#!/bin/bash

TARGETS=${@}


if [ -z "$TARGETS" ]; then
	echo "Please specify target"
	exit 1
fi

REQUIRED_VERSION=1.23.0
COMMIT="aca85cbb"
GITDIR=${PWD}

ct-ng 2>&1 | grep crosstool-ng-${REQUIRED_VERSION} | grep ${COMMIT}
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

if [ -z "$CTNG_INSTALLED" ]; then
	if [ ! -d "crosstool-ng" ]; then
		git clone https://github.com/crosstool-ng/crosstool-ng.git
	fi
	pushd crosstool-ng
	git checkout aca85cbb3d9cf0247674464a55246029d5820114
	if [[ -n $(git status --porcelain) ]]; then
		patch -p1 < ${GITDIR}/patches/0001-iamcu-support-x86-iamcu-ABIs.patch
	fi
	./bootstrap
	./configure
	make && sudo make install
	popd
else
	echo "ctng already installed with correct version"
fi
mkdir -p build
cd build
export CT_PREFIX=`pwd`/output
mkdir -p ${CT_PREFIX}/sources
for t in ${TARGETS}; do
	if [ ! -f ${GITDIR}/configs/${t}.config ]; then
		echo "Target configuration does not exist"
		exit 1
	fi
	echo "Building ${t}"
	mkdir -p build_${t}
	pushd build_${t}

	ct-ng clean
	cp ${GITDIR}/configs/${t}.config .config
	yes "" | ct-ng oldconfig
	ct-ng build

	popd

done
