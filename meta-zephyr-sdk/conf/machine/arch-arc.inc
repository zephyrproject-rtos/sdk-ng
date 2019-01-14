DEFAULTTUNE ?= "arc"

TUNE_ARCH = "arc"
TUNE_PKGARCH = "arc"
TUNE_FEATURES_tune-arc = "littleendian"
TUNE_CCARGS = ""

TUNEVALID[littleendian] = "Little endian mode"

def arc_siteinfo_setfunc(archinfo, osinfo, targetinfo, d):
	archinfo['arc'] = "endian-little bit-32 "
	osinfo['linux'] = "common-linux common-glibc"
	targetinfo['arc-linux'] = "arc-linux"
	return archinfo, osinfo, targetinfo

SITEINFO_EXTRA_DATAFUNCS = "arc_siteinfo_setfunc"

def arc_machdata_setfunc(machdata, d):
    machdata["elf"] = { "arc" : (195,    0,    0,  True,  32), }
    return machdata

PACKAGEQA_EXTRA_MACHDEFFUNCS = "arc_machdata_setfunc"


