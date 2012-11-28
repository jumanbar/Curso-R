triangulo <- function(cat.ad, cat.op) {
  hipot <- sqrt(cat.ad ** 2 + cat.op ** 2)
  area  <- cat.op * cat.ad / 2
  ang.ad <- acos(cat.ad / hipot) * 180 / pi
  ang.op <- asin(cat.ad / hipot) * 180 / pi
  out <- list(hipotenusa = hipot, area = area, 
              angulo.adyacente = ang.ad, 
              angulo.opuesto = ang.op)
  out
}
