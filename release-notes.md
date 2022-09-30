# Notes / Changes in various releases

## Zephyr SDK 0.15.1-rc2

- openocd:
  * Fixed debugger connection failure on various STM32 platforms.

## Zephyr SDK 0.15.1-rc1

- general:
  * Updated the Zephyr SDK CMake package to declare Thread Local Storage (TLS)
    support.

- gcc:
  * Changed RV64I multi-libs to use the `medany` code model.
  * Changed the default RISC-V library to build with Zicsr and Zifencei
    extensions.
  * Added RISC-V `rv32ifac` multi-lib.
  * Added ARC `hs4x_rel31` CPU variant support.
  * Disabled GOT indirection usage for weak symbol references on AArch64.

## Zephyr SDK 0.15.0

- general:
  * Added ARCv3 support to the toolchains.

- binutils:
  * Updated to Binutils 2.38 release.

- gcc:
  * Updated to GCC 12.1 release.
  * Added multi-libs for the RISC-V base instruction sets (rv32i, rv32e, rv64i)
    to increase the ISA extension configuration coverage.
  * Added multi-libs for the RISC-V bit manipulation (Bitmanip) extensions.
  * Fixed incorrect ARC enter pattern instruction offset.

- gdb:
  * Updated to GDB 12.1 release.
  * Added separate GDB executable, gdb-py, supporting Python scripting and made
    the default GDB executable, gdb, build without Python scripting support
    such that it does not depend on a specific version of libpython.
  * Removed Python incapable GDB executable, gdb-no-py, which is no longer
    needed because it is equivalent to the default GDB executable.
  * Disabled unneeded "mini debuginfo" support for the macOS GDB in order to
    remove liblzma dependency.
  * Added GDB build for ARC64 architecture.

- newlib:
  * Disabled C99 format specifier support for the newlib "nano" variant in
    order to reduce its footprint. This feature will be kept disabled until
    the picolibc gains wider adoption.
  * Added ARCv3 support.

- qemu:
  * Updated to QEMU 7.0 release.
  * Updated ARC QEMU to 2022.08.04 release.

- openocd:
  * Updated OpenOCD to the commit 480d4e17727864f75dc60e22cb1a42e022cb1db3 (the
    latest version as of 11 June 2022).

## Zephyr SDK 0.14.2

- general:
  * Fixed minimal distribution bundle toolchain download failure on M1 Macs.

- gcc:
  * Fixed incorrect newlib-nano include path specified by the `nano.specs`
    file.

- newlib:
  * Enabled C99 format specifier support for the newlib-nano, which only had
    format specifier support up to that of the C89 standard.

- qemu:
  * Updated ARC QEMU to 2022.04.26 relesae.

- openocd:
  * Fixed Cyclone V SoC JTAG device order.

## Zephyr SDK 0.14.1

- general:
  * Introduced minimal distribution bundle that supports selective download
    and installation of the target toolchains.
  * Added ESP32 and ESP32-S2 Xtensa toolchains.

- qemu:
  * Updated to QEMU 6.2 release.
  * Added I2C device emulation support for ARM targets.
  * Separated QEMU for ARC architecture from the upstream QEMU.

## Zephyr SDK 0.14.0

- general:
  * Added multi-platform toolchain support (Linux, macOS and Windows).
  * Replaced self-extracting archive (SFX) distribution format with
    conventional archive with a setup script that can be manually run after
    extraction.
  * Changed Xtensa target triplet names to include the target SoC name
    (e.g. `xtensa-sample_controller_zephyr-elf`).

## Zephyr SDK 0.13.2

- gcc:
  * Added multilibs for the RISC-V RV32E targets.
  * Disabled MIPS GP register optimisation, which is not supported by the
    Zephyr MIPS architecture port.

- newlib:
  * Enabled C99 format specifier support for newlib full variant.

- qemu:
  * Added MIPS little endian emulation
  * Update xilinx qemu to 5.1.0
  * Added Xilinx MicroBlaze little endian emulation

- openocd:
  * Fixed missing DBG clock on STM32G0/L0.
  * Fixed image verification for ARC.

## Zephyr SDK 0.13.1
- gdb:
  * Fix ELF file format support issue on MacOS

- newlib:
  * Fixed Xtensa malloc failure issue reported in
    zephyrproject-rtos/zephyr#38258.

- gcc:
  * Pull in patches for Arm-GCC-CVE-2021-35465

- qemu:
  * Allow setup of ARC's "virt" board memory size

## Zephyr SDK 0.13.0

- general:
  * Added support for ARC64.  NOTE: GDB isn't currently supported
    for ARC64.
  * CI/go.sh changes to make building MacOS and CI building
    easier.
  * Various fixes for building/packaging on MacOS
  * Added GitHub CI workflow to build MacOS x86_64 packages

- qemu:
  * Updated to QEMU 6.0.0
  * Added arc64 support.  NOTE: this update ARC support replaces
    the machine (-M simhs) with (-M virt).  This change will require
    updates to boards/arc/qemu_arc/board.cmake in Zephyr to match.
  * Pull in fix from upstream for TFM:
    target/arm: Use correct SP in M-profile exception
  * Pull in fixes from upstream for:
    hw/arm: Fix modelling of SSE-300 TCMs and SRAM

