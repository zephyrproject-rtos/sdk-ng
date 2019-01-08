#!/bin/bash

TARGETS=${@}


if [ -z "$TARGETS" ]; then
	echo "Please specify target"
	exit 1
fi
if [ "$TARGETS" == "all" ]; then
	TARGETS=$(ls -1 configs/ | sed 's/.config//')
fi

REQUIRED_VERSION=1.23.0
COMMIT="f8874f447e40852d33d65c1f443a90b0760901df"
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

	build_toolchain=1
	if [ -n "${build_toolchain}" ]; then
		cp -a ${SDK_NG_HOME}/overlays .

		${CT_NG} clean
		${CT_NG} defconfig DEFCONFIG=${GITDIR}/configs/${t}.config
		${CT_NG} savedefconfig DEFCONFIG=${t}.config
		${CT_NG} build -j ${JOBS}
	fi

	if [ "${t}" = "xtensa" ]; then
		wget https://github.com/foss-xtensa/xtensa-hal/archive/RF-2015.2.tar.gz
		tar xf RF-2015.2.tar.gz
		cd xtensa-hal-RF-2015.2
		wget https://github.com/foss-xtensa/xtensa-config/releases/download/201702/sample_controller_linux.tgz
		./import-core.sh sample_controller_linux.tgz
		export CC=${CT_PREFIX}/xtensa-zephyr-elf/bin/xtensa-zephyr-elf-gcc
		./configure --host xtensa-zephyr-elf --prefix ${CT_PREFIX}/xtensa-zephyr-elf
		make
		make install
		unset CC
	fi

	popd
	rm -rf  build_${t}

done
