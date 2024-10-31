// RUN: clang -c -target riscv32-unknown-elf -march=rv32ic -Xclang -target-feature -Xclang +xrvc -mllvm -global-isel=1 -O3 -o %t.o %s
// RUN: llvm-objdump --mattr=+i,+xrvc --disassembler-options=numeric -d %t.o | FileCheck %s

int test_nand(int a, int b) {
    // CHECK: 0b 05 b5 2a xrvc.nand x10, x11
    return ~(a & b);
}
