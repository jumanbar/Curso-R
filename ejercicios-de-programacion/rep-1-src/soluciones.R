## Errores:
# 1. En este caso hay un error en el nombre de la 
#    función: la función mean se escribe con minúsculas:
mean(5:7, na.rm = TRUE)
# 2. Aquí hay dos interpretaciones posibles: 
#    a) que falta una coma entre 8.564432 y el 3:
round(8.564432, 3)
#    b) que sobra el espacio en blanco entre 8.564432 y 3. 
round(8.5644323)
#    No podemos resolver con mayor precisión el problema 
#    ya que no tenemos el contexto en el que se ejecuta el 
#    comando.
# 3. El objeto bigcity no se encuentra, debido a que el 
#    paquete boot no fue cargado en la sessión. Se puede 
#    comprobar que es un objeto perteneciente a este paquete 
#    con el comando:
??bigcity
#    Se soluciona el error cargando dicho paquete, así:
library(boot)
head(bigcity)

# Uso de una función:
promedio <- mean(x)

## Secuencias de números enteros:
# 1.
10:10000
# 2.
20:10
# 3.
-8:6
# 4.
6:-8

## Secuencias de números (seq):
# 1.
seq(2, 110, by = 2)
# 2.
seq(1, 110, by = 2)
# 3.
seq(9, 0, length = 101)

# Concatenación
mi.otro.vector <- c(45, -76, 3, 4, 5, 6, 0.333)
# o 
mi.otro.vector <- c(45, -76, 3:6, 0.333)

# Modificación de un vector
mi.vector[2:3] <- c(100, 104)
# o
mi.vector[c(2, 3)] <- c(100, 104)

# Vector invertido
mi.vector[6:1]

## Matemática
# Algunas páginas de ayuda para matemática son: `Arithmetics`, `MathFun` y `log`, o `groupGeneric` para ver un vistazo general. 
# 1.
x <- c(-1, 1.5, 4)
5 * x ^ 3 - 2 * x ^ 2 + 11

# 2. 
x <- .5
h <- cos(x) ** 2 + sin(x) ** 2
# esto es equivalente a escribir:
h <- cos(x) ^ 2 + sin(x) ^ 2

# 3.
a <- 1:100
D <- a * sqrt(2)
# o alternativamente:
D <- a * 2 ^ (1 / 2)

# 4.
n <- 1
i <- 0:n
sum(1 / factorial(i))

n <- 5
i <- 0:n
sum(1 / factorial(i))

n <- 10
i <- 0:n
sum(1 / factorial(i))

# 5.
integral(log, 0, 20)

# Solución genérica
mi.vector[length(mi.vector):1]

# 1-varianza.R
out <- sum(s) / (length(x) - 1)

# Paradoja de Zenón:
n <- 20
e <- 1:n
s <- 1 / (2 ** e)
out <- sum(s2)


