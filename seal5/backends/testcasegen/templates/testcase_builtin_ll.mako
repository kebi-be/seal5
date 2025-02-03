## SPDX-License-Identifier: Apache-2.0
##
## This file is part of the M2-ISA-R project: https://github.com/tum-ei-eda/M2-ISA-R
##
## Copyright (c) 2025 TUM Department of Electrical and Computer Engineering.
## Copyright (c) 2025 DLR-SE Department of System Evolution and Operation
\
# Generated on ${start_time}.
#
# This file contains the Info for generating builtin ll tests for the ${core_name} 
# core architecture.

; RUN: llc -O3 -mtriple=riscv32 -mattr=+${core_name} -verify-machineinstrs < %s \
; RUN:   | FileCheck %s

declare i32 @llvm.riscv.xcv.nand.bitwise(i32, i32)

define i32 @nand(i32 %a, i32 %b) {
; CHECK-LABEL: nand:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cv.nand.bitwise a0, a1
; CHECK-NEXT:    ret
  %1 = call i32 @llvm.riscv.xcv.nand.bitwise(i32 %a, i32 %b)
  ret i32 %1
}
