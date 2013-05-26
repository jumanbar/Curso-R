
nr <- sample(25:35, 1) * 2
mujeres <- sample(nr, nr / 2)
hombres <- (1:nr)[- mujeres]
# genero <- character(nr)
genero <- numeric(nr)
# genero[mujeres] <- "mujer"
genero[mujeres] <- 1
# genero[hombres] <- "hombre"
genero[hombres] <- 2
IMC <- rnorm(nr, 21.75, 2)
peso <- numeric(nr)
peso[mujeres] <- rnorm(nr / 2, 58, 4)
peso[hombres] <- rnorm(nr / 2, 70, 6)
peso <- round(peso, 1)
altura <- sqrt(peso / IMC)
altura <- round(altura, 2)
magic <- data.frame(peso = peso, genero = genero, altura = altura)

# aggregate(altura ~ genero, data=magic, FUN = summary)
rm(nr, mujeres, hombres, genero, IMC, peso, altura)

