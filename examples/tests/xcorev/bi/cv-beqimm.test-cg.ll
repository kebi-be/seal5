; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O0 -mtriple=riscv32 -mattr=+m,+xcorevbi -verify-machineinstrs -global-isel=1 < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK_NOPT,CHECK_NOPT-GISEL
; RUN: llc -O3 -mtriple=riscv32 -mattr=+m,+xcorevbi -verify-machineinstrs -global-isel=1 < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK_OPT,CHECK_OPT-GISEL

define i32 @beqimm(i32 %a) {
; CHECK_NOPT-LABEL: beqimm:
; CHECK_NOPT:       # %bb.0:
; CHECK_NOPT-GISEL-NEXT:    seal5.cv.beqimm a0, 5, .LBB0_2
; CHECK_NOPT-NEXT:    j .LBB0_1
; CHECK_NOPT-NEXT:  .LBB0_1: # %f
; CHECK_NOPT-NEXT:    li a0, 0
; CHECK_NOPT-NEXT:    ret
; CHECK_NOPT-NEXT:  .LBB0_2: # %t
; CHECK_NOPT-NEXT:    li a0, 1
; CHECK_NOPT-NEXT:    ret
;
; CHECK_OPT-LABEL: beqimm:
; CHECK_OPT:       # %bb.0:
; CHECK_OPT-GISEL-NEXT:    seal5.cv.bneimm a0, 5, .LBB0_2
; CHECK_OPT-NEXT:  # %bb.1: # %t
; CHECK_OPT-NEXT:    li a0, 1
; CHECK_OPT-NEXT:    ret
; CHECK_OPT-NEXT:  .LBB0_2: # %f
; CHECK_OPT-NEXT:    li a0, 0
; CHECK_OPT-NEXT:    ret
  %1 = icmp eq i32 %a, 5
  br i1 %1, label %t, label %f
f:
  ret i32 0
t:
  ret i32 1
}
