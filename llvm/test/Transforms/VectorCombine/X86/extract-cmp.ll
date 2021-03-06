; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -vector-combine -S -mtriple=x86_64-- | FileCheck %s

define i1 @cmp_v4i32(<4 x float> %arg, <4 x float> %arg1) {
; CHECK-LABEL: @cmp_v4i32(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[T:%.*]] = bitcast <4 x float> [[ARG:%.*]] to <4 x i32>
; CHECK-NEXT:    [[T3:%.*]] = bitcast <4 x float> [[ARG1:%.*]] to <4 x i32>
; CHECK-NEXT:    [[TMP0:%.*]] = icmp eq <4 x i32> [[T]], [[T3]]
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <4 x i1> [[TMP0]], i32 0
; CHECK-NEXT:    br i1 [[TMP1]], label [[BB6:%.*]], label [[BB18:%.*]]
; CHECK:       bb6:
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq <4 x i32> [[T]], [[T3]]
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <4 x i1> [[TMP2]], i32 1
; CHECK-NEXT:    br i1 [[TMP3]], label [[BB10:%.*]], label [[BB18]]
; CHECK:       bb10:
; CHECK-NEXT:    [[TMP4:%.*]] = icmp eq <4 x i32> [[T]], [[T3]]
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <4 x i1> [[TMP4]], i32 2
; CHECK-NEXT:    br i1 [[TMP5]], label [[BB14:%.*]], label [[BB18]]
; CHECK:       bb14:
; CHECK-NEXT:    [[TMP6:%.*]] = icmp eq <4 x i32> [[T]], [[T3]]
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <4 x i1> [[TMP6]], i32 3
; CHECK-NEXT:    br label [[BB18]]
; CHECK:       bb18:
; CHECK-NEXT:    [[T19:%.*]] = phi i1 [ false, [[BB10]] ], [ false, [[BB6]] ], [ false, [[BB:%.*]] ], [ [[TMP7]], [[BB14]] ]
; CHECK-NEXT:    ret i1 [[T19]]
;
bb:
  %t = bitcast <4 x float> %arg to <4 x i32>
  %t2 = extractelement <4 x i32> %t, i32 0
  %t3 = bitcast <4 x float> %arg1 to <4 x i32>
  %t4 = extractelement <4 x i32> %t3, i32 0
  %t5 = icmp eq i32 %t2, %t4
  br i1 %t5, label %bb6, label %bb18

bb6:
  %t7 = extractelement <4 x i32> %t, i32 1
  %t8 = extractelement <4 x i32> %t3, i32 1
  %t9 = icmp eq i32 %t7, %t8
  br i1 %t9, label %bb10, label %bb18

bb10:
  %t11 = extractelement <4 x i32> %t, i32 2
  %t12 = extractelement <4 x i32> %t3, i32 2
  %t13 = icmp eq i32 %t11, %t12
  br i1 %t13, label %bb14, label %bb18

bb14:
  %t15 = extractelement <4 x i32> %t, i32 3
  %t16 = extractelement <4 x i32> %t3, i32 3
  %t17 = icmp eq i32 %t15, %t16
  br label %bb18

bb18:
  %t19 = phi i1 [ false, %bb10 ], [ false, %bb6 ], [ false, %bb ], [ %t17, %bb14 ]
  ret i1 %t19
}

define i32 @cmp_v2f64(<2 x double> %x, <2 x double> %y, <2 x double> %z) {
; CHECK-LABEL: @cmp_v2f64(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = fcmp oeq <2 x double> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x i1> [[TMP0]], i32 1
; CHECK-NEXT:    br i1 [[TMP1]], label [[T:%.*]], label [[F:%.*]]
; CHECK:       t:
; CHECK-NEXT:    [[TMP2:%.*]] = fcmp ogt <2 x double> [[Y]], [[Z:%.*]]
; CHECK-NEXT:    [[TMP3:%.*]] = extractelement <2 x i1> [[TMP2]], i32 1
; CHECK-NEXT:    [[E:%.*]] = select i1 [[TMP3]], i32 42, i32 99
; CHECK-NEXT:    ret i32 [[E]]
; CHECK:       f:
; CHECK-NEXT:    ret i32 0
;
entry:
  %x1 = extractelement <2 x double> %x, i32 1
  %y1 = extractelement <2 x double> %y, i32 1
  %cmp1 = fcmp oeq double %x1, %y1
  br i1 %cmp1, label %t, label %f

t:
  %z1 = extractelement <2 x double> %z, i32 1
  %cmp2 = fcmp ogt double %y1, %z1
  %e = select i1 %cmp2, i32 42, i32 99
  ret i32 %e

f:
  ret i32 0
}