- gcc:
  * Update to gcc 10.3 release
  * Added support for ARC64
  * Removed libgcc transactional memory clone registry support
  * Fixed incorrect build specs for libstdc++ nano variant. The libstdc++ nano
    variant, which is used with newlib-nano, is now built with
    `-fno-exceptions` to reduce compiled binary size.

- binutils:
  * Updated to add support for ARC64

- newlib:
  * Updated to add support for ARC64
  * Added multithreading support
  * Fix nano.spec file to pull in nano libraries.
  * Set -mthumb-interwork for nano newlib builds to workaround
    at crosstool issue.

- crosstool-ng:
  * sync with upstream.  Upstream now supports newlib-nano so we drop
    our Zephyr specific updates.  This also pulls in gcc-10.3 and
    initial support for ARC64.
  * Fix stripping of newlib-nano libs

- yocto:
  * Update to yocto 3.2.3 baseline.  This is in prep to support building
    qemu-6.0.0

- openocd:
  * Update to upstream 20210630 snapshot

## Zephyr SDK 0.12.4

- cmake:
  * Update for future arm/arm64 split

## Zephyr SDK 0.12.3

- gcc:
  * Backport patches from releases/gcc-10 branch for ARM.  Mainly
    to pickup fixes for Cortex-M55/ARM-v8.1m support

## Zephyr SDK 0.12.2

- binutils:
  * Enable x86_64-pep target for EFI binary support

## Zephyr SDK 0.12.1

- General:
  * Re-enable MIPS toolchain target
  * Fix version number in cmake/zephyr/Kconfig

## Zephyr SDK 0.12.0

- General:
  * Updated to using buildkite for CI
  * Updated yocto 3.1.1
  * Build aarch64 (arm64) linux host toolchains.
  * Moved to using a zephyr fork of crosstool-ng
  * Update bossa to 1.9.1+ + SAM4L support
  * cmake: Set HOST_TOOLS_HOME based on OS_PLATFORM
  * tweaks to installer script

- QEMU:
  * Updated to QEMU 5.1.0
  * Added icount support for ARC
  * Backport RISC-V PMP fixes from upstream qemu

- OpenOCD:
  * Updated to 20201109 snapshot [e44539d66c8929679321704768125df9ba7d5f67]

- newlib:
  * Updated to version 3.3
  * Updated xtensa to version 3.3 (in sync with all arch's)
  * Change default builds to be built with -O2

- binutils:
  * updated to version 2.35.1

- gcc:
  * Updated to version 10.2.0
  * Fix bug in libgcc builds w/regards to ARM cmse support

- gdb:
  * Updated to version 9.2

- xtensa:
  * remove HAL from SDK build

## Zephyr SDK 0.11.4
- General:
  * Fixed issue with cmake files not being installed in arch specific
    toolchan packages

- newlib:
  * Fix setting of -DMISSING_SYSCALL_NAMES consistent on all builds
  * Set march=pentium for 32-bit x86 build

## Zephyr SDK 0.11.3
- General:
  * Added cmake package support to make it easier to find toolchain
  * Add a -[no]rc argument to install script to allow skipping update
    query for .zephyrrc

- QEMU:
  * Add support for ARC
  * xilinx_qemu: Fix WFI instruction for icount mode
  * SPARC: fix issue with timer in QEMU machine AT697
  * Add support for changing CPU type in sifive_e machine.

- GDB:
  - Added a gdb build that doesn't support python (TARGET-gdb-no-py)

    NOTE: The name of the gdb executable will change in the next major
    release.  To maintain compatibility with previous 0.11.x we left the
    TARGET-gdb as the version that supports python.  In 0.12.x we will change
    it such that TARGET-gdb will NOT support python and thus work everywhere
    and TARGET-gdb-py will be the version that supports python.

  - Changed python support to build against python3.8.  This is an attempt to
    have the python support work on a larger number of distributions.

    NOTE: This may require install a python3.8 package on your system if
    python3.8 is not available.  On fedora systems that can be accomplished by:

    `sudo dnf install python38`

    On ubuntu systems that can be accomplished by:

    `sudo apt get install python3.8-dev`

- OpenOCD:
  * Pull in a fix for ARC SMP support
 
- GCC:
  - Fix build issue with CRC32 intrinsics included from arm_acle.h on ARM
    compiler.

## Zephyr SDK 0.11.2
- Fixed issue with setjmp/longjmp not existing on x86 32-bit build
- Fixed python support on GDB:
  NOTE: Since python support is enabled in GDB the host system needs
  python3.6 installed.  Otherwise you might get an error like:

  ```
  arm-zephyr-eabi-gdb: error while loading shared libraries: libpython3.6m.so.1.0: cannot open shared object file: No such file or directory
  ```

  On newer fedora systems this can show up and be fixed by:

  `sudo dnf install python36`
- Added support for Intel BDW and BDW Audio DSP xtensa toolchains.
- Added support for NXP IMX8 and IMX8M Audio DSP xtensa toolchains.
- Updated xtensa targets to GDB 8.3.1
- Removed HAL from xtensa builds as HAL module should now be used.
