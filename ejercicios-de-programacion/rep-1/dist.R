# Generación de los puntos en el plano:
# Con un generador de valores aleatorios (función "runif") se crean las
# coordenadas de todos los puntos:
coorx <- runif(20)
coory <- runif(20)

# Nota: si pusieramos estos vectores como columnas en una planilla
# de cálculo tendríamos una matriz con las coordenadas de todos
# los puntos.

# Cada vez que se corran estas dos líneas se van a generar nuevos puntos, por
# lo que no es recomendable volver a hacer. Una forma de evitar que esto pase es
# agregando numerales ("#") al comienzo de las líneas para evitar su ejecución al
# usar source(dist.R).

# Se pueden graficar los puntos con este comando:
plot(coorx, coory)

# junto con el punto central:
points(0.5, 0.5, pch=19)

# Instrucciones:
# Para lograr el objetivo, debe seguir los siguentes pasos:
# 1. Determinar los lados de los triángulos rectángulos imaginarios (cat.ad y cat.op)
#    cuyas hipotenusas son son los segmentos entre el central y los demás puntos (AB)
#    en la figura 1).
# 2. Con la función hipot determinar el ancho de estas hipotenusas que son las 
#    distancias del centro a los demás puntos (dst), partiendo de los catetos hallados.
# 3. Con la función which o sus derivadas encontrar las posiciones del mínimo (i)
#    y el máximo (j) dentro del vector de distancias.
# 4. Utilizar estas posiciones para extraer las coordenadas correspondientes a
#    los puntos más cercano (A) y lejano (B) del central.

# Lista de objetos a obtener:
# cat.ad y cat.op: los "catetos" de todos los triángulos rectángulos formados con 
#                  el central y los demás puntos.
# dst: distancias entre (0.5, 0.5) y todos los demás puntos.
# i: posición de dst en el que se encuentra el mínimo de distancia
# j: posición de dst en el que se encuentra el máximo de distancia
# A: coordenadas del punto más cercano (vector de dos valores)
# B: coordenadas del punto más lejano  (vector de dos valores)

# Nota: use ?c para entender los últimos pasos, en caso de que sea necesario.

#===== Su código comienza aquí: =====#

cat.ad <- 0

cat.op <- 0

dst <- 0

i <- 0

j <- 0

A <- c(0, 0)

B <- c(0, 0)

#====== Aquí finaliza su código =====#

# Utilice las siguientes líneas para confirmar que el código
# hace la tarea correctamente:
plot(coorx, coory)
points(0.5, 0.5, pch=19)
points(coorx[i], coory[i], pch=19, col='red')
points(coorx[j], coory[j], pch=19, col='darkgreen')

