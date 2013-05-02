# Rep. II - ej. 2.d

# Instrucciones:
# El objeto analisis.calif ya debe encontrarse en el área de trabajo para completar
# este script. En caso contrario, corra "load('ej2.RData')" para cargar este objeto 
# ya preparado.

# Asegurese de correr primero esta línea (para lo cual debe existir analisis.calif):
class(analisis.calif) <- "listaCalif"

# Objetivos:
# Hacer una salida que incluya los cálculos correctos de los objetos:
# ptot: promedio total de notas.
# pvar: promedio de notas de varones.
# pmuj: promedio de notas de mujeres.

# Recuerde que en la corrección los objetos cal y gen son creados nuevamente con 
# generadores de números aleatorios.

# Recuerde además evitar usar el nombre analisis.calif adentro de la función; use
# en cambio x como reemplazo. De manera similar, utilice sólo objetos que estén
# definidos dentro de la función o dentro de los argumentos (i.e.: dentro de x).

# Sugerencias: 

# - Utilice la función str para ver la estructura de analisis.calif.
# - Defina cualquier objeto que le parezca conveniente dentro de la función.

print.listaCalif <- function(x) {
	# x es un objeto de la clase "listaCalif"
  cat('Porcentaje total de aprobaciones:', round(x$aprob$atot, 2), '%\n')
  cat('  En varones:', round(x$aprob$avar, 2), '%\n')
  cat('  En mujeres:', round(x$aprob$amuj, 2), '%\n')
	# Note cómo se utilizan solamente objetos contenidos dentro dee x para
	# calcular los porcentajes de aprobación.
  #===== Su código comienza aquí: =====#
  
  ptot <- NA
  
  pvar <- NA
  
  pmuj <- NA
  
  #====== Aquí finaliza su código =====#
  cat('La nota promedio fue de:', round(ptot, 2), '\n')
  cat('  En varones:', round(pvar, 2), '\n')
  cat('  En mujeres:', round(pmuj, 2), '\n')
  cnt <- x$conteo
	
  if (all(is.na(as.numeric(conteo))))
		stop('x$conteo no tiene números si no cadenas de caracteres')
	
  names(cnt) <- c('1--3', '4--6', '7--9', '10--12')
  cat('Conteos por franja de nota:\n')
  print(cnt)
}


