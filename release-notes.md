# Notes / Changes in various releases

## Zephyr SDK 0.16.9-rc2

- general:

  * Linux Zephyr SDK binaries now link against glibc 2.28 and require a host
    operating system with glibc 2.28 or above (RHEL 8+, Debian 10+, Ubuntu
    20.04+).
  * Arm toolchain (`arm-zephyr-eabi`) now includes ARMv7-R big-endian
    multi-libs.
  * Added Xtensa sample_controller32 toolchain
    (`xtensa-sample_controller32_zephyr-elf`).
  * Added AMD ACP 6_0 toolchain (`xtensa-amd_acp_6_0_adsp_zephyr-elf.`).
  * Added Intel ACE30 PTL toolchain (`xtensa-intel_ace30_ptl_zephyr-elf`).
  * Added NXP HIFI1 toolchain (`xtensa-nxp_rt700_hifi1_zephyr-elf`).
  * Added NXP HIFI4 toolchain (`xtensa-nxp_rt700_hifi4_zephyr-elf`).
  * On Windows, OpenOCD installed under the "Program Files" directory is now
    used by default when `ZEPHYR_TOOLCHAIN_VARIANT` is set to `zephyr`. Note
    that OpenOCD is not currently available as part of Zephyr SDK on Windows.

- gdb:

  * Python scripting-enabled GDB (`gdb-py`) now links against Python 3.10, which
    is the minimum Python version supported by Zephyr.

- gcc:

  * Fixed incorrect C library header usage when compiling libstdc++ for
    newlib-nano and picolibc in non-Linux toolchains. This fixes the "undefined
    reference to `_impure_ptr`" errors when building Zephyr C++ applications
    with macOS and Windows toolchains.
  * Fixed insufficient argument checking in Secure state entry functions in
    software using Cortex-M Security Extensions (CMSE). For more details, refer
    to the CVE-2024-0151.

- picolibc:

  * Updated to Picolibc 1.8.8 release.

## Zephyr SDK 0.16.7/0.16.8

- gcc:

  * Removed experimental ISO C11 `<threads.h>`-based gthread implementation
    (added in the SDK 0.16.6 release) due to compatibility issues with prior
    Zephyr versions. This feature will be reworked and re-introduced in a
    future SDK release.

## Zephyr SDK 0.16.6

- gcc:

  * Added experimental ISO C11 `<threads.h>`-based gthread implementation and
    libstdc++ support. This enables ISO C++11 threads, mutexes, condition
    variables, semaphores, locks, scoped locks, synchronised stream and futures
    (async programming) support via ISO C11 threads.
  * Added minimal Arm Cortex-M85 support. This includes the support for
    `-mcpu=cortex-m85` compiler flag without the PACBTI extension.
  * Added RISC-V `rv32imfc` and `rv64imfc` multi-libs.
  * Added RISC-V `rv32emc` multi-libs without Zifencei extension support.

## Zephyr SDK 0.16.5/0.16.5-1

_The 0.16.5-1 release is identical to 0.16.5 except that it also includes the
AArch64 Linux host binaries._

- general:

  * Added NXP RT600 ADSP toolchain (`xtensa-nxp_rt600_adsp_zephyr-elf`).

- binutils:

  * Added ELF program header rewrite segment first section address check
    workaround for the ELF files that contain a section whose LMA is not equal
    to VMA. This fixes occasional "error in private header data" error observed
    when running objcopy with `--change-section-lma` option.

- openocd:

  * Added STM32WBA5xx device support.

- picolibc:

  * Updated to Picolibc 1.8.6 release.

## Zephyr SDK 0.16.4

- general:

  * Added NXP ADSP 8ULP toolchain (`xtensa-nxp_imx8ulp_adsp_zephyr-elf`).

- picolibc:

  * Updated to Picolibc 1.8.5 release.
  * Disabled `assert_verbose` option to reduce binary size.

## Zephyr SDK 0.16.3

- general:

  * Added MediaTek MT8195 toolchain (`xtensa-mt8195_adsp_zephyr-elf`).
  * Added NXP ADSP RT500 toolchain (`nxp_adsp_rt500`)
  * Added Qemu DC233C toolchain (`qemu_xtensa_dc233c`)
  * `arc_qemu`: Update to 2023.07.28 release

