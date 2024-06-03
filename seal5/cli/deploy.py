#
# Copyright (c) 2023 TUM Department of Electrical and Computer Engineering.
#
# This file is part of Seal5.
# See https://github.com/tum-ei-eda/seal5.git for further info.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
"""Command line subcommand for deploying seal5 LLVM."""

from seal5.flow import Seal5Flow
from seal5.logging import get_logger
from os import getenv


logger = get_logger()


def get_parser(subparsers):
    """ "Define and return a subparser for the deploy subcommand."""
    parser = subparsers.add_parser("deploy", description="Deploy Seal5 LLVM.")
    parser.set_defaults(func=handle)
    return parser


def handle(args):
    """Callback function which will be called to process the deploy subcommand"""
    name = args.name[0] if isinstance(args.name, list) else args.name
    seal5_flow = Seal5Flow(args.dir, name)
    seal5_flow.deploy(verbose=args.verbose)
