#!/bin/sh
#
# The folder "toolchains" should contain the toolchains and host tools
# This script merges all files into a single installable file.
#
# SDK should follow a vM.m versioning scheme
#
# Major versions for big interface/usage changes
# Minor versions for additions of interfaces, transparent changes
#
# Default installation directory should be $HOME/zephyr-sdk/
#

product_name="zephyr-sdk"

root_dir=$(dirname $0)/..
sdk_version=$(cat $root_dir/VERSION)

echo "Creating ${product_name}-${sdk_version}-setup.run"

# Create ./setup.sh


setup=toolchains/setup.sh
default_dir=\${HOME}/${product_name}/
toolchain_name=${product_name}-${sdk_version}-setup.run
version_dir=info-zephyr-sdk-${sdk_version}

# Identify files present in toolchains folder

parse_toolchain_name()
{
    local varname=$1
    local arch=$2
    local num
    local filename

    num=$(ls toolchains | grep $arch | wc -l)
    if [ "$num" -gt "1" ]; then
        echo "Error: Multiple toolchains for \"$arch\" "
        exit 1
    fi

    if [ "$num" -eq "0" ]; then
        echo "Warning: Missing toolchain for \"$arch\" "
    fi

    filename=$(ls toolchains | grep $arch)
    eval "$varname=\$filename"
}

parse_toolchain_name file_gcc_arm arm
parse_toolchain_name file_gcc_arc arc
parse_toolchain_name file_gcc_x86 i586
#parse_toolchain_name file_gcc_mips mips
parse_toolchain_name file_gcc_nios2 nios2
parse_toolchain_name file_gcc_xtensa xtensa
parse_toolchain_name file_gcc_riscv64 riscv64
parse_toolchain_name file_gcc_x86_64 x86_64-zephyr-elf
parse_toolchain_name file_gcc_xtensa_sample_controller xtensa_sample_controller
parse_toolchain_name file_gcc_xtensa_intel_apl_adsp xtensa_intel_apl_adsp
parse_toolchain_name file_hosttools hosttools

# Host tools are non-optional
if  [ -z "$file_hosttools" ]; then
  echo "Error: Missing host tools!"
  exit 1
fi

echo '#!/bin/bash' > $setup
echo "DEFAULT_INSTALL_DIR=$default_dir" >> $setup
echo "TOOLCHAIN_NAME=$toolchain_name" >> $setup
echo "VERSION_DIR=$version_dir" >> $setup
echo "SDK_VERSION=${sdk_version}" >> $setup

cat template_dir >>$setup

if [ -n "$file_gcc_x86" ]; then
  echo "tar -C \$target_sdk_dir -jxf ./$file_gcc_x86 > /dev/null &" >> $setup
  echo "spinner \$! \"Installing x86 tools...\"" >> $setup
  echo "[ \$? -ne 0 ] && echo \"Error(s) encountered during installation.\" && exit 1" >>$setup
  echo "echo \"\"" >>$setup
fi

if [ -n "$file_gcc_arm" ]; then
  echo "tar -C \$target_sdk_dir -jxf ./$file_gcc_arm > /dev/null &" >> $setup
  echo "spinner \$! \"Installing arm tools...\"" >> $setup
  echo "[ \$? -ne 0 ] && echo \"Error(s) encountered during installation.\" && exit 1" >>$setup
  echo "echo \"\"" >>$setup
fi

if [ -n "$file_gcc_arc" ]; then
  echo "tar -C \$target_sdk_dir -jxf ./$file_gcc_arc > /dev/null &" >> $setup
  echo "spinner \$!  \"Installing arc tools...\"" >> $setup
  echo "[ \$? -ne 0 ] && echo \"Error(s) encountered during installation.\" && exit 1" >>$setup
  echo "echo \"\"" >>$setup
fi

#if [ -n "$file_gcc_mips" ]; then
#  echo "tar -C \$target_sdk_dir -jxf ./$file_gcc_mips > /dev/null &" >> $setup
#  echo "spinner \$!  \"Installing mips tools...\"" >> $setup
#  echo "[ \$? -ne 0 ] && echo \"Error(s) encountered during installation.\" && exit 1" >>$setup
#  echo "echo \"\"" >>$setup
#fi

if [ -n "$file_gcc_nios2" ]; then
  echo "tar -C \$target_sdk_dir -jxf ./$file_gcc_nios2 > /dev/null &" >> $setup
  echo "spinner \$!  \"Installing nios2 tools...\"" >> $setup
  echo "[ \$? -ne 0 ] && echo \"Error(s) encountered during installation.\" && exit 1" >>$setup
  echo "echo \"\"" >>$setup
fi

if [ -n "$file_gcc_xtensa" ]; then
  echo "tar -C \$target_sdk_dir -jxf ./$file_gcc_xtensa > /dev/null &" >> $setup
  echo "spinner \$!  \"Installing xtensa tools...\"" >> $setup
  echo "[ \$? -ne 0 ] && echo \"Error(s) encountered during installation.\" && exit 1" >>$setup
  echo "echo \"\"" >>$setup
fi

if [ -n "$file_gcc_riscv64" ]; then
  echo "tar -C \$target_sdk_dir -jxf ./$file_gcc_riscv64 > /dev/null &" >> $setup
  echo "spinner \$!  \"Installing riscv64 tools...\"" >> $setup
  echo "[ \$? -ne 0 ] && echo \"Error(s) encountered during installation.\" && exit 1" >>$setup
  echo "echo \"\"" >>$setup
fi

if [ -n "$file_gcc_x86_64" ]; then
  echo "tar -C \$target_sdk_dir -jxf ./$file_gcc_x86_64 > /dev/null &" >> $setup
  echo "spinner \$!  \"Installing x86_64 tools...\"" >> $setup
  echo "[ \$? -ne 0 ] && echo \"Error(s) encountered during installation.\" && exit 1" >>$setup
  echo "echo \"\"" >>$setup
fi

if [ -n "$file_gcc_xtensa_sample_controller" ]; then
  echo "tar -C \$target_sdk_dir -jxf ./$file_gcc_xtensa_sample_controller > /dev/null &" >> $setup
  echo "spinner \$!  \"Installing xtensa sample_controller tools...\"" >> $setup
  echo "[ \$? -ne 0 ] && echo \"Error(s) encountered during installation.\" && exit 1" >>$setup
  echo "echo \"\"" >>$setup
fi

if [ -n "$file_gcc_xtensa_intel_apl_adsp" ]; then
  echo "tar -C \$target_sdk_dir -jxf ./$file_gcc_xtensa_intel_apl_adsp > /dev/null &" >> $setup
  echo "spinner \$!  \"Installing xtensa intel_apl_adsp tools...\"" >> $setup
  echo "[ \$? -ne 0 ] && echo \"Error(s) encountered during installation.\" && exit 1" >>$setup
  echo "echo \"\"" >>$setup
fi

if [ -n "$file_hosttools" ]; then
  echo "./$file_hosttools -y -d \$target_sdk_dir > /dev/null &" >> $setup
  echo "spinner \$! \"Installing additional host tools...\"" >> $setup
  echo "[ \$? -ne 0 ] && echo \"Error(s) encountered during installation.\" && exit 1" >>$setup
  echo "echo \"\"" >>$setup
fi


echo "" >>$setup
echo "do_cleanup"  >>$setup
echo "" >>$setup

echo "echo \"Success installing SDK. SDK is ready to be used.\"" >>$setup
chmod 777 $setup

makeself toolchains/ $toolchain_name  "SDK for Zephyr" ./setup.sh
