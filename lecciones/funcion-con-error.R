davuelta <- function(x) {
# Esta funcion sirve para "dar vuelta" un vector: cambia la primer mitad de
# sus elementos por la segunda. Ej:
# si x = 1 2 3 4
# el resultado debe ser:
# 3 4 1 2

  len <- length(x)
  if(len %% 2 != 0)
    stop('x no tienen un número par de elementos')
  mitad <- len / 2
  x1  <- x[1:mitad]
#   x2  <- x[(mitad + 1):len]
  x2  <- x[mitad:Len]
#   out <- c(x2, x1)
  out <- (x2, x1)
  return(out)
}
