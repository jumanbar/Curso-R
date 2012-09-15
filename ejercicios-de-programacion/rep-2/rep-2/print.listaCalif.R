class(analisisCalif) <- "listaCalif"
# Instrucciones: los objetos cal, gen y ctg ya deben encontrarse en el área de trabajo para completar 
# este script. En caso contrario, corra "load('ej2.rda')" para cargar estos objetos ya preparados.
# Objetivos:
# Hacer una salida que incluya los cálculos correctos de los objetos:
# ptot: porcentaje de aprobados sobre el total.
# pvar: porcentaje de aprobados sobre el total de mujeres.
# pmuj: porcentaje de aprobados sobre el total de hombres.
# Recuerde que en la corrección los objetos cal y gen son creados nuevamente con generadores de números 
# aleatorios.
print.listaCalif <- function(x) {
  cat('Porcentaje total de aprobaciones:', round(x$aprob$atot, 2), '%\n')
  cat('  En varones:', round(x$aprob$avar, 2), '%\n')
  cat('  En mujeres:', round(x$aprob$amuj, 2), '%\n')
  #===== Su código comienza aquí: =====#
  
  ptot <- NA
  
  pvar <- NA
  
  pmuj <- NA
  
  #====== Aquí finaliza su código =====#
  cat('La nota promedio fue de:', round(ptot, 2), '\n')
  cat('  En varones:', round(pvar, 2), '\n')
  cat('  En mujeres:', round(pmuj, 2), '\n')
  cnt <- x$conteo
  if (class(cnt) != 'numeric') stop('x$conteo no es numeric')
  names(cnt) <- c('1--3', '4--6', '7--9', '10--12')
  cat('Conteos por franja de nota:\n')
  print(cnt)
}


