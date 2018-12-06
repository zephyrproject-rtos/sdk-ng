#!/bin/bash

TARGETS=${@}


if [ -z "$TARGETS" ]; then
	echo "Please specify target"
	exit 1
fi

REQUIRED_VERSION=1.23.0
COMMIT="b82b8adb441001fc1c7f6d5603834861a2de0d2b"
GITDIR=${PWD}
JOBS=$(python -c 'import multiprocessing as mp; print(mp.cpu_count())')

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

if [ "$machine" == "Mac" ]; then
	ImageName=CrossToolNGNew
	ImageNameExt=${ImageName}.sparseimage
	if [ ! -e "$ImageNameExt" ]; then
	diskutil umount force /Volumes/${ImageName} && true
	rm -f ${ImageNameExt} && true
	hdiutil create ${ImageName} -volname ${ImageName} -type SPARSE -size 24g -fs HFSX
	fi
	if [ ! -d "/Volumes/$ImageName" ]; then
		hdiutil mount ${ImageNameExt}
	fi
	cd /Volumes/$ImageName
fi

export SDK_NG_HOME=${PWD}

if [ ! -d "crosstool-ng" ]; then
	git clone https://github.com/crosstool-ng/crosstool-ng.git
	echo "Patching tree"
	pushd crosstool-ng
	git checkout ${COMMIT}
	patch -p1 < ${GITDIR}/patches/0001-iamcu-support-x86-iamcu-ABIs.patch
	popd
fi

if [ ! -e "${SDK_NG_HOME}/bin/ct-ng" ]; then
	pushd crosstool-ng
	./bootstrap
	CFLAGS="-DKBUILD_NO_NLS" ./configure --prefix=${SDK_NG_HOME}
	make && make install
	popd
fi

CT_NG=${SDK_NG_HOME}/bin/ct-ng


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

	${CT_NG} clean
	cp ${GITDIR}/configs/${t}.config .config
	yes "" | ${CT_NG} oldconfig
	${CT_NG} build -j ${JOBS}
	rm -rf  build_${t}

	popd

done
