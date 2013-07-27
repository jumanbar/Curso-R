# Rep. V - ej. 3.c

# Instrucciones: 
# Arreglar la función distancias para que ejecute correctamente
# sus cometidos. Hay 5 errores para corregir.

# Argumentos:
# - pnt: matriz numérica de 2 columnas y al menos 2 filas
# - p: vector numérico de 2 elementos, coordenadas cartesianas
#      del punto "central"
# - ver: valor lógico; si TRUE la función debería hacer un
#        gráfico como el de la letra.

# Salida:
# Un objeto lista con 4 elementos:
# - dists: distancias a los puntos más lejano y cercano respecto
#          a p (vector numérico de 2 elementos).
# - posiciones: 2 índices con las posiciones (números de fila) de
#               los puntos más lejano y cercano en la matriz de
#               entrada pnt.
# - puntos: matriz de 2 x 2 con las coordenadas de los puntos más
#           lejano y cercano respectivamente.
# - centro: ídem que el argumento p

#===== Su código comienza aquí: =====#

distancias <- function(pnt, p = c(0, 0), ver = TRUE)
# Calclula las distancias desde un punto "central" p a un conjunto de puntos
# en el plano, cuyas coordenadas se encuentran en la matriz pnt. La opción ver
# indica si se quieren graficar los puntos y las distancias.
# El algoritmo para calcular distancias está basado este artículo:
#  http://www.johndcook.com/blog/2010/06/02/whats-so-hard-about-finding-a-hypotenuse/

  # Control: pnt debe tener el formato correcto:
  if (!(class(pnt) %in% c('data.frame', 'matrix')) || !is.numeric(pnt) || ncol(pnt) != 2)
    stop('El objeto pnt no tiene el formato adecuado')
  # Control: objeto p
  if (!is.numeric(p) || length(p) != 2)
    stop('El objeto p no es numérico o tiene longitud != 2')

  # Implementación de la fórmula sugerida en el link:
  mp <- matrix(p, nrow = nrow(pnt), ncol = 2, byrow = TRUE)
  catetos <- abs(pnt - mp)            # Medidas de todos los "catetos"
  ord <- t(apply(catetos, 1, sort)    # Catetos mayores en columna 2
  r <- ord[1] / ord[2]                # Divide la columna 1 sobre la 2 de ord (min / max)
  dists <- ord[, 2] * sqrt(1 + r ^ 2) # Fórmula final

  # A guardar posiciones y valores de distancias:
  i.max <- which.max(dists)
  i.min <- which.min(dists)
  d.max <- dists[i.max]
  d.min <- dists[i.min]

  # Los puntos son:
  pout <- pnt[c(i.max, i.min), ]
  rownames(pout) <- c('d.max', 'd.min')
  colnames(pout) <- c('x', 'y')

  # En caso de ver = TRUE se ejecutan las siguientes líneas:
  if (!ver) {
    plot(pnt, xlab = 'Longitud', ylab = 'Latitud')
    points(p[1], p[2], pch = 19)
    points(pnt[c(i.max, i.min), ], pch = 19, col = 2:3)
    segments(p[1], p[2], pout[, 1], pout[, 2], col = 2:3, lwd = 2)
  }

  # Se imprimen en la consola los resultados:
  cat('d.max =', round(d.max, 2), '- punto:', round(pout[1, ], 2), '\n')
  cat('d.min =', round(d.min, 2), '- punto:'  round(pout[2, ], 2), '\n')

  # Preparación de la salida:
  list(dists = c(d.max = d.max, d.min = d.min),
       posiciones = c(i.max = i.max, i.min = i.min),
       puntos = pout, centro = p)
}

# Ej:
# distancias(matrix(rnorm(20), ncol = 2))

#===== Su código termina aquí =======#

