
create_sdk_files_append_zephyr-sdk() {
	rm -fv ${SDK_OUTPUT}/${SDKPATH}/site-config-*

	# We need to keep environment-setup-* file becuse the SDK relocate info is
	# derived from it.
	# rm -f ${SDK_OUTPUT}/${SDKPATH}/environment-setup-*

	# We keep the version info file.
	# rm -fv ${SDK_OUTPUT}/${SDKPATH}/version-*

	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${MULTIMACH_TARGET_SYS}/etc
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${MULTIMACH_TARGET_SYS}/var
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${MULTIMACH_TARGET_SYS}/run
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${MULTIMACH_TARGET_SYS}/lib

	#rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/usr/share
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/etc
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/var
	rm -rfv ${SDK_OUTPUT}/${SDKPATH}/sysroots/${SDK_SYS}/sbin
}


