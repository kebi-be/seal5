
## SPDX-License-Identifier: Apache-2.0
##
## This file is part of the M2-ISA-R project: https://github.com/tum-ei-eda/M2-ISA-R
##
## Copyright (c) 2025 TUM Department of Electrical and Computer Engineering.
## Copyright (c) 2025 DLR-SE Department of System Evolution and Operation
\
# Generated on ${start_time}.
#
# This file contains the Info for generating machine code test for the ${core_name} 
# core architecture.

# RUN: llvm-mc %s -triple=riscv32 -mattr=+${core_name} -riscv-no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ASM,CHECK-ASM-AND-OBJ %s
# RUN: llvm-mc -filetype=obj -triple=riscv32 -mattr=+${core_name} < %s \
# RUN:     | llvm-objdump --mattr=+${core_name} -M no-aliases -d -r - \
# RUN:     | FileCheck --check-prefix=CHECK-ASM-AND-OBJ %s

# CHECK-ASM-AND-OBJ: cv.nand.bitwise a4, ra, s0
# CHECK-ASM: encoding: [0x2b,0xe7,0x80,0x92]
cv.nand.bitwise a4, ra, s0
