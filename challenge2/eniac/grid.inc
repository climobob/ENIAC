!  Non-dimensional constants
  INTEGER p, q, n, ip, jp
  PARAMETER (p = 18)
  PARAMETER (q = 15)
  PARAMETER (ip = 9)
  PARAMETER (jp = 13)
  PARAMETER (n = 24)   ! number of time steps per day

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
