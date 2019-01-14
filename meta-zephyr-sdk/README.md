[![Run Status](https://api.shippable.com/projects/58ffb2b82ddacd0900464db0/badge?branch=master)](https://app.shippable.com/github/zephyrproject-rtos/meta-zephyr-sdk)

# Build Zephyr SDK


Build the SDK in Docker using poky-zephyr-sdk container, follow the instructions below:

```
$ cd $HOME
$ mkdir -p zephyr-sdk
$ git clone git@github.com:zephyrproject-rtos/meta-zephyr-sdk.git zephyr-sdk/meta-zephyr-sdk
$ docker run --privileged --rm -it -v $HOME/zephyr-sdk:/workdir crops/poky-zephyr-sdk --workdir=/workdir
```

Once in the container, clone the repos and build the SDK:

```
workdir$ ./meta-zephyr-sdk/scripts/meta-zephyr-sdk-clone.sh
workdir$ ./meta-zephyr-sdk/scripts/meta-zephyr-sdk-build.sh
```

When finished, the resulting SDK binary can be found under

 workdir/poky/meta-zephyr-sdk/scripts

For more info about container, please see: https://github.com/crops/poky-container

