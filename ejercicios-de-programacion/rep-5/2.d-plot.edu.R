# Rep. V - ej. 2.d

# NO IMPLEMENTADO TODAVÍA (6/2013)

# Instrucciones:

# Argumentos:
# - x:
# - ...:

# Salida:
# NULL

#===== Su código comienza aquí: =====#

plot.edu <- function(x, ...) {
  plot(TA ~ PC, x$datos, main = "Tasa de alfabetización y porcentaje de conclusión",
       ylab = "T.A. (15 a 24 años)", xlab = "P.C.", ...)
  abline(x$reg, col = 2)
  NULL
}

#===== Su código termina aquí =======#
