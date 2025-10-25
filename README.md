# Zephyr SDK

The Zephyr Software Development Kit (SDK) includes the toolchains for all
supported target architectures as well as the host tools, such as QEMU and
OpenOCD, for testing and debugging the Zephyr RTOS.

The toolchains for the following target architectures are supported:

- ARC (32-bit and 64-bit; ARCv1, ARCv2, ARCv3)
- ARM (32-bit and 64-bit; ARMv6, ARMv7, ARMv8; A/R/M Profiles)
- Microblaze (32-bit)
- MIPS (32-bit and 64-bit)
- Nios II
- OpenRISC 1000
- RISC-V (32-bit and 64-bit; RV32I, RV32E, RV64I)
- RX
- SPARC (32-bit and 64-bit; SPARC V8, SPARC V9)
- x86 (32-bit and 64-bit)
- Xtensa (sample_controller and other vendor-specific variants)

The following host tools are available as part of the Zephyr SDK:

- BOSSA
- OpenOCD
- QEMU
- Xilinx QEMU
- stm32flash

## Releases

The Zephyr SDK bundle releases are available for the following host platforms:

- Linux (AArch64, x86-64)
- macOS (AArch64, x86-64)
- Windows (x86-64)

These binaries can be downloaded from
[here](https://github.com/zephyrproject-rtos/sdk-ng/tags).

For future release plans, please refer to the
[Release Plan](https://github.com/zephyrproject-rtos/sdk-ng/wiki/Release-Plan)
document in the wiki.

## Build Process

The Zephyr Project maintains the infrastructure necessary to build and test the
Zephyr SDK, and it is highly recommended to utilise this infrastructure for
generating the Zephyr SDK binaries.

When you submit a pull request to the Zephyr SDK repository, CI will
automatically build and test the Zephyr SDK with the changes in the pull
request and upload the binaries to the pull request check run, which you can
download for further local testing as necessary.

To aid in verifying changes and introduction of a new toolchain, a helper script,
contrib/linux_build_toolchain.sh, can be used to build one toolchain under Linux.

### Workflow to Test Patches with Zephyr SDK

The following workflow can be used to test a patch for GCC, for example,
building the SDK remotely:

- Submit your **DRAFT** gcc PR to Zephyr's
  [GCC fork](https://github.com/zephyrproject-rtos/gcc) (etc.)
- Update `.gitmodules` in sdk-ng to point to the fork with your gcc commit(s)
- Resync submodules (`git submodule sync --recursive && cd gcc && git pull`)
- Checkout the gcc commit hash in sdk-ng's `gcc` submodule and commit the
  `.gitmodule` changes (`git add .gitmodules gcc && git commit -s`)
- Submit a **DRAFT** PR to sdk-ng with the submodule change(s)

Zephyr's CI will then build a new toolchain, which will be available in the PR
check step. Verify that the GCC fix behaves as expected with the generated SDK.

## Release Process

To create a new Zephyr SDK release:

- Update the VERSION file with the new version (e.g. 0.11.0 or 0.11.0-beta1)
- On https://github.com/zephyrproject-rtos/sdk-ng/releases, create a new tag
  named with the version number prefixed with `v` (e.g. for the version 0.11.0,
  the tag name should be `v0.11.0`) and add the release information.
- Once the release is published, CI will build the Zephyr SDK bundles for all
  supported host platforms and will upload the binaries to the release page.

For more detailed information on the release process, please refer to the
[Release Process](https://github.com/zephyrproject-rtos/sdk-ng/wiki/Release-Process)
document in the wiki.

## Submodule Update Process

The Zephyr SDK repository contains various submodules, such as `binutils` and
`gcc`, required for building the Zephyr SDK.

When updating a submodule, the following procedure should be followed:

- Push a topic branch to the submodule repository.
- Create a pull request from the topic branch to the default (current) branch
  of the submodule repository.
- Create a pull request in the Zephyr SDK repository to update the submodule
  reference to the tip of the topic (pull request) branch.
- When the pull request in the Zephyr SDK repository passes the CI and the
  submodule pull request is sufficiently reviewed, merge the submodule pull
  request.
- Update the pull request in the Zephyr SDK repository to reference the merged
  commit in the submodule repository.
- Merge the pull request in the Zephyr SDK repository.

When updating the `picolibc` submodule, the `picolibc` module in the `west.yml`
of the [main Zephyr repository](https://github.com/zephyrproject-rtos/zephyr)
must also be updated to reference the same commit.
