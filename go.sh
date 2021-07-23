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
machine="$(uname -m)"
case "${unameOut}" in
    Linux*)     os=linux;;
    Darwin*)    os=macos;;
    CYGWIN*)    os=cygwin;;
    MINGW*)     os=mingw;;
    *)          os="UNKNOWN:${unameOut}"
esac

SDK_NG_HOME=${PWD}

if [ "$os" == "macos" ]; then
	if [ -x "/opt/homebrew/bin/brew" ]; then
		export HOMEBREW_ROOT="/opt/homebrew"
	elif [ -x "/usr/local/bin/brew" ]; then
		export HOMEBREW_ROOT="/usr/local"
	else
		echo "No brew install found"
		exit 1
	fi
	export PATH="$PATH:${HOMEBREW_ROOT}/opt/binutils/bin"
	export CPPFLAGS="-I${HOMEBREW_ROOT}/opt/ncurses/include -I${HOMEBREW_ROOT}/opt/gettext/include"
	export LDFLAGS="-L${HOMEBREW_ROOT}/opt/ncurses/lib -L${HOMEBREW_ROOT}/opt/gettext/lib"

	ImageName=CrossToolNGNew
	ImageNameExt=${ImageName}.sparseimage
	SDK_NG_HOME="/Volumes/${ImageName}"
	if [ ! -e "$ImageNameExt" ]; then
		diskutil umount force ${SDK_NG_HOME} && true
		rm -f ${ImageNameExt} && true
		hdiutil create ${ImageName} -volname ${ImageName} -type SPARSE -size 64g -fs HFSX
	fi
	if [ ! -d ${SDK_NG_HOME} ]; then
		hdiutil mount ${ImageNameExt}
	fi
fi

cp -a ${GITDIR}/patches-arc64 ${SDK_NG_HOME} 2>/dev/null
cd ${SDK_NG_HOME}

for t in ${TARGETS}; do
	if [ "${t}" = "tools" ]; then
		./meta-zephyr-sdk/scripts/meta-zephyr-sdk-clone.sh;
		./meta-zephyr-sdk/scripts/meta-zephyr-sdk-build.sh tools;
		mv ./meta-zephyr-sdk/scripts/toolchains/zephyr-sdk-${machine}-hosttools-standalone-0.9.sh .
	elif [ "${t}" = "cmake" ]; then
		tar -jcvf ${t}.${os}.${machine}.tar.bz2 -C ${GITDIR} cmake
	fi
done

if [ ! -d "crosstool-ng" ]; then
	git clone https://github.com/zephyrproject-rtos/crosstool-ng.git
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
OUTPUT_DIR=${SDK_NG_HOME}/build/output

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
	TARGET_BUILD_DIR=${SDK_NG_HOME}/build/build_${t}
	mkdir -p ${TARGET_BUILD_DIR}
	pushd ${TARGET_BUILD_DIR}

	case "${t}" in
		xtensa_*)
			cp -a ${GITDIR}/overlays ${TARGET_BUILD_DIR}
			export CT_PREFIX=${OUTPUT_DIR}/xtensa/${t#xtensa_}
			mkdir -p ${CT_PREFIX}
			;;
		*)
			export CT_PREFIX=${OUTPUT_DIR}
			;;
	esac

	${CT_NG} clean
	cp ${GITDIR}/configs/${t}.config ${TARGET_BUILD_DIR}/defconfig

	# Disable python support in GDB on MacOS, this isn't currently working.
	# It builds ok, but the resulting GDB segfaults.
	if [ "$os" == "macos" ]; then
		sed -i -e '/CT_GDB_CROSS_PYTHON_BINARY/d' defconfig
		sed -i -e '/CT_GDB_CROSS_BUILD_NO_PYTHON/d' defconfig
		sed -i -e '/^CT_CC_GCC_EXTRA_CONFIG_ARRAY=/ s/"$/ --without-zstd"/' defconfig
		echo "# CT_GDB_CROSS_PYTHON is not set" >> defconfig
	fi

	${CT_NG} defconfig DEFCONFIG=${TARGET_BUILD_DIR}/defconfig
	${CT_NG} savedefconfig DEFCONFIG=${TARGET_BUILD_DIR}${t}.config
	${CT_NG} build -j ${JOBS}
	if [ $? != 0 ]; then
		exit 1
	fi
	rm -rf ${CT_PREFIX}/*/newlib-nano

	popd
	rm -fr ${SDK_NG_HOME}/build/build_${t}
done
