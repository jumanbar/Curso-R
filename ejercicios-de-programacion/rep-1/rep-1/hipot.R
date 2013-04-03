hipot <- function(cat.ad , cat.op) {
# Calcula la hipotenusa de un triángulo rectángulo a partir de los valores de
# los catetos, cat.ad y cat.op.
  out <- sqrt(cat.ad ** 2 + cat.op ** 2)
  out
}

#===== Su código comienza aquí: =====#

area <- function(a, b) {
# Acepta como argumentos los valores de los dos catetos.
  a * b / 2
}

co <- function(a, b) {
# Acepta como argumentos el valor del cateto adyacente y de la hipotenusa (¡en ese orden!)
  sqrt(abs(a ** 2 - b ** 2))
}
#===== Su código termina aquí =======#

