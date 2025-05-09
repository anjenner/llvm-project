; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py
; RUN: opt -passes="print<cost-model>" 2>&1 -disable-output -cost-kind=all -mtriple=aarch64 < %s | FileCheck %s

target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"

;
; Verify the cost model for reverse shuffles.
;

;; Reverse shuffles should be lowered to vrev and possibly a vext (for quadwords, on neon)
define void @reverse() {
; CHECK-LABEL: 'reverse'
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v2i8 = shufflevector <2 x i8> undef, <2 x i8> undef, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v4i8 = shufflevector <4 x i8> undef, <4 x i8> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v8i8 = shufflevector <8 x i8> undef, <8 x i8> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v16i8 = shufflevector <16 x i8> undef, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v2i16 = shufflevector <2 x i16> undef, <2 x i16> undef, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v4i16 = shufflevector <4 x i16> undef, <4 x i16> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v8i16 = shufflevector <8 x i16> undef, <8 x i16> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v16i16 = shufflevector <16 x i16> undef, <16 x i16> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v2i32 = shufflevector <2 x i32> undef, <2 x i32> undef, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v4i32 = shufflevector <4 x i32> undef, <4 x i32> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v8i32 = shufflevector <8 x i32> undef, <8 x i32> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v2i64 = shufflevector <2 x i64> undef, <2 x i64> undef, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v4i64 = shufflevector <4 x i64> undef, <4 x i64> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v2f16 = shufflevector <2 x half> undef, <2 x half> undef, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v4f16 = shufflevector <4 x half> undef, <4 x half> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v8f16 = shufflevector <8 x half> undef, <8 x half> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v16f16 = shufflevector <16 x half> undef, <16 x half> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v2bf16 = shufflevector <2 x bfloat> undef, <2 x bfloat> undef, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v4bf16 = shufflevector <4 x bfloat> undef, <4 x bfloat> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v8bf16 = shufflevector <8 x bfloat> undef, <8 x bfloat> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v16bf16 = shufflevector <16 x bfloat> undef, <16 x bfloat> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v2f32 = shufflevector <2 x float> undef, <2 x float> undef, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v4f32 = shufflevector <4 x float> undef, <4 x float> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v8f32 = shufflevector <8 x float> undef, <8 x float> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v2f64 = shufflevector <2 x double> undef, <2 x double> undef, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v4f64 = shufflevector <4 x double> undef, <4 x double> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
; CHECK-NEXT:  Cost Model: Found costs of RThru:0 CodeSize:1 Lat:1 SizeLat:1 for: ret void
;
  %v2i8 = shufflevector <2 x i8> undef, <2 x i8> undef, <2 x i32> <i32 1, i32 0>
  %v4i8 = shufflevector <4 x i8> undef, <4 x i8> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %v8i8 = shufflevector <8 x i8> undef, <8 x i8> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  %v16i8 = shufflevector <16 x i8> undef, <16 x i8> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>

  %v2i16 = shufflevector <2 x i16> undef, <2 x i16> undef, <2 x i32> <i32 1, i32 0>
  %v4i16 = shufflevector <4 x i16> undef, <4 x i16> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %v8i16 = shufflevector <8 x i16> undef, <8 x i16> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  %v16i16 = shufflevector <16 x i16> undef, <16 x i16> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>

  %v2i32 = shufflevector <2 x i32> undef, <2 x i32> undef, <2 x i32> <i32 1, i32 0>
  %v4i32 = shufflevector <4 x i32> undef, <4 x i32> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %v8i32 = shufflevector <8 x i32> undef, <8 x i32> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>

  %v2i64 = shufflevector <2 x i64> undef, <2 x i64> undef, <2 x i32> <i32 1, i32 0>
  %v4i64 = shufflevector <4 x i64> undef, <4 x i64> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>

  %v2f16 = shufflevector <2 x half> undef, <2 x half> undef, <2 x i32> <i32 1, i32 0>
  %v4f16 = shufflevector <4 x half> undef, <4 x half> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %v8f16 = shufflevector <8 x half> undef, <8 x half> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  %v16f16 = shufflevector <16 x half> undef, <16 x half> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>

  %v2bf16 = shufflevector <2 x bfloat> undef, <2 x bfloat> undef, <2 x i32> <i32 1, i32 0>
  %v4bf16 = shufflevector <4 x bfloat> undef, <4 x bfloat> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %v8bf16 = shufflevector <8 x bfloat> undef, <8 x bfloat> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  %v16bf16 = shufflevector <16 x bfloat> undef, <16 x bfloat> undef, <16 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>

  %v2f32 = shufflevector <2 x float> undef, <2 x float> undef, <2 x i32> <i32 1, i32 0>
  %v4f32 = shufflevector <4 x float> undef, <4 x float> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  %v8f32 = shufflevector <8 x float> undef, <8 x float> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>

  %v2f64 = shufflevector <2 x double> undef, <2 x double> undef, <2 x i32> <i32 1, i32 0>
  %v4f64 = shufflevector <4 x double> undef, <4 x double> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>

  ret void
}

