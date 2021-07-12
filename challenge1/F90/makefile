f90_eniac : eniac.f90 ../check/check
	gfortran -Wall -O2 $< -o $(@)
	./f90_eniac
	ln -sf ../reference/ENIAC.ref .
	../check/check 

f90_eniac_shift : shift_eniac.f90 ../check/check
	gfortran -Wall -O2 $< -o $(@)
	./f90_eniac
	ln -sf ../reference/ENIAC.ref .
	../check/check 
