maux <- NULL
# 1.b-hist.R
source("hacemagia.R", encoding = "UTF-8")
magic$genero <- as.factor(magic$genero)
levels(magic$genero) <- c("mujer", "hombre")
reg.b <- lm(altura ^ 2 ~ peso - 1, magic, subset = peso < 95)
maux <- c(maux, "reg.b", "magic")


# 1.c-xxxx.R

## GUARDAR TODO:

save(list = maux, file = 'auxiliar.RData')

# guardar <- 0

