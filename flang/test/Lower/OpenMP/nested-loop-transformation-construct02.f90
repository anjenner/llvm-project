! Test to ensure TODO message is emitted for unroll OpenMP 5.1 Directives when they are nested.

!RUN: not %flang_fc1 -emit-hlfir -fopenmp -fopenmp-version=51 -o - %s 2>&1 | FileCheck %s

program loop_transformation_construct
  implicit none
  integer, parameter :: I = 10
  integer :: x
  integer :: y(I)

  !$omp do
  !$omp unroll
  do x = 1, I
    y(x) = y(x) * 5
  end do
  !$omp end unroll
  !$omp end do
end program loop_transformation_construct

!CHECK: not yet implemented: Applying a loop-associated on the loop generated by the unroll construct
