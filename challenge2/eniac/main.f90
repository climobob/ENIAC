PROGRAM ENIAC
!  Emulate the first successful numerical weather prediction.
!  It was run on the ENIAC during 1948 and 1949.
!  The results and method were written up in Tellus 2, p. 237 1950.
!      Robert Grumbine 2 May 1995. Fortran 77
! Typographical translation to Fortran 90 23 March 2019

  INCLUDE "grid.inc"
  
!  Declare temporary arrays -
!    These were used because of the memory constraint on the ENIAC -- 
!      these values were on punched cards recycled through the system
  REAL s(0:p,0:p), t(0:q,0:q), v(0:p,0:q)
  REAL r(0:p,0:q), f(0:p,0:q), h(0:p,0:q)
  REAL a(0:p,0:q), b(0:p,0:q)
  REAL alpha(0:p,0:q), beta(0:p,0:q)
  REAL zp(0:p,0:q), zetap(0:p,0:q)
  
!  Declare data, physical info.
  REAL z(0:p,0:q), zeta(0:p,0:q), eta(0:p,0:q)
  
!  Declare computational variables
  INTEGER i, j, k, l, m
  
!***********************************************************!!
! BEGIN THE EXECUTION HERE
  
  CALL initialize(s,t,v,r,f,h,z,zeta,eta)

!     END OF THE PRELIMINARY SET UP SECTION
!***********************************************************!!
!  BEGIN THE ITERATIVE SOLUTION OF THE EQUATIONS
  PRINT *,SECOND()*1000.,' ms'
  DO k = 0, 60 !60 hours is about the instability limit

    CALL step(s,t,v,r,f,h,z,zeta,eta, k)
  
  ENDDO
  
  PRINT *,SECOND()*1000.,' ms'
 
!***********************************************************!! 

  END
