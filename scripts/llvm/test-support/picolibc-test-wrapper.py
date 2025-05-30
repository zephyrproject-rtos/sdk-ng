#!/usr/bin/env python3

# Copyright (c) 2023, Arm Limited and affiliates.

# This is a wrapper script to run picolibc tests with QEMU.

from run_qemu import run_qemu
import argparse
import pathlib
import sys

# https://mesonbuild.com/Unit-tests.html#skipped-tests-and-hard-errors
EXIT_CODE_SKIP = 77

disabled_tests = [
    # compiler-rt does not properly support floating point exceptions and
    # rounding modes for computations on types implemented in software
    # https://github.com/picolibc/picolibc/pull/500
    # https://github.com/zephyrproject-rtos/sdk-ng/issues/838
    "picolibc_armv7m_soft_fpv4_sp_d16-build/test/math_errhandling",
    "picolibc_armv7m_hard_fpv4_sp_d16-build/test/math_errhandling",
    "picolibc_armv7r_hard_vfpv3xd-build/test/math_errhandling",
    "picolibc_armv7r_hard_vfpv3xd_exn_rtti-build/test/math_errhandling",
    "picolibc_armv8.1m.main_hard_fp_nomve-build/test/math_errhandling",
    "picolibc_armv7m_soft_fpv4_sp_d16_exn_rtti-build/test/math_errhandling",
    "picolibc_armv7m_hard_fpv4_sp_d16_exn_rtti-build/test/math_errhandling",
    "picolibc_armv8.1m.main_hard_fp_nomve_exn_rtti-build/test/math_errhandling",
    "picolibc_armv8.1m.main_hard_nofp_mve-build/test/fenv",
    "picolibc_armv8.1m.main_hard_nofp_mve-build/test/math_errhandling",
    "picolibc_armv8m.main_hard_fp-build/test/math_errhandling",
    "picolibc_armv8.1m.main_hard_nofp_mve_exn_rtti-build/test/fenv",
    "picolibc_armv8.1m.main_hard_nofp_mve_exn_rtti-build/test/math_errhandling",
    "picolibc_armv8m.main_hard_fp_exn_rtti-build/test/math_errhandling",
    "picolibc_rv32imafc_zicsr_zifencei_ilp32f-build/test/rounding-mode",
    "picolibc_rv32imafc_zicsr_zifencei_ilp32f-build/test/math_errhandling",
    "picolibc_rv32imafc_zicsr_zifencei_ilp32f-build/test/test-fma",
    "picolibc_rv32imafc_zicsr_zifencei_ilp32f_exn_rtti-build/test/rounding-mode",
    "picolibc_rv32imafc_zicsr_zifencei_ilp32f_exn_rtti-build/test/math_errhandling",
    "picolibc_rv32imafc_zicsr_zifencei_ilp32f_exn_rtti-build/test/test-fma",
    "picolibc_rv32imfc_zicsr_zifencei_ilp32f-build/test/rounding-mode",
    "picolibc_rv32imfc_zicsr_zifencei_ilp32f-build/test/math_errhandling",
    "picolibc_rv32imfc_zicsr_zifencei_ilp32f-build/test/test-fma",
    "picolibc_rv32imfc_zicsr_zifencei_ilp32f_exn_rtti-build/test/rounding-mode",
    "picolibc_rv32imfc_zicsr_zifencei_ilp32f_exn_rtti-build/test/math_errhandling",
    "picolibc_rv32imfc_zicsr_zifencei_ilp32f_exn_rtti-build/test/test-fma",
    "picolibc_rv32imafd_zicsr_zifencei_ilp32d-build/test/math_errhandling",
    "picolibc_rv32imafd_zicsr_zifencei_ilp32d-build/test/test-fma",
    "picolibc_rv32imafd_zicsr_zifencei_ilp32d_exn_rtti-build/test/math_errhandling",
    "picolibc_rv32imafd_zicsr_zifencei_ilp32d_exn_rtti-build/test/test-fma",
    "picolibc_rv32if_zicsr_zifencei_ilp32f-build/test/rounding-mode",
    "picolibc_rv32if_zicsr_zifencei_ilp32f-build/test/math_errhandling",
    "picolibc_rv32if_zicsr_zifencei_ilp32f-build/test/test-fma",
    "picolibc_rv32if_zicsr_zifencei_ilp32f_exn_rtti-build/test/rounding-mode",
    "picolibc_rv32if_zicsr_zifencei_ilp32f_exn_rtti-build/test/math_errhandling",
    "picolibc_rv32if_zicsr_zifencei_ilp32f_exn_rtti-build/test/test-fma",
    "picolibc_rv64imafdc_zicsr_zifencei_lp64d-build/test/math_errhandling",
    "picolibc_rv64imafdc_zicsr_zifencei_lp64d-build/test/test-fma",
    "picolibc_rv64imafdc_zicsr_zifencei_lp64d_exn_rtti-build/test/math_errhandling",
    "picolibc_rv64imafdc_zicsr_zifencei_lp64d_exn_rtti-build/test/test-fma",
    "picolibc_rv64imafd_zicsr_zifencei_lp64d-build/test/math_errhandling",
    "picolibc_rv64imafd_zicsr_zifencei_lp64d-build/test/test-fma",
    "picolibc_rv64imafd_zicsr_zifencei_lp64d_exn_rtti-build/test/math_errhandling",
    "picolibc_rv64imafd_zicsr_zifencei_lp64d_exn_rtti-build/test/test-fma",
    "picolibc_rv64imfc_zicsr_zifencei_lp64f-build/test/rounding-mode",
    "picolibc_rv64imfc_zicsr_zifencei_lp64f-build/test/math_errhandling",
    "picolibc_rv64imfc_zicsr_zifencei_lp64f-build/test/test-fma",
    "picolibc_rv64imfc_zicsr_zifencei_lp64f_exn_rtti-build/test/rounding-mode",
    "picolibc_rv64imfc_zicsr_zifencei_lp64f_exn_rtti-build/test/math_errhandling",
    "picolibc_rv64imfc_zicsr_zifencei_lp64f_exn_rtti-build/test/test-fma",
    "picolibc_rv64imfc_zicsr_zifencei_zba_zbb_zbc_zbs_lp64f-build/test/rounding-mode",
    "picolibc_rv64imfc_zicsr_zifencei_zba_zbb_zbc_zbs_lp64f-build/test/math_errhandling",
    "picolibc_rv64imfc_zicsr_zifencei_zba_zbb_zbc_zbs_lp64f-build/test/test-fma",
    "picolibc_rv64imfc_zicsr_zifencei_zba_zbb_zbc_zbs_lp64f_exn_rtti-build/test/rounding-mode",
    "picolibc_rv64imfc_zicsr_zifencei_zba_zbb_zbc_zbs_lp64f_exn_rtti-build/test/math_errhandling",
    "picolibc_rv64imfc_zicsr_zifencei_zba_zbb_zbc_zbs_lp64f_exn_rtti-build/test/test-fma",
]


