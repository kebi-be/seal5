; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O0 -mtriple=riscv32 -mattr=+m,+xcorevalu -verify-machineinstrs -global-isel=1 < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,CHECK-GISEL

declare i32 @llvm.smin.i32(i32, i32)
declare i32 @llvm.smax.i32(i32, i32)

define i32 @clip(i32 %a) {
; CHECK-LABEL: clip:
; CHECK:       # %bb.0:
; CHECK-GISEL-NEXT:    seal5.cv.clip a0, a0, 7
; CHECK-NEXT:    ret
  %1 = call i32 @llvm.smax.i32(i32 %a, i32 -64)
  %2 = call i32 @llvm.smin.i32(i32 %1, i32 63)
  ret i32 %2
}
