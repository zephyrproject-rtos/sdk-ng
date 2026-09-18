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
    # These tests use an emulated serial port instead of semihost and
    # output a magic character to terminate the emulation.
    'test-hello-raw',
    'test-hello-raw-no-flash',
]


def is_disabled(image):
    return any([image.endswith(t) for t in disabled_tests])


def run(args):
    if is_disabled(args.image):
        return EXIT_CODE_SKIP
    arguments = []
    is_arg = False
    for a in args.arguments:
        if is_arg:
            arguments += a.split(' ')
            is_arg = False
        elif a == "--args":
            is_arg = True
        else:
            arguments += a
    return run_qemu(
        args.qemu_command,
        args.qemu_machine,
        args.qemu_cpu,
        args.qemu_params.split(":") if args.qemu_params else [],
        args.image,
        ["program-name"] + arguments,
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
