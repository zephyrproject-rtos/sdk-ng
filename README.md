# Zephyr SDK with Crosstool NG

This project is to replace the previous Yocto based SDK with a new framework for
building the Zephyr SDK using [crosstool-ng](https://crosstool-ng.github.io/).

The repository consists of configurations for the various architectures (not
fully tests) and a script that builds on Linux (x86_64) and Mac in a consistent
way, apply patches where needed.

Currently we build the following toolchains:
- i586
- nios2
- arc
- arc64
- arm
- arm64
- riscv64
- sparc
- mips
- xtensa (sample_controller, intel_apl_adsp, intel_s1000, intel_bdw_adsp,
intel_byt_adsp, nxp_imx_adsp, nxp_imx8m_adsp, esp32)

To build for any of the above, run:

```
./go.sh <arch>
```

Production builds are done using the script in `.shippable.yml` which
identifies some packages you'll need to have installed for the above
command to work.

When building locally be aware that `./go.sh` is written assuming it's
invoked in a pristine workspace.  That means if you pull an update of
this repository `./go.sh` will not update the `crosstool-ng` source and
rebuild the `bin/ct-ng` utility to match the update configuration.  This
can produce very confusing results.

## Released Binaries packages

Pre-built binaries releases of the SDK are made and currently only available for
an x86_64 Linux host environment.  The releases can be found here:

https://github.com/zephyrproject-rtos/sdk-ng/releases

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
