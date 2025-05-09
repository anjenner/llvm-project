// Purpose:
//      Test that \DexFinishTest can be used without a condition or hit_count,
//      so the test simply exits as soon as the line referenced by \DexFinishTest
//      is stepped on.
//      Test using the conditional controller (using \DexLimitSteps).
//
// The dbgeng driver doesn't support \DexLimitSteps yet.
// UNSUPPORTED: system-windows, system-darwin
//
// RUN: %dexter_regression_test_cxx_build %s -o %t
// RUN: %dexter_regression_test_run --binary %t -- %s | FileCheck %s
// CHECK: limit_steps_simple.cpp

int main() {
    int x = 0; // DexLabel('start')
    x = 1;
    x = 2; // DexLabel('finish_line')
} // DexLabel('finish')

// DexLimitSteps(from_line=ref('start'), to_line=ref('finish'))
// DexFinishTest(on_line=ref('finish_line'))
// DexExpectWatchValue('x', 0, 1)
