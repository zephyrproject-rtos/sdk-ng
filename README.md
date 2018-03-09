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
