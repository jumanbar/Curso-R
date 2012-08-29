x <- c(7.0, 6.4, 6.9, 5.5, 6.5, 5.7, 6.3, 4.9, 6.6, 5.2, 5.0, 5.9, 6.0, 6.1,
        5.6, 6.7, 5.6, 5.8, 6.2, 5.6, 5.9, 6.1, 6.3, 6.1, 6.4, 6.6, 6.8, 6.7,
	      6.0, 5.7, 5.5, 5.5, 5.8, 6.0, 5.4, 6.0, 6.7, 6.3, 5.6, 5.5, 5.5, 6.1,
	      5.8, 5.0, 5.6, 5.7, 5.7, 6.2, 5.1, 5.7)

# Instrucciones: crear el vector s el cual se obtiene aplicando el "término de
# la sumatoria" a todos los elementos de x. Nótese que para esto primero es
# necesario obtener el valor x_mean, es decir el promedio de x. Use la ayuda de
# R para buscar la función necesaria para obtenerlo, o use otra sumatoria para 
# calcularlo.
# s: es el vector final que va a ser la entrada de la función sum.
# out: el resultado final; varianza del vector x.
# Nota: no olvide que al resultado de la sumatoria hay que dividirlo entre n - 1
# (puede usar la función length para encontrar el n correcto)

#===== Su código comienza aquí: =====#

x_mean <- mean(x)
s <- (x - x_mean) ** 2
out <- sum(s) / (length(x) - 1)

#====== Aquí finaliza su código =====#

