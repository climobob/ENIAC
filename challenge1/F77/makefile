f77_eniac : ENIAC.f ../check/check
	gfortran -Wall -O2 $< -o $(@)
	./f77_eniac
	ln -sf ../reference/ENIAC.ref .
	../check/check 

