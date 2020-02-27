# Notes / Changes in various releases

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
