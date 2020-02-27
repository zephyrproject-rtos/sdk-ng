# Notes / Changes in various releases

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
