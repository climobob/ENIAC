all: mapping ic

mapping : mapping.f90
	gfortran -Wall $< -o $(@)

ic : ic.f90
	gfortran -Wall $< -o $(@)

