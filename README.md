# Zephyr SDK with Crosstool NG

This project is to replace the current Yocto based SDK with a new framework for
building the Zephyr SDK using crosstool-ng.

The repoistory consists of configurations for the various architectures (not
fully tests) and a script that builds on Linux and Mac in a consistent way,
apply patches where needed.

Currently we build the following toolchains:
- i586
- nios2
- arm
- arm64
- riscv64
- sparc
- xtensa

To build for any of the above, run:

```
./go.sh <arch>
```

## PR Builds

Successfull PR builds will get posted here:

https://builds.zephyrproject.org/zephyrproject-rtos/sdk-ng/<PR NUMBER>/zephyr-sdk-<VERISON>-setup.run

## Release Process

To release a new SDK:

- Update the VERSION file with the new version, for example 0.11.0 or
  0.11.0-beta1 etc.
- On https://github.com/zephyrproject-rtos/sdk-ng/releases, create the release
  tag and add the release information.
- One the release is created, CI will build the SDK image and will upload it to
  the release page.
