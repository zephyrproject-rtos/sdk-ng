DEFAULTTUNE ?= "riscv32"

TUNE_ARCH = "riscv32"
TUNE_PKGARCH = "riscv32"
TUNE_FEATURES_tune-riscv32 = "littleendian"
TUNE_CCARGS = " -nostdlib "

TUNEVALID[littleendian] = "Little endian mode"

def riscv32_siteinfo_setfunc(archinfo, osinfo, targetinfo, d):
	archinfo['riscv32'] = "endian-little bit-32 "
	osinfo['linux'] = "common-linux common-glibc"
	targetinfo['riscv32-linux'] = "riscv32-linux"
	return archinfo, osinfo, targetinfo

SITEINFO_EXTRA_DATAFUNCS = "riscv32_siteinfo_setfunc"

def riscv32_machdata_setfunc(machdata, d):
    machdata["elf"] = { "riscv32" : (243,    0,    0,  True,  32), }
    return machdata

PACKAGEQA_EXTRA_MACHDEFFUNCS = "riscv32_machdata_setfunc"

