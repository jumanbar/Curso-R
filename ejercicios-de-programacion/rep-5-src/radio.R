radio <- function(r)
  # Imprime en la consola los valores de perímetro, área y
  # volúmen obtenidos a de un radio r.
  r <- abs(r)
  perimetro <- 2 * pi * r
  area      < - pi * r ^ 2
  volumen   <- 4 * pi * r ^ 3 / 3
  cat('Perímetro:", round(perimetro, 2), "\n')
  cat('Área:     ', round(area, 2), '/n')
  cat('Volumen:  ', round(volumen, 2), '\n')
  salida <- c(P=perimetro, A=area, V=volumen)
  invisible(salda)
}
