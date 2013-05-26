aux <- NULL
# 1.b-hist.R
source("hacemagia.R")
magic$sexo <- as.factor(magic$sexo)
levels(magic$sexo) <- c("mujer", "hombre")
aux <- c(aux, "magic")


# 1.c-xxxx.R

## GUARDAR TODO:

save(list = aux, file = 'auxiliar.RData')

# guardar <- 0

