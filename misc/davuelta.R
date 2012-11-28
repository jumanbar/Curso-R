davuelta <- function(x) {
# Esta funcion sirve para "dar vuelta" un vector: cambia la primer mitad de
# sus elementos por la segunda. Ej:
# si x = 1 2 3 4
# el resultado debe ser:
# 3 4 1 2

  len <- length(x)
  if(len %% 2 != 0)
    stop('x no tienen un número par de elementos')
    # La función sólo funciona con vectores con longitud par. Este es el 
    # mensaje de error que va a mostrar si esta condición no se cumple.
  mitad <- len / 2
  x1  <- x[1:mitad]
  x2  <- x[mitad:Len]
  out <- (x2, x1)
  return(out)
}
