# ENIAC
The ENIAC Numerical Weather Prediction model and challenge

Tag 1.x.x is for building codes that implement the first successful Numerical Weather Prediction model -- (Charney, Fjørtoft and Von Neumann, 1950)[https://onlinelibrary.wiley.com/doi/abs/10.1111/j.2153-3490.1950.tb00336.x]. Fortran 77, Fortran 90, and C are already in place. There is also a reference result and a program to check differences between your run and the Fortran 77 standard results. It's also the case that the answers are unlikely to match exactly. The boundary conditions are unconditionally unstable, blowing up after approximately 2.5 days, and the model is very subject to the butterfly effect, so that even minor changes in numerics (compiler settings, languages, ...) produce observable differences in the results within the first day.

Tag 2.x.x is for the challenge -- writing the best model that takes only 10, or 1000, or 1 million, ... times as much compute as ENIAC. As a very rough ballpark estimate, you have easily 30 million times the computing power of the ENIAC, on one processor. The original calculation required almost 24 hours to carry out a 24 hour forecast (about 86,400 seconds). On one processor on my desk, it's about 86 milliseconds for 3 days, for something like 3 million times the speed.

For more detail see https://github.com/grumbiner/ENIAC/wiki/ENIAC-Home
