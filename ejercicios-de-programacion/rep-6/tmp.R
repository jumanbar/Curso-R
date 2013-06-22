# Rep. VI - ej. X.x

# Instrucciones: 
# Debe utilizar un loop for para determinar la cantidad de NAs en cada fila de
# la matriz datos. Las sumas se almacenarán en el vector out, el cual debe
# tener la longitud adecuada antes de iniciarse el loop.

# Objetivos:
# Utilizar el loop for. No se permiten while, apply ni similares.
# out*: vector con las cantidades de NAs de las filas de la matriz datos.

# Generación de la matriz datos:
datos <- matrix(rpois(rpois(1, 125) * 15, 43), ncol = 15)

#===== Su código comienza aquí: =====#

f <- function(x, u)   # f sería la función (opcional)
  sum(x > u)

out <- apply(datos, 1, f, u = 45) # Aquí debe usar la función apply

#===== Su código termina aquí =======#

