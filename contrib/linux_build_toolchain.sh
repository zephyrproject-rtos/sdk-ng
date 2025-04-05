#!/usr/bin/env bash

# Script to mimic how CI is building individual toolchain.

# Default is to use current directory as the working directory.
# SDK is under ${WORKING_ROOT_DIR}/sdk-ng/
# Build directory is ${WORKING_ROOT_DIR}/build-workspace/
WORKING_ROOT_DIR="${PWD}"
SDK_DIR="${WORKING_ROOT_DIR}/sdk-ng"
BUILD_DIR="${WORKING_ROOT_DIR}/build-workspace"

function usage()
{
	echo "Usage: $0 -c <config file name> [-s SDK directory] [-o Build directory] [-h]"
	echo ""
	echo "Arguments:"
	echo ""
	echo "  -c Name of config file (without extension .config)"
	echo ""
	echo "  -s SDK directory. Optional."
	echo "     Default is ${SDK_DIR}"
	echo ""
	echo "  -o Build directory, for building artifacts and final output. Optional."
	echo "     Default is ${BUILD_DIR}"
	echo ""
	echo "  -h This help."
	echo ""
}

while getopts "hc:s:o:" ARGS; do
	case ${ARGS} in
	h)
		usage
		exit 1
		;;
	c)
		CONFIG_FILE_NAME="${OPTARG}"
		;;
	s)
		SDK_DIR="${OPTARG}"
		;;
	o)
		BUILD_DIR="${OPTARG}"
		;;
	*)
		echo "Unknown arguments: $1"
		exit 1
		;;
	esac
done

if [[ "${CONFIG_FILE_NAME}" == "" ]]; then
	usage
	exit 1
fi

# These variables are the same as the CI script.
export GITHUB_WORKSPACE="${SDK_DIR}"
export WORKSPACE="${BUILD_DIR}"

export CT_PREFIX="${WORKSPACE}"/output
export CT_NG="${WORKSPACE}"/crosstool-ng/bin/ct-ng

TOOLCHAIN_OUTPUT_DIR="${WORKSPACE}"/output/${CONFIG_FILE_NAME}

echo "SDK directory: ${GITHUB_WORKSPACE}"
echo "Build directory: ${WORKSPACE}"

SDK_CONFIG_FILE="${GITHUB_WORKSPACE}/configs/${CONFIG_FILE_NAME}.config"

if [[ ! -f "${SDK_CONFIG_FILE}" ]]; then
	echo "ERROR: ${SDK_CONFIG_FILE} does not exist!"
	exit 1
fi

echo "Build config file: ${SDK_CONFIG_FILE}"
echo "Toolchain output directory: ${TOOLCHAIN_OUTPUT_DIR}"

if [[ ! -x "${WORKSPACE}/crosstool-ng/bin/ct-ng" ]]; then
	echo "========== Building ct-ng =========="

	# Create build directory
	pushd "${WORKSPACE}" || exit 1
	mkdir -p crosstool-ng-build
	cd crosstool-ng-build || exit 1

	# Bootstrap crosstool-ng
	pushd "${GITHUB_WORKSPACE}"/crosstool-ng || exit 1
	./bootstrap
	popd || exit 1

	# Build and install crosstool-ng
	"${GITHUB_WORKSPACE}"/crosstool-ng/configure --prefix="${WORKSPACE}"/crosstool-ng
	make
	make install

	popd || exit 1

	${CT_NG} version
fi

echo "========== Building Toolchain for ${CONFIG_FILE_NAME} =========="

BUILD_DIR="${WORKSPACE}"/build-${CONFIG_FILE_NAME}

pushd "${WORKSPACE}" || exit 1

mkdir -p "${BUILD_DIR}"
pushd "${BUILD_DIR}" || exit 1

cat "${GITHUB_WORKSPACE}"/configs/common.config "${SDK_CONFIG_FILE}" > .config

cat << 'EOF' >> .config
CT_SHOW_CT_VERSION=n
CT_LOCAL_TARBALLS_DIR="${WORKSPACE}/sources"
CT_OVERLAY_LOCATION="${GITHUB_WORKSPACE}/overlays"
CT_LOG_PROGRESS_BAR=n
CT_LOG_EXTRA=y
CT_LOG_LEVEL_MAX="EXTRA"
CT_GDB_CROSS_PYTHON=y
CT_GDB_CROSS_PYTHON_VARIANT=y
CT_GDB_CROSS_PYTHON_BINARY="python3.10"
CT_EXPERIMENTAL=y
CT_ALLOW_BUILD_AS_ROOT=y
CT_ALLOW_BUILD_AS_ROOT_SURE=y
EOF

"${CT_NG}" savedefconfig DEFCONFIG=build.config
"${CT_NG}" distclean
"${CT_NG}" defconfig DEFCONFIG=build.config

"${CT_NG}" build || exit 1

chmod -R u+w "${TOOLCHAIN_OUTPUT_DIR}"

pushd "${TOOLCHAIN_OUTPUT_DIR}" || exit 1
rm -rf newlib-nano
rm -f build.log.bz2
popd || exit 1

popd || exit 1

popd || exit 1

echo "========== Done =========="
echo "Toolchain is available under: ${TOOLCHAIN_OUTPUT_DIR}"
