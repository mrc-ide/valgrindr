install.packages("TMB")
library(TMB)

compile('e.cpp')
dyn.load(dynlib('e'))

MakeADFun(
		  data = list(dv = c(99)),
		  parameters = list(x = 1),
		  DLL = 'e'
)
