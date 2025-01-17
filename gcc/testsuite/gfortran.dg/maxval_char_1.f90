! { dg-do run }
program main
  implicit none
  integer, parameter :: n=5, m=3
  character(len=5), dimension(n) :: a
  character(len=5), dimension(n,m) :: b
  character(len=5) :: res
  integer, dimension(n,m) :: v
  real, dimension(n,m) :: r
  integer :: i,j
  logical, dimension(n,m) :: mask
  character(len=5), dimension(:,:), allocatable :: empty
  character(len=5) , parameter :: all_zero = achar(0) // achar(0) // achar(0) // achar(0) // achar(0)
  logical :: smask
  
  write (unit=a,fmt='(I5.5)') (21-i*i+6*i,i=1,n)
  res = maxval(a)
  if (res /= '00030') call abort
  res = maxval(a,dim=1)
  if (res /= '00030') call abort
  do
    call random_number(r)
    if (count(r>0.2) > 1) exit
  end do
  v = int(r * 100)
  write (unit=b,fmt='(I5.5)') v
  write (unit=res,fmt='(I5.5)') maxval(v)
  if (res /= maxval(b)) call abort
  smask = .true.
  if (res /= maxval(b, smask)) call abort
  smask = .false.
  if (all_zero /= maxval(b, smask)) call abort

  mask = v < 30
  write (unit=res,fmt='(I5.5)') maxval(v,mask)
  if (res /= maxval(b, mask)) call abort
  mask = .false.
  if (maxval(b, mask) /= all_zero) call abort
  allocate (empty(0:3,0))
  res = maxval(empty)
  if (res /= all_zero) call abort
end program main
