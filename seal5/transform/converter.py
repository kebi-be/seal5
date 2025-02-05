# SPDX-License-Identifier: Apache-2.0
#
# This file is part of the M2-ISA-R project: https://github.com/tum-ei-eda/M2-ISA-R
#
# Copyright (C) 2022
# Chair of Electrical Design Automation
# Technical University of Munich

"""Tranform M2-ISA-R metamodel to Seal5 metamodel."""

import sys
import argparse
import logging
import pathlib
import pickle

from m2isar.metamodel import arch
from m2isar.metamodel.utils.expr_preprocessor import process_attributes, process_functions, process_instructions

import seal5.model as seal5_model

logger = logging.getLogger("seal5_converter")


def convert_attrs(attrs, base):
    # print("convert_attrs", attrs)
    ret = {}
    for attr, attr_val in attrs.items():
        if isinstance(attr, str):
            attr_ = base._member_map_.get(attr.upper())
            if attr_ is not None:
                ret[attr_] = attr_val
            else:
                logger.warning("Unknown attribute: %s", attr)
                ret[attr] = attr_val
        else:
            ret[attr] = attr_val
    return ret


def get_parser():
    # read command line args
    parser = argparse.ArgumentParser()
    parser.add_argument("top_level", help="A .m2isarmodel or .seal5model file.")
    parser.add_argument("--log", default="info", choices=["critical", "error", "warning", "info", "debug"])
    parser.add_argument("--prefix", default="", type=str)
    parser.add_argument("--output", "-o", type=str, default=None)
    return parser


def run(args):
    # initialize logging
    logging.basicConfig(level=getattr(logging, args.log.upper()))

    # resolve model paths
    top_level = pathlib.Path(args.top_level)
    # abs_top_level = top_level.resolve()

	# resolve model paths
	top_level = pathlib.Path(args.top_level)
	abs_top_level = top_level.resolve()
	search_path = abs_top_level.parent.parent
	model_fname = abs_top_level
    
    if args.output is None:
        assert top_level.suffix == ".m2isarmodel", "Can not infer file extension."
        temp = str(top_level)
        temp = temp.replace(".m2isarmodel", ".seal5model")
        model_path = pathlib.Path(temp)
    else:
        model_path = pathlib.Path(args.output)
    # model_path.mkdir(exist_ok=True)

    logger.info("loading models")

    new_model = {}

	with open(model_fname, 'rb') as f:
		model_obj: M2Model = pickle.load(f)

	if model_obj.model_version != M2_METAMODEL_VERSION:
		logger.warning("Loaded model version mismatch")

    if model_obj.models
        models = model_obj.models
	start_time = time.strftime("%a, %d %b %Y %H:%M:%S %z", time.localtime())

	# load models
  #  with open(top_level, "rb") as f:
   #     # models: "dict[str, arch.CoreDef]" = pickle.load(f)
    #    sets: "dict[str, arch.InstructionSet]" = pickle.load(f)

    # preprocess model
    for core_name, core_def in models.items():
        logger.info("preprocessing core %s", core_name)
        process_functions(core_def)
        process_instructions(core_def)
        process_attributes(core_def)

    for core_name, core_def in models.items():
        logger.info("replacing core %s", core_name)
        for enc, instr_def in core_def.instructions.items():
            if args.prefix:
                instr_def.name = f"{args.prefix.upper()}{instr_def.name}"
                prefix_ = args.prefix.lower().replace("_", ".")
                instr_def.mnemonic = f"{prefix_}{instr_def.mnemonic}"
            core_def.instructions[enc] = seal5_model.Seal5Instruction(
                instr_def.name,
                convert_attrs(instr_def.attributes, base=seal5_model.Seal5InstrAttribute),
                instr_def.encoding,
                instr_def.mnemonic,
                instr_def.assembly,
                instr_def.operation,
                [],
                {},
            )
            core_def.instructions[enc].scalars = instr_def.scalars
        for func_name, func_def in core_def.functions.items():
            func_def.attributes = convert_attrs(func_def.attributes, base=seal5_model.Seal5FunctionAttribute)
        models[core_name] = seal5_model.Seal5InstructionSet(
            core_def.name,
            core_def.extension,
            core_def.constants,
            core_def.memories,
            core_def.functions,
            core_def.instructions,
            {},
            {},
            {},
            {},
            {},
        )

    new_model["models"] = models

    logger.info("dumping model")
    with open(model_path, "wb") as f:
        pickle.dump(new_model, f)


def main(argv):
    parser = get_parser()
    args = parser.parse_args(argv)
    run(args)


if __name__ == "__main__":
    main(sys.argv[1:])
