DEFAULTTUNE ?= "iamcu"

TARGET_OS_iamcu = "elfiamcu"
TARGET_ARCH = "i586"

TUNE_PKGARCH = "iamcu"
TUNE_FEATURES_tune-iamcu = "iamcu"
TUNE_CCARGS = "-miamcu -m32"
TUNE_ARCH = "i586"
TUNEVALID[iamcu] = "Intel MCU"

def iamcu_siteinfo_setfunc(archinfo, osinfo, targetinfo, d):
	archinfo['iamcu'] = "endian-little bit-32 "
	osinfo['linux'] = "common-linux common-glibc"
	targetinfo['iamcu-linux'] = "iamcu-linux"
	return archinfo, osinfo, targetinfo

SITEINFO_EXTRA_DATAFUNCS = "iamcu_siteinfo_setfunc"
