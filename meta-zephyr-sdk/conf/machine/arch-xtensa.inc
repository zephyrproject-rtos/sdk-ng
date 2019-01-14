# Xtensa Architecture Definition

DEFAULTTUNE ?= "xtensa"

TUNEVALID[xtensa] = "Enable Xtensa"
AVAILTUNES += "xtensa"

TUNEVALID[longcalls] = "Enable long calls: emit 32-bit call sequences"
TUNE_CCARGS .= "${@bb.utils.contains('TUNE_FEATURES', 'longcalls', ' -mlongcalls', '', d)}"
AVAILTUNES += "longcalls"

TUNEVALID[target-align] = "Try to align branch targets"
TUNE_CCARGS .= "${@bb.utils.contains('TUNE_FEATURES', 'target-align', ' -mtarget-align', '', d)}"
AVAILTUNES += "target-align"

TUNE_ARCH = "xtensa"
TUNE_PKGARCH = "xtensa"

TUNE_FEATURES_tune-xtensa = "xtensa"

def xtensa_machdata_setfunc(machdata, d):
    machdata["elf"] = {"xtensa":  (94, 0, 0, True, 32), }
    return machdata

PACKAGEQA_EXTRA_MACHDEFFUNCS = "xtensa_machdata_setfunc"

def xtensa_siteinfo_setfunc(archinfo, osinfo, targetinfo, d):
    archinfo['xtensa'] = "endian-little bit-32 "
    osinfo['linux'] = "common-linux common-glibc"
    targetinfo['xtensa-linux'] = "xtensa-linux"
    return archinfo, osinfo, targetinfo

SITEINFO_EXTRA_DATAFUNCS = "xtensa_siteinfo_setfunc"

