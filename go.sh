#!/bin/bash

TARGETS=${@}


if [ -z "$TARGETS" ]; then
	echo "Please specify target"
	exit 1
fi
if [ "$TARGETS" == "all" ]; then
	TARGETS=$(ls -1 configs/ | sed 's/.config//')
	TARGETS=${TARGETS}" tools"
fi

COMMIT="4d5660e34e7c5f522e8b07ded82d7a6a15b787ef"
GITDIR=${PWD}
JOBS=$(python -c 'import multiprocessing as mp; print(mp.cpu_count())')

unameOut="$(uname -s)"
unameMachine="$(uname -m)"
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
	hdiutil create ${ImageName} -volname ${ImageName} -type SPARSE -size 64g -fs HFSX
	fi
	if [ ! -d "/Volumes/$ImageName" ]; then
		hdiutil mount ${ImageNameExt}
	fi
	cp -a patches /Volumes/$ImageName
	cp -a overlays /Volumes/$ImageName
	cd /Volumes/$ImageName
fi

export SDK_NG_HOME=${PWD}

for t in ${TARGETS}; do
	if [ "${t}" = "tools" ]; then
		./meta-zephyr-sdk/scripts/meta-zephyr-sdk-clone.sh;
		./meta-zephyr-sdk/scripts/meta-zephyr-sdk-build.sh tools;
		mv ./meta-zephyr-sdk/scripts/toolchains/zephyr-sdk-${unameMachine}-hosttools-standalone-0.9.sh .
	elif [ "${t}" = "cmake" ]; then
		tar -jcvf ${t}.${unameMachine}.tar.bz2 -C ${SDK_NG_HOME} cmake;
	fi
done

if [ ! -d "crosstool-ng" ]; then
	git clone https://github.com/zephyrproject-rtos/crosstool-ng.git
	echo "Patching tree"
	pushd crosstool-ng
	git checkout ${COMMIT}
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
export OUTPUT_DIR=`pwd`/output
mkdir -p ${OUTPUT_DIR}/sources
for t in ${TARGETS}; do
	if [ "${t}" = "tools" ]; then
		# We handled tools above, so skip it here
		continue
	elif [ "${t}" = "cmake" ]; then
		# We handled cmake above, so skip it here
		continue
	fi
	if [ ! -f ${GITDIR}/configs/${t}.config ]; then
		echo "Target configuration does not exist"
		exit 1
	fi
	echo "Building ${t}"
	mkdir -p build_${t}
	pushd build_${t}

	build_toolchain=1
	if [ -n "${build_toolchain}" ]; then
		case "${t}" in
			xtensa_*)
				cp -a ${SDK_NG_HOME}/overlays .
				export CT_PREFIX=${OUTPUT_DIR}/xtensa/${t#xtensa_}
				mkdir -p ${CT_PREFIX}
				;;
			*)
				export CT_PREFIX=${OUTPUT_DIR}
				;;
		esac

		${CT_NG} clean
		${CT_NG} defconfig DEFCONFIG=${GITDIR}/configs/${t}.config
		${CT_NG} savedefconfig DEFCONFIG=${t}.config
		${CT_NG} build -j ${JOBS}
		if [ $? != 0 ]; then
			exit 1
		fi
		rm -rf ${CT_PREFIX}/*/newlib-nano
	fi

	popd
	test -n ${DEBUG_BUILD} || rm -rf  build_${t}

done
