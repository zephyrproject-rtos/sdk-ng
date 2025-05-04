sudo apt install autoconf libgmp3-dev libncurses-dev flex texinfo unzip help2man libtool libtool-bin bison

./contrib/linux_build_toolchain.sh -c arm-zephyr-eabi -s /home/txie/sdk-ng-atomic -o /home/txie/sdk-build

fetch tags:

git fetch --tags https://github.com/zephyrproject-rtos/sdk-ng

