; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m -mattr=+xcorevmac -verify-machineinstrs < %s \
; RUN:   | FileCheck %s

declare i32 @llvm.riscv.cv.mac.macsRN(i32, i32, i32)

define i32 @test.macsRN(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: test.mac:
; CHECK:       # %bb.0:
; CHECK-NEXT:    seal5.cv.macsrn a2, a0, a1
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    ret
  %1 = call i32 @llvm.riscv.cv.mac.macsRN(i32 %a, i32 %b, i32 %c)
  ret i32 %1
}
