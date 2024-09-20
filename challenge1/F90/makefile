all: f90_eniac f90_eniac_shift

f90_eniac : eniac.f90 ../check/check
	gfortran -Wall -O0 $< -o $(@)
	./f90_eniac
	ln -sf ../reference/ENIAC.ref .
	../check/check > delta.out 

f90_eniac_shift : shift_eniac.f90 ../check/check
	gfortran -Wall -O0 $< -o $(@)
	./f90_eniac_shift
	ln -sf ../reference/ENIAC.ref .
	../check/check > delta_shift.out 
