f77_eniac : ENIAC.f ../check/check
	gfortran -Wall -O0 $< -o $(@)
	./f77_eniac
	ln -sf ../reference/ENIAC.ref .
	../check/check > delta.out 

