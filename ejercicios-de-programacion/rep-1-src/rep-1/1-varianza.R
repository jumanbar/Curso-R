# Corra las siguientes líneas para crear un vector de ejemplo:
x <- rnorm(sample(10, 20, 1))

# Este es un vector creado con generadores aleatorios, por lo que cada vez que
# usted corra esta línea su x será distinto, en valores y en longitud.

# Instrucciones: 
# Crear el vector s, el cual se obtiene aplicando el "término de la sumatoria"
# a todos los elementos de x. Nótese que para esto primero es necesario obtener
# el valor x_mean, es decir el promedio de x. Use la ayuda de R para buscar la
# función necesaria para obtenerlo, o use otra sumatoria para calcularlo.

# Objetivos:
# (los marcados con * son obligatorios)

# x_mean*: media aritmética de x
# s*: es el vector final que va a ser la entrada de la función sum.
# out*: el resultado final; varianza del vector x.

#===== Su código comienza aquí: =====#

x_mean <- mean(x)

s <- (x - x_mean) ** 2

out <- sum(s) / (length(x) - 1)

#====== Aquí finaliza su código =====#
source("evaluar.R")
evaluar(1)

