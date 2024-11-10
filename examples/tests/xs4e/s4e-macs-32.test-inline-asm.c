// RUN: clang --target=riscv32 -march=rv32ixs4emac -c -o %t.o %s
// RUN: llvm-objdump --disassembler-options=numeric -d %t.o | FileCheck %s

int main() {
  // CHECK: 0b 90 1a 03 s4e.macs_32 x21, x17
  asm("s4e.macs_32 x21, x17");

  return 42;
}