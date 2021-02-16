SUBROUTINE step(s,t,v,f,h,z,zeta,eta, k)
! carry forward 1 time step
  IMPLICIT none

  INCLUDE "grid.inc"

! grid and other fixed information:
  REAL s(0:p,0:p), t(0:q,0:q), v(0:p,0:q)
  REAL f(0:p,0:q), h(0:p,0:q)
!  Declare data, physical info.
  REAL z(0:p,0:q), zeta(0:p,0:q), eta(0:p,0:q)
  
! Local grids:
  REAL a(0:p,0:q), b(0:p,0:q)
  REAL alpha(0:p,0:q), beta(0:p,0:q)
  REAL zp(0:p,0:q), zetap(0:p,0:q)
  
!  Declare computational variables
  INTEGER i, j, k, l, m
  
!***********************************************************!!
! main handles this:  CALL initialize(s,t,v,r,f,h,z,zeta,eta)
  
  a = 0.0
  b = 0.0
  alpha = 0.0
  beta  = 0.0
  zp    = 0.0
  zetap = 0.0

!***********************************************************!!
!  BEGIN THE ITERATIVE SOLUTION OF THE EQUATIONS
  PRINT *,SECOND()*1000.,' ms'
  
    DO j = 1, q-1
      DO i = 1, p-1
        eta(i,j) = f(i,j)+h(i,j)*zeta(i,j)
      ENDDO
    ENDDO

    DO i = 1, p-1
      j = 0
      IF (z(i+1,0) .LT. z(i-1,0)) THEN
        eta(i,j) = f(i,j)+h(i,j)*zeta(i,j)
      ENDIF
      j = q
      IF (z(i+1,q) .GT. z(i-1,q)) THEN
        eta(i,j) = f(i,j)+h(i,j)*zeta(i,j)
      ENDIF
    ENDDO

    DO j = 1, q-1
      i = 0
      IF (z(0,j+1).GT.z(0,j-1)) THEN
        eta(i,j) = f(i,j)+h(i,j)*zeta(i,j)
      ENDIF
      i = p
      IF (z(p,j+1).LT.z(p,j-1)) THEN 
        eta(i,j) = f(i,j)+h(i,j)*zeta(i,j)
      ENDIF
    ENDDO
 
    DO j = 1, q-1
      DO i = 1, p-1
        zetap(i,j) = 0.5*( (eta(i+1,j)-eta(i-1,j)) *(z(i,j+1)-z(i,j-1)) &
            -   (eta(i,j+1)-eta(i,j-1)) *(z(i+1,j)-z(i-1,j)) )
      ENDDO
    ENDDO
 
    DO j = 1, q-1
      DO i = 1, p-1
        alpha(i,j) = 0.0
        DO l = 1, p-1
          alpha(i,j)=alpha(i,j)+s(l,i)*zetap(l,j)
        ENDDO
      ENDDO
    ENDDO
 
    DO j = 1, q-1
      DO i = 1, p-1
        a(i,j) = 0.0
        DO m = 1, q-1
          a(i,j) = a(i,j) + t(m,j)*alpha(i,m)
        ENDDO
      ENDDO
    ENDDO
 
    b = -a / v
    !b(1:p-1,1:q-1) = -a(1:p-1,1:q-1) / v(1:p-1,1:q-1)
   
    DO j = 1, q-1
      DO i = 1, p-1
        beta(i,j) = 0.0
        DO m = 1, q-1
          beta(i,j) = beta(i,j)+t(m,j)*b(i,m)
        ENDDO
      ENDDO
    ENDDO
 
    DO j = 1, q-1
      DO i = 1, p-1
        zp(i,j) = 0.0
        DO l = 1, p-1
          zp(i,j) = zp(i,j)+s(l,i)*beta(l,j)
        ENDDO
      ENDDO
    ENDDO

!  SECTION FOR CARRYING FORWARD THE EXTRAPOLATION 
   IF (k.EQ.0) THEN
     z    = z    + dt*zp
     zeta = zeta + dt*zetap
    ELSE
     z    = z    + 2.*dt*zp
     zeta = zeta + 2.*dt*zetap
   ENDIF

!  Apply the inflow/outflow conditions  
  DO j = 1, q-1
    IF (z(0,j+1) .GT. z(0,j-1)) THEN
      z(0,j)    = z(0,j)
      zeta(0,j) = 2.*zeta(1,j)-zeta(2,j)
     ELSE
      z(0,j)    = z(0,j)
      zeta(0,j) = zeta(0,j)
    ENDIF
    IF (z(p,j+1) .LT. z(p,j-1)) THEN
      z(p,j)    = z(p,j)
      zeta(p,j) = 2.*zeta(p-1,j)-zeta(p-2,j)
     ELSE
      z(p,j)    = z(p,j)
      zeta(p,j) = zeta(p,j)
    ENDIF
  ENDDO
  DO i = 1, p-1
    IF (z(i+1,0) .LT. z(i-1,0)) THEN
      z(i,0)    = z(i,0)
      zeta(i,0) = 2.*zeta(i,1)-zeta(i,2)
    ELSE
      z(i,0)    = z(i,0)
      zeta(i,0) = zeta(i,0)
    ENDIF
    IF (z(i+1,q) .GT. z(i-1,q)) THEN
      z(i,q)    = z(i,q)
      zeta(i,q) = 2.*zeta(i,q-1)-zeta(i,q-2)
    ENDIF
  ENDDO

  PRINT *,SECOND()*1000.,' ms'
   
  WRITE (1,9003) k
  WRITE (1,9001) ((z(i,j),j=0,q),i=0,p)
  WRITE (1,9002)
 9001 FORMAT (16F7.2)
 9002 FORMAT (' ')
 9003 FORMAT (I3)
  
!***********************************************************!! 

RETURN
END SUBROUTINE step
