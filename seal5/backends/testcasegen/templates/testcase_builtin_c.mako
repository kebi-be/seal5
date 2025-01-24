## SPDX-License-Identifier: Apache-2.0
##
## This file is part of the M2-ISA-R project: https://github.com/tum-ei-eda/M2-ISA-R
##
## Copyright (c) 2025 TUM Department of Electrical and Computer Engineering.
## Copyright (c) 2025 DLR-SE Department of System Evolution and Operation
\
# Generated on ${start_time}.
#
# This file contains the Info for generating builtin c tests for the ${core_name} 
# core architecture.

// RUN: clang -O3 -target riscv32-unknown-elf -Xclang -target-feature -Xclang +xcorev${core_name} -o - %s -c | llvm-objdump - -d | FileCheck --check-prefixes=CHECK-OBJ %s
// RUN: clang -O3 -target riscv32-unknown-elf -Xclang -target-feature -Xclang +xcorev${core_name} -o - %s -S -emit-llvm | FileCheck --check-prefixes=CHECK-LL %s

# int __builtin_xcorevmac_${core_name}_${core_name}(int, int, int);
#
#int test_${core_name}(int a, int b, int c) {
#   // CHECK-OBJ: <test_mac>
#    // CHECK-OBJ-NEXT: seal5.cv.${core_name}
#    // CHECK-LL-LABEL: @test_${core_name}
#    // CHECK-LL-NEXT:  entry:
#    // CHECK-LL-NEXT:    [[TMP0:%.*]] = tail call i32 @llvm.riscv.xcorevmac.${core_name}.${core_name}(i32 %a, i32 %b, i32 %c)
#    // CHECK-LL-NEXT:    ret i32 [[TMP0]]
#    return __builtin_riscv_xcorevmac_${core_name}_${core_name}(a, b, c);