define void @vrev64() {
; CHECK-LABEL: 'vrev64'
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v4i8 = shufflevector <4 x i8> undef, <4 x i8> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v8i8 = shufflevector <8 x i8> undef, <8 x i8> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v16i8 = shufflevector <16 x i8> undef, <16 x i8> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v4i16 = shufflevector <4 x i16> undef, <4 x i16> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v8i16 = shufflevector <8 x i16> undef, <8 x i16> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v16i16 = shufflevector <16 x i16> undef, <16 x i16> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v4i32 = shufflevector <4 x i32> undef, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v8i32 = shufflevector <8 x i32> undef, <8 x i32> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
; CHECK-NEXT:  Cost Model: Found costs of 8 for: %v16i32 = shufflevector <16 x i32> undef, <16 x i32> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v4i64 = shufflevector <4 x i64> undef, <4 x i64> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v8i64 = shufflevector <8 x i64> undef, <8 x i64> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
; CHECK-NEXT:  Cost Model: Found costs of 8 for: %v16i64 = shufflevector <16 x i64> undef, <16 x i64> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v4f16 = shufflevector <4 x half> undef, <4 x half> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v8f16 = shufflevector <8 x half> undef, <8 x half> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v16f16 = shufflevector <16 x half> undef, <16 x half> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v4bf16 = shufflevector <4 x bfloat> undef, <4 x bfloat> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v8bf16 = shufflevector <8 x bfloat> undef, <8 x bfloat> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v16bf16 = shufflevector <16 x bfloat> undef, <16 x bfloat> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v4f32 = shufflevector <4 x float> undef, <4 x float> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v8f32 = shufflevector <8 x float> undef, <8 x float> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
; CHECK-NEXT:  Cost Model: Found costs of 8 for: %v16f32 = shufflevector <16 x float> undef, <16 x float> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v4f64 = shufflevector <4 x double> undef, <4 x double> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v8f64 = shufflevector <8 x double> undef, <8 x double> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
; CHECK-NEXT:  Cost Model: Found costs of 8 for: %v16f64 = shufflevector <16 x double> undef, <16 x double> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>
; CHECK-NEXT:  Cost Model: Found costs of RThru:0 CodeSize:1 Lat:1 SizeLat:1 for: ret void
;
  %v4i8 = shufflevector <4 x i8> undef, <4 x i8> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
  %v8i8 = shufflevector <8 x i8> undef, <8 x i8> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
  %v16i8 = shufflevector <16 x i8> undef, <16 x i8> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>

  %v4i16 = shufflevector <4 x i16> undef, <4 x i16> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
  %v8i16 = shufflevector <8 x i16> undef, <8 x i16> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
  %v16i16 = shufflevector <16 x i16> undef, <16 x i16> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>

  %v4i32 = shufflevector <4 x i32> undef, <4 x i32> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
  %v8i32 = shufflevector <8 x i32> undef, <8 x i32> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
  %v16i32 = shufflevector <16 x i32> undef, <16 x i32> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>

  %v4i64 = shufflevector <4 x i64> undef, <4 x i64> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
  %v8i64 = shufflevector <8 x i64> undef, <8 x i64> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
  %v16i64 = shufflevector <16 x i64> undef, <16 x i64> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>

  %v4f16 = shufflevector <4 x half> undef, <4 x half> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
  %v8f16 = shufflevector <8 x half> undef, <8 x half> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
  %v16f16 = shufflevector <16 x half> undef, <16 x half> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>

  %v4bf16 = shufflevector <4 x bfloat> undef, <4 x bfloat> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
  %v8bf16 = shufflevector <8 x bfloat> undef, <8 x bfloat> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
  %v16bf16 = shufflevector <16 x bfloat> undef, <16 x bfloat> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>

  %v4f32 = shufflevector <4 x float> undef, <4 x float> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
  %v8f32 = shufflevector <8 x float> undef, <8 x float> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
  %v16f32 = shufflevector <16 x float> undef, <16 x float> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>

  %v4f64 = shufflevector <4 x double> undef, <4 x double> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
  %v8f64 = shufflevector <8 x double> undef, <8 x double> undef, <8 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4>
  %v16f64 = shufflevector <16 x double> undef, <16 x double> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>

  ret void
}

