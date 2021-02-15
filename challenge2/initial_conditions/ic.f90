PROGRAM ic
!  Emulate the first successful numerical weather prediction.
!  It was run on the ENIAC during 1948 and 1949.
!  The results and method were written up in Tellus 2, p. 237 1950.
!      Robert Grumbine 2 May 1995. Fortran 77
! Typographical translation to Fortran 90 23 March 2019

!  Non-dimensional constants
  INTEGER p, q, n, ip, jp
  PARAMETER (p = 18)
  PARAMETER (q = 15)
  PARAMETER (n = 24)
  PARAMETER (ip = 9)
  PARAMETER (jp = 13)

!  Declare Dimensional Constants
  REAL g, radius, omega, ds, dt
  PARAMETER (g      = 9.81)
  PARAMETER (radius = 6.37E6)
  PARAMETER (omega  = 7.292E-5)
  PARAMETER (ds     = 7.36E5)
  PARAMETER (dt     = omega*86400/n)
  
!  Rescale feet (input dimension of Z's) to meters
  REAL fttom
  PARAMETER (fttom = 3.048)
  REAL pi
  PARAMETER (pi = 3.141592654)
  
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
!  Set up the initial conditions deck
  DATA (z(0,j),j=0,q)  /910, 899, 900, 885, 880, 890, 895, 885, 895, 920, 910, 890, 870, 860, 850, 840/
  DATA (z(1,j),j=0,q)  /907, 900, 895, 880, 870, 885, 890, 890, 900, 925, 920, 900, 880, 870, 840, 830/
  DATA (z(2,j),j=0,q)  /905, 901, 890, 877, 865, 865, 880, 885, 900, 920, 930, 910, 885, 860, 820, 800/
  DATA (z(3,j),j=0,q)  /908, 901, 888, 870, 847, 830, 830, 850, 890, 900, 900, 890, 860, 800, 760, 720/
  DATA (z(4,j),j=0,q)  /910, 905, 888, 871, 840, 790, 760, 780, 860, 865, 830, 800, 750, 720, 680, 680/
  DATA (z(5,j),j=0,q)  /915, 910, 898, 880, 850, 795, 740, 740, 800, 830, 770, 720, 685, 670, 670, 670/
  DATA (z(6,j),j=0,q)  /918, 919, 915, 900, 865, 810, 750, 730, 750, 740, 730, 690, 655, 665, 665, 665/
  DATA (z(7,j),j=0,q)  /930, 931, 926, 915, 883, 825, 770, 725, 700, 680, 670, 660, 660, 655, 655, 660/
  DATA (z(8,j),j=0,q)  /932, 945, 942, 932, 900, 850, 780, 720, 660, 610, 600, 620, 640, 650, 655, 665/
  DATA (z(9,j),j=0,q)  /935, 950, 950, 942, 924, 890, 800, 710, 640, 600, 590, 580, 600, 645, 660, 675/
  DATA (z(10,j),j=0,q) /933, 940, 945, 942, 926, 890, 810, 720, 650, 600, 580, 560, 620, 655, 670, 685/
  DATA (z(11,j),j=0,q) /931, 934, 939, 935, 897, 880, 830, 750, 690, 620, 600, 600, 630, 670, 685, 700/
  DATA (z(12,j),j=0,q) /925, 926, 925, 920, 890, 865, 830, 760, 710, 670, 620, 620, 650, 690, 700, 710/
  DATA (z(13,j),j=0,q) /920, 919, 896, 903, 875, 845, 810, 760, 735, 730, 710, 720, 720, 740, 730, 730/
  DATA (z(14,j),j=0,q) /915, 913, 889, 897, 860, 825, 790, 780, 790, 830, 840, 850, 820, 780, 760, 740/
  DATA (z(15,j),j=0,q) /912, 910, 885, 891, 860, 830, 820, 840, 860, 890, 900, 900, 850, 790, 770, 755/
  DATA (z(16,j),j=0,q) /908, 908, 885, 900, 880, 870, 880, 890, 910, 925, 920, 900, 870, 800, 780, 765/
  DATA (z(17,j),j=0,q) /905, 907, 886, 905, 890, 900, 910, 920, 920, 920, 900, 890, 870, 840, 800, 780/
  DATA (z(18,j),j=0,q) /903, 906, 886, 910, 900, 920, 920, 925, 915, 910, 890, 880, 860, 850, 820, 810/
!***********************************************************!!

! BEGIN THE EXECUTION HERE
! This file is not comparable to anything in the original program.
  OPEN (UNIT=1, FILE="original_eniac_ic.txt", FORM="FORMATTED")
  OPEN (UNIT=2, FILE="original_eniac_ic.bin", FORM="UNFORMATTED")
  
  PRINT *,SECOND()*1000.,' ms'
!  z = z - 820
! Rescale the heights (10's of feet) to metric
  z    = z / fttom
  PRINT *,'average initial z = ',SUM(z)/FLOAT(p+1)/FLOAT(q+1)
  WRITE(1,*) z
  WRITE(2) z

  PRINT *,SECOND()*1000.,' ms'
 
!***********************************************************!! 

  END
