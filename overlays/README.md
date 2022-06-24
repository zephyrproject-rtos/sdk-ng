## Toolchain Overlays

### xtensa_sample_controller

Generated using the following sequence of commands:

```
$ git clone git://github.com/foss-xtensa/xtensa-config.git
$ cd xtensa-config
$ wget https://github.com/foss-xtensa/xtensa-config/releases/download/201702/sample_controller_linux.tgz
$ tar -xf sample_controller_linux.tgz `tar -tf sample_controller_linux.tgz | grep xtensa-config-overlay.tar.gz` -O > xtensa-config-overlay.tar.gz
$ ./make-overlay.sh sample_controller xtensa-config-overlay.tar.gz .
```

### xtensa_intel_s1000

Generated using the following sequence of commands:

```
$ git clone git://github.com/foss-xtensa/xtensa-config.git
$ cd xtensa-config
$ ./make-overlay.sh intel_s1000 /opt/xtensa/XtDevTools/install/builds/RF-2016.4-linux/X6H3SUE_2016_4/src/xtensa-config-overlay.tar.gz .
```

Where `xtensa-config-overlay.tar.gz` is obtained from the official SDK
which can be obtained at:

https://tensilicatools.com/platform/intel-sue-creek

Path prefix `/opt/xtensa` is the default installation path, which
may change depending on how the SDK is installed.
