# Lo primero es crear un conjunto de puntos en el plano con un generador de
# valores aleatorios (función "runif"):
coorx <- runif(20)
coory <- runif(20)
# Nota: cada vez que se corran estas dos líneas se van a generar nuevos puntos,
# por lo que no es recomendable hacer. Una forma de evitar que esto pase es
# agregando numerales ("#") al comienzo de las líneas para evitar correrlas al
# usar "source".

# Posteriormente se grafican esos puntos y se agrega el "punto central", en las
# coordenadas (0.5, 0.5).
plot(coorx, coory)
points(0.5, 0.5, pch=19)

# Instrucciones: utilizando nuevamente las funciones hipot, which, which.max, 
# además de which.min, encuentre cuales son los puntos A y B, el más cercano y
# el más lejano respectivamente al central = (0.5, 0.5)
# cat.ad y cat.op: los "catetos" de todos los triángulos formados con el punto
# central y los demás puntos.
# dst: distancias entre (0.5, 0.5) y todos los demás puntos.
# i: posición de dst en el que se encuentra el mínimo de distancia
# j: posición de dst en el que se encuentra el máximo de distancia
# A: coordenadas del punto más cercano (vector de dos valores)
# B: coordenadas del punto más lejano  (vector de dos valores)
# Nota: use ?c para entender los últimos pasos
#===== Su código comienza aquí: =====#

cat.ad <-

cat.op <-

dst <-

i <-

j <- 

A <- c( , )

B <- c( , )

#====== Aquí finaliza su código =====#

# Para confirmar que el código hace la tarea correctamente:
plot(coorx, coory)
points(0.5, 0.5, pch=19)
points(coorx[i], coory[i], pch=19, col='red')
points(coorx[j], coory[j], pch=19, col='darkgreen')
