; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O0 -mtriple=riscv32 -mattr=+m,+xcorevmac -verify-machineinstrs -global-isel=1 < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,CHECK-GISEL

define i32 @machhuN(i32 %a, i32 %b, i32 %c) {
; CHECK-LABEL: machhuN:
; CHECK:       # %bb.0:
; CHECK-GISEL-NEXT:    seal5.cv.machhun a2, a0, a1, 5
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:    ret
  %1 = lshr i32 %a, 16
  %2 = lshr i32 %b, 16
  %3 = mul i32 %1, %2
  %4 = add i32 %3, %c
  %5 = lshr i32 %4, 5
  ret i32 %5
}
