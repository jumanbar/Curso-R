promProg <- function(x) {
# Calcula promedios progresivos: el promedio por columnas de la matriz x para
# las primeras dos filas, luego las primeras tres, cuatro, etc... Los valores
# son guardados en la matriz "salida".
# Entradas:
#   x: matriz numérica
# Salidas:
#   matriz numérica, ver descripción arriba.
  salida <- matrix(0, nrow(x), nrow(x))
  salida[1,] <- x[1,]
  for (i in 2:nrow(x)) {
    proms <- colMeans(x[1:i,])
    salida[i] <- proms
  return(salida)
}