define void @vrev32() {
; CHECK-LABEL: 'vrev32'
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v8i8 = shufflevector <8 x i8> undef, <8 x i8> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v16i8 = shufflevector <16 x i8> undef, <16 x i8> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v8i16 = shufflevector <8 x i16> undef, <8 x i16> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v16i16 = shufflevector <16 x i16> undef, <16 x i16> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v8i32 = shufflevector <8 x i32> undef, <8 x i32> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
; CHECK-NEXT:  Cost Model: Found costs of 8 for: %v16i32 = shufflevector <16 x i32> undef, <16 x i32> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v8i64 = shufflevector <8 x i64> undef, <8 x i64> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
; CHECK-NEXT:  Cost Model: Found costs of 8 for: %v16i64 = shufflevector <16 x i64> undef, <16 x i64> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v8f16 = shufflevector <8 x half> undef, <8 x half> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v16f16 = shufflevector <16 x half> undef, <16 x half> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v8bf16 = shufflevector <8 x bfloat> undef, <8 x bfloat> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v16bf16 = shufflevector <16 x bfloat> undef, <16 x bfloat> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v8f32 = shufflevector <8 x float> undef, <8 x float> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
; CHECK-NEXT:  Cost Model: Found costs of 8 for: %v16f32 = shufflevector <16 x float> undef, <16 x float> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v8f64 = shufflevector <8 x double> undef, <8 x double> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
; CHECK-NEXT:  Cost Model: Found costs of 8 for: %v16f64 = shufflevector <16 x double> undef, <16 x double> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
; CHECK-NEXT:  Cost Model: Found costs of RThru:0 CodeSize:1 Lat:1 SizeLat:1 for: ret void
;
  %v8i8 = shufflevector <8 x i8> undef, <8 x i8> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  %v16i8 = shufflevector <16 x i8> undef, <16 x i8> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>

  %v8i16 = shufflevector <8 x i16> undef, <8 x i16> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  %v16i16 = shufflevector <16 x i16> undef, <16 x i16> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>

  %v8i32 = shufflevector <8 x i32> undef, <8 x i32> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  %v16i32 = shufflevector <16 x i32> undef, <16 x i32> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>

  %v8i64 = shufflevector <8 x i64> undef, <8 x i64> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  %v16i64 = shufflevector <16 x i64> undef, <16 x i64> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>

  %v8f16 = shufflevector <8 x half> undef, <8 x half> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  %v16f16 = shufflevector <16 x half> undef, <16 x half> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>

  %v8bf16 = shufflevector <8 x bfloat> undef, <8 x bfloat> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  %v16bf16 = shufflevector <16 x bfloat> undef, <16 x bfloat> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>

  %v8f32 = shufflevector <8 x float> undef, <8 x float> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  %v16f32 = shufflevector <16 x float> undef, <16 x float> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>

  %v8f64 = shufflevector <8 x double> undef, <8 x double> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  %v16f64 = shufflevector <16 x double> undef, <16 x double> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>

  ret void
}

define void @vrev16() {
; CHECK-LABEL: 'vrev16'
; CHECK-NEXT:  Cost Model: Found costs of 1 for: %v16i8 = shufflevector <16 x i8> undef, <16 x i8> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v16i16 = shufflevector <16 x i16> undef, <16 x i16> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v16i32 = shufflevector <16 x i32> undef, <16 x i32> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
; CHECK-NEXT:  Cost Model: Found costs of 8 for: %v16i64 = shufflevector <16 x i64> undef, <16 x i64> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v16f16 = shufflevector <16 x half> undef, <16 x half> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
; CHECK-NEXT:  Cost Model: Found costs of 2 for: %v16bf16 = shufflevector <16 x bfloat> undef, <16 x bfloat> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
; CHECK-NEXT:  Cost Model: Found costs of 4 for: %v16f32 = shufflevector <16 x float> undef, <16 x float> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
; CHECK-NEXT:  Cost Model: Found costs of 8 for: %v16f64 = shufflevector <16 x double> undef, <16 x double> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
; CHECK-NEXT:  Cost Model: Found costs of RThru:0 CodeSize:1 Lat:1 SizeLat:1 for: ret void
;
  %v16i8 = shufflevector <16 x i8> undef, <16 x i8> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>

  %v16i16 = shufflevector <16 x i16> undef, <16 x i16> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>

  %v16i32 = shufflevector <16 x i32> undef, <16 x i32> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>

  %v16i64 = shufflevector <16 x i64> undef, <16 x i64> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>

  %v16f16 = shufflevector <16 x half> undef, <16 x half> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>

  %v16bf16 = shufflevector <16 x bfloat> undef, <16 x bfloat> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>

  %v16f32 = shufflevector <16 x float> undef, <16 x float> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>

  %v16f64 = shufflevector <16 x double> undef, <16 x double> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>

  ret void
}
