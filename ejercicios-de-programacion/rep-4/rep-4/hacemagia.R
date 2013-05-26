
nr <- sample(25:35, 1) * 2
mujeres <- sample(nr, nr / 2)
hombres <- (1:nr)[- mujeres]
# sexo <- character(nr)
sexo <- numeric(nr)
# sexo[mujeres] <- "mujer"
sexo[mujeres] <- 1
# sexo[hombres] <- "hombre"
sexo[hombres] <- 2
IMC <- rnorm(nr, 21.75, 2)
peso <- numeric(nr)
peso[mujeres] <- rnorm(nr / 2, 58, 4)
peso[hombres] <- rnorm(nr / 2, 70, 6)
peso <- round(peso, 1)
altura <- sqrt(peso / IMC)
altura <- round(altura, 2)
magic <- data.frame(peso = peso, sexo = sexo, altura = altura)

# aggregate(altura ~ sexo, data=magic, FUN = summary)
rm(nr, mujeres, hombres, sexo, IMC, peso, altura)

