# Grafica un histograma de una variable con distribución normal
# Una línea azul con la densidad y una roja con la densidad teórica.
x <- rnorm(200)
hist(x, freq=F)
lines(density(x), col='blue', lwd=2)
lines(density(x), col='blue', lwd=2)
curve(dnorm(x), col='red', lwd=2, add=TRUE)
