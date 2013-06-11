# Rep. V - ej. 3.b

# Instrucciones: 
# Arreglar la función radio para que ejecute correctamente
# sus cometidos. Hay 5 errores para corregir.

# Argumentos:
# - r: un único número

# Salida:
# Un vector numérico nombrado con los valores del perímetro,
# área y volumen de las figuras geométricas definidas (cfa.
# y esfera).

#===== Su código comienza aquí: =====#

radio <- function(r)
  # Imprime en la consola los valores de perímetro, área y
  # volúmen obtenidos a de un radio r.
  r <- abs(r)
  perimetro <- 2 * pi * r
  area      < - pi * r ^ 2
  volumen   <- 4 * pi * r ^ 3 / 3
  cat('Perimetro:", round(perimetro, 2), "\n')
  cat('Area:     ', round(area, 2), '/n')
  cat('Volumen:  ', round(volumen, 2), '\n')
  salida <- c(P=perimetro, A=area, V=volumen)
  invisible(salda)
}

#===== Su código termina aquí =======#

