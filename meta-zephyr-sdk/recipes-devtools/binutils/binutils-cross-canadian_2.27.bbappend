FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://add-trad-vectors-for-mips-elf.patch \
	    file://0001-tc-xtensa.c-fixup-xg_reverse_shift_count-typo.patch"
