# Nios2 Architecture Definition

DEFAULTTUNE ?= "nios2"

TUNE_ARCH = "nios2"
TUNE_PKGARCH = "nios2"
TUNE_FEATURES_tune-nios2 = "nios2"

TUNEVALID[bigendian] = "Enable big-endian mode"
TUNE_CCARGS .= "${@bb.utils.contains('TUNE_FEATURES', 'bigendian', ' -meb', '', d)}"

TUNEVALID[hw-mul] = "Enable Nios2 Hardware Multiply"
TUNE_CCARGS .= "${@bb.utils.contains('TUNE_FEATURES', 'hw-mul', ' -mhw-mul', '', d)}"

TUNEVALID[no-hw-mul] = "Disable Nios2 Hardware Multiply"
TUNE_CCARGS .= "${@bb.utils.contains('TUNE_FEATURES', 'no-hw-mul', ' -mno-hw-mul', '', d)}"

TUNEVALID[nios2] = "Altera Nios2"

def nios2_machdata_setfunc(machdata, d):
    machdata["elf"] = {"nios2":  (113, 0, 0, True, 32), }
    return machdata

PACKAGEQA_EXTRA_MACHDEFFUNCS = "nios2_machdata_setfunc"