def is_disabled(image):
    return any([image.endswith(t) for t in disabled_tests])


def run(args):
    if is_disabled(args.image):
        return EXIT_CODE_SKIP
    return run_qemu(
        args.qemu_command,
        args.qemu_machine,
        args.qemu_cpu,
        args.qemu_params.split(":") if args.qemu_params else [],
        args.image,
        ["program-name"] + args.arguments,
        None,
        pathlib.Path.cwd(),
        args.verbose,
    )


def main():
    parser = argparse.ArgumentParser(
        description="Run a single test using qemu"
    )
    parser.add_argument(
        "--qemu-command", required=True, help="qemu-system-<arch> path"
    )
    parser.add_argument(
        "--qemu-machine",
        required=True,
        help="name of the machine to pass to QEMU",
    )
    parser.add_argument(
        "--qemu-cpu", required=False, help="name of the cpu to pass to QEMU"
    )
    parser.add_argument(
        "--qemu-params",
        required=False,
        help='list of arguments to pass to qemu, separated with ":"',
    )
    parser.add_argument(
        "--verbose",
        action="store_true",
        help="Print verbose output. This may affect test result, as the output "
        "will be added to the output of the test.",
    )
    parser.add_argument("image", help="image file to execute")
    parser.add_argument(
        "arguments",
        nargs=argparse.REMAINDER,
        default=[],
        help="optional arguments for the image",
    )
    args = parser.parse_args()
    ret_code = run(args)
    sys.exit(ret_code)


if __name__ == "__main__":
    main()
