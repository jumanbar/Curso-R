hipot <- function(cat.ad , cat.op) {
# Calcula la hipotenusa de un triángulo rectángulo a partir de los valores de
# los catetos, cat.ad y cat.op.
  out <- sqrt(cat.ad ** 2 + cat.op ** 2)
  out
}

#===== Su código comienza aquí: =====#

area <- function(ca, co) {
# Acepta como argumentos los valores de los dos catetos.
  co * ca / 2
}

co <- function(ca, h) {
# Acepta como argumentos el valor del cateto adyacente y de la hipotenusa (¡en ese orden!)
  sqrt(h ^ 2 - ca ^ 2)
}
#===== Su código termina aquí =======#
