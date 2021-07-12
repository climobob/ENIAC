eniac_c : eniac.c
	gcc -ansi $(@).c -o $(@)
	time ./eniac_c > ENIAC.OUT
	diff ENIAC.OUT ../reference/ENIAC.REF | wc
	ln -sf ../reference/ENIAC.REF .
	../check/check > delta.out 
