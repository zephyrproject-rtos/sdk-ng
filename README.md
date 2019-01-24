# Zephyr SDK with Crosstool NG

This project is to replace the current Yocto based SDK with a new framework for
building the Zephyr SDK using crosstool-ng.

The repoistory consists of configurations for the various architectures (not
fully tests) and a script that builds on Linux and Mac in a consistent way,
apply patches where needed.

Currently we build the following toolchains:
- i586
- iamcu
- nios2
- arm
- riscv32 (experimental branch)
- mips

To build for any of the above, run:

```
./go.sh <arch>
```


## Release Process

To release a new SDK:

- Update the VERSION file with the new version, for example 0.11.0 or
  0.11.0-beta1 etc.
- On https://github.com/zephyrproject-rtos/sdk-ng/releases, create the release
  tag and add the release information.
- One the release is created, CI will build the SDK image and will upload it to
  the release page.