- picolibc:

  * Updated to Picolibc 1.8.2 release.

## Zephyr SDK 0.16.1

- general:

  * Added Intel ACE15 MTPM toolchain (`xtensa-intel_ace15_mtpm_zephyr-elf`).
  * Added Intel TGL ADSP toolchain (`xtensa-intel_tgl_adsp_zephyr-elf`).
  * Removed Intel APL ADSP toolchain (`xtensa-intel_apl_adsp_zephyr-elf`).
  * Removed Intel S1000 toolchain (`xtensa-intel_s1000_zephyr-elf`).

- cmake:

  * Fixed the Zephyr SDK CMake package registration failure when the setup
    script is run by a non-root user and the SDK is located in a directory
    that is not writable by the user.

- binutils:

  * Fixed ARM MVE `VCVTNE` instruction misinterpretation bug.

- openocd:

  * Disabled ARC_SEC core debugging support to work around the GDB connection
    timeout issue (refer to the [GitHub issue #631]).

- newlib:

  * Enabled newlib-nano for all targets except Xtensa. Note that newlib-nano is
    disabled for the Xtensa targets because of a `memset` bug causing crashes
    (refer to the [GitHub issue #660]).

- picolibc:

  * Updated to Picolibc 1.8.1 release.

[GitHub issue #631]: https://github.com/zephyrproject-rtos/sdk-ng/issues/631
[GitHub issue #660]: https://github.com/zephyrproject-rtos/sdk-ng/issues/660

## Zephyr SDK 0.16.0

- general:

  * Changed the distribution bundle archive format from `tar.gz` to `tar.xz` for
    Linux and macOS and from `zip` to `7z` for Windows in order to reduce the
    download size.
  * Added Microblaze little endian toolchain (`microblazeel-zephyr-elf`).
  * Added Espressif ESP32-S3 toolchain (`xtensa-espressif_esp32s3_zephyr-elf`).
  * Removed the unused `xtensa-intel_bdw_adsp_zephyr-elf` and
    `xtensa-intel_byt_adsp_zephyr-elf` toolchain.

- gdb:

  * Fixed GDB shell key input issues on tmux.

- gcc:

  * Updated to GCC 12.2 release.
  * Added Picolibc and the libstdc++ compiled for it as part of the toolchain
    in order to allow using the C++ standard library alongside the Picolibc.
  * Fixed ARM MVE vcmpq vector-scalar internal compiler error (GCC PR107987).

- qemu:

  * Added KVM (Kernel-based Virtual Machine) mode support for the AArch64 and
    x86-64 targets. This allows running the KVM-enabled Zephyr boards such as
    `qemu_kvm_arm64`.

- picolibc:

  * Updated to Picolibc 1.8 release.

## Zephyr SDK 0.15.2

- general:

  * Fixed "ERROR: Unsupported host operating system" when running the
    distribution bundle setup script on the Linux distros that report the
    `OSTYPE` of `linux` instead of `linux-gnu` (e.g. Alpine, SUSE).
  * Changed the glibc version for the host tool binaries from 2.32 to 2.27
    (default in Ubuntu 18.04) in order to improve compatibility with the older
    Linux distros.

- gcc:

  * Fixed the missing C99 math function declarations in the libstdc++ <cmath>
    header for the AArch64, RISC-V and x86-64 targets.
  * Disabled the compiler level support for the thread-local storage on the
    targets without the Zephyr-side thread-local storage support to prevent
    users from arbitrarily enabling it.
  * Updated the AArch64 toolchain libraries to build with the
    `-moverride=tune=no_ldp_stp_qregs` flag that disables the GCC optimisation
    that generates the `ldp` and `stp` instructions with the Advanced SIMD
    register operands for consecutive 32-byte copy operations, which can be
    expensive because it activates the Advanced SIMD context for a thread and
    can incur a massive context switching overhead due to its large size.
  * Updated the ARC toolchain libraries to build with the `-mtp-regno=26` flag
    to ensure that the toolchain library functions do not overwrite the thread-
    local storage pointer register when the thread-local storage support is
    enabled.

## Zephyr SDK 0.15.1

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

- openocd:
  * Fixed debugger connection failure on various STM32 platforms.

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
  * Updated ARC QEMU to 2022.04.26 release.

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
    toolchain packages

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
