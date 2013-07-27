################################################################################
################################################################################


###############################################################
# ATENCIÓN: FALTA TERMINAR DE IMPLEMENTAR LAS NUEVAS FUNCIONES:
# mkmsj.xxx
# objnames
# cut.script
###############################################################

## NÚMERO DE REPARTIDO!
nrep <- 2
rdir <- paste0('rep-', nrep)
rep.date <- format(Sys.time(), "%Y-%m-%d %H:%M")
url.desc <- "http://goo.gl/b4l9D"

esperados <- c("datos", "notas.csv", "INSTRUCCIONES.pdf", "calificaciones.R")
# Los archivos de los ejercicios deben estar en el orden 
# correcto (para el menú de 'evaluar'):
corregir <- c("aprobados.R", "aprobados2.R", "mejorcitos.R", "franjas.R", 
              "data.frame.R", "ordenacion.R", "lista.R", "print.listaCalif.R")
esperados <- c(esperados, corregir)
codigo <- lapply(corregir, readLines)
names(codigo) <- corregir
ejnum  <- c('1.a', '1.b', '1.c', '1.d', '2.a', '2.b', '2.c', '2.d')
notas <- data.frame(Parte = c(ejnum, 'Total (%)'),
                    Nota=numeric(length(corregir) + 1),
                    Script=c(corregir, '--'))
write.csv2(notas, file='notas.csv', row.names=FALSE)
extras <- '2.d'
oblg   <- sum(!(ejnum %in% extras))
guardar <- c('nrep', 'rep.date', 'esperados', 'corregir', 'extras', 'oblg', 'ejnum', 'guardar', 'reload',
             'notas', 'codigo', 'corAll')

### RELOAD

reload <- function() {
# Esta función sólo se puede usar trabajando desde el subdirectorio
# "Curso-R/ejercicios-de-programacion/rep-X/rep-X"

# Uso:
# (1)  modificar este archivo ('datos.R'), por ejemplo en uno de las funciones de corrección
#      (e.g.: cor1.a).
# (2)  load('datos')
# (3)  reload()
  rdir <- getwd()
  on.exit(setwd(rdir))
  setwd('..')
  arch <- readLines('datos.R')
  f <- grep('### REINICIAR', arch, useBytes = TRUE)[2]
  arch <- arch[1:(f - 1)]
  tmp <- tempfile()
  writeLines(arch, tmp)
  source(tmp)
  unlink(tmp)
  out <- file.copy('datos', rdir, overwrite = TRUE)
}

### FUNCIONES AUXILIARES:

source("../auxiliares.R")
guardar <- c(guardar, objetos)

### ARCHIVO AUXILIAR

cal <- cl()
gen <- gn(cal)
ctg <- ct(cal)
datos.calif <- data.frame(nota = cal,
													genero = gen,
													franja = ctg)
datos.calif <- datos.calif[order(cal),]
conteo <- table(ctg)
p.apr <- 100 * sum(cal >= 5) / length(cal)
v <- cal[gen == "V"]
m <- cal[gen == "M"]
p.apr.v <- 100 * sum(v >= 5) / length(v)
p.apr.m <- 100 * sum(m >= 5) / length(m)
analisis.calif <- list(tabla = datos.calif,
											 conteo = table(ctg),
											 aprob = list(atot = p.apr,
																		avar = p.apr.v,
																		amuj = p.apr.m))
save(cal, gen, ctg, p.apr, p.apr.v, p.apr.m, datos.calif, conteo, analisis.calif,
		 file = "ej2.RData")

esperados <- c(esperados, "ej2.RData")

guardar <- c(guardar, 'Print.listaCalif', 'cl', 'gn', 'ct')

### FUNCIONES DE CORRECCIÓN:

cor1.a <- function() {
  # Cargar 'datos'
  load('datos')

  # Cortar el archivo original y crear uno temporal
  arch <- cut.script('aprobados.R')
  #   arch <- readLines('aprobados.R')
  #   gr <- grep('#===', arch, useBytes = TRUE)
  #   arch <- arch[gr[1]:gr[2]]
  #   tmp <- tempfile()

  # Generación de datos nuevos aleatorios
  cal <- cl()
  gen <- gn(cal)

  # Evaluación de objetos: p.apr
  #   source(tmp, local = TRUE)
  #   unlink(tmp)
  eval(parse(text = arch))
  apr2   <- sum(cal >= 5)
  p.apr2 <- 100 * apr2 / length(cal)
	tol <- 1e-8 # Antes era 1e-15, pero era muy alto.

	if (p.apr < 1)
		warning("  El p.apr < 1, ¿tal vez no esté en porcentaje si no fracción?\n", call. = FALSE)
	if (abs(p.apr2 - p.apr) > tol)
		stop("El valor obtenido no coincide con el esperado", call. = FALSE)
  TRUE
}

cor1.b <- function() {
  # Cargar datos y script
  load('datos')

  # Cortar el archivo original y crear uno temporal
  arch <- readLines('aprobados2.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos nuevos aleatorios
  cal <- cl()
  gen <- gn(cal)

  # Evaluación de objetos: p.apr.v, p.apr.m
  source(tmp, local = TRUE)
  unlink(tmp)
  v2 <- cal[gen == 'V']
  m2 <- cal[gen == 'M']
  apr.v2 <- sum(v2 >= 5)
  apr.m2 <- sum(m2 >= 5)
  p.apr.v2 <- 100 * apr.v2 / length(v2)
  p.apr.m2 <- 100 * apr.m2 / length(m2)
	tol <- 1e-8

	if (p.apr.v < 1)
		warning("  El p.apr.v < 1, ¿tal vez no esté en porcentaje si no fracción?\n", call. = FALSE)
	if (p.apr.m < 1)
		warning("  El p.apr.m < 1, ¿tal vez no esté en porcentaje si no fracción?\n", call. = FALSE)

	if (abs(p.apr.v2 - p.apr.v) > tol)
		stop("El valor obtenido no coincide con el esperado", call. = FALSE)
	if (abs(p.apr.m2 - p.apr.m) > tol)
		stop("El valor obtenido no coincide con el esperado", call. = FALSE)
  TRUE
}

cor1.c <- function() {
  # Cargar datos y script
  load('datos')

  # Cortar el archivo original y crear uno temporal
  arch <- readLines('mejorcitos.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos
  cal <- cl()
  gen <- gn(cal)
	# No necesita tol!

  # Evaluación de objetos: i, mejores
  source(tmp, local=TRUE)
  unlink(tmp)
  n2   <- length(cal)
  ord2 <- sort(cal)
  i2   <- ceiling(n2 * 0.75)
  mejores2 <- ord2[i2:n2]

	if (i == i2 - 1)
		warning("  El i obtenido es un poco menor a lo esperado", call. = FALSE)

	if (round(i) - i != 0)
		stop("el i obtenido no parece ser un número entero", call. = FALSE)

	if (!any(grepl("ceiling", arch)))
		warning("  La función usada para obtener el i parece no ser la correcta", call. = FALSE)

	if (i != i2)
		stop("el valor de i obtenido no es el esperado", call. = FALSE)
	if (any(sort(mejores) != sort(mejores2)))
		stop("los valores del mejores obtenido no son los esperados", call. = FALSE)
  TRUE
}

cor1.d <- function() {
  # Cargar datos y script
  load('datos')

  # Cortar el archivo original y crear uno temporal
  arch <- readLines('franjas.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos
  cal <- cl()
  gen <- gn(cal)
  ctg2 <- ct(cal)
	tol <- 1e-8

  # Evaluación de objetos: ctg y conteo
  source(tmp, local=TRUE)
  unlink(tmp)
  conteo2 <- table(ctg2)

	if (length(ctg) > length(ctg2))
		warning("  El valor length(ctg) es demasiado grande", call. = FALSE)
	if (length(ctg) < length(ctg2))
		warning("  El valor length(ctg) es demasiado pequeño", call. = FALSE)

	if (!all(ctg == ctg2)) {
    warning("  Se ha generado un nuevo vector cal de forma aleatoria para la corrección", call. = FALSE)
		mensaje <- mkmsj.v("El vector ctg obtenido no coincide con el esperado",
                       ctg, ctg2, tol)
    return(mensaje)
  }
	if (!all(conteo == conteo2)) {
		mensaje <- mkmsj.v("los valores del vector conteo obtenido no coinciden con lo esperado",
                       conteo, conteo2, tol)
    if (is.logical(mensaje)) break
    return(mensaje)
  }

  objnames(names(conteo2), conteo, "conteo")

	TRUE
}

cor2.a <- function() {
  # Cargar datos y script
  load('datos')

  # Cortar el archivo original y crear uno temporal
  arch <- readLines('data.frame.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos
  cal <- cl()
  gen <- gn(cal)
  ctg <- ct(cal)
	tol <- 1e-8

  # Evaluación de objetos: datos.calif
  source(tmp, local=TRUE)
  unlink(tmp)
  datos.calif2 <- data.frame(nota = cal,
														 genero = gen,
													 	 franja = ctg)
  
  objnames(names(datos.calif2), datos.calif, "datos.calif")

  if (!all(datos.calif == datos.calif2)) {
    mensaje <- mkmsj.df("los valores de datos.calif no son los esperados",
                        datos.calif, datos.calif2, tol)
    return(mensaje)
  }

  TRUE
}

cor2.b <- function() {
  # Cargar datos y script
  load('datos')

  # Cortar el archivo original y crear uno temporal
  arch <- readLines('ordenacion.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos
  cal <- cl()
  gen <- gn(cal)
  ctg <- ct(cal)
  datos.calif <- data.frame(nota = cal, genero = gen, franja = ctg)
	tol <- 1e-8

  # Evaluación de objetos: datos.calif (ordenada)
  i2 <- order(datos.calif$nota)
  datos.calif2 <- datos.calif[i2,]
  source(tmp, local=TRUE)
  unlink(tmp)

	if (!all(datos.calif$nota - datos.calif2$nota < tol))
		stop("los valores de datos.calif$nota no coinciden con los esperados", call. = FALSE)
	if (any(datos.calif$genero != datos.calif2$genero))
		stop("los valores de datos.calif$genero no coinciden con los esperados", call. = FALSE)
	if (any(datos.calif$franja != datos.calif2$franja))
		stop("los valores de datos.calif$franja no coinciden con los esperados", call. = FALSE)
  
	if (any(grepl("arrange", arch)))
		stop("la palabra 'arrange' figura en su script,\n  ¿está haciendo trampa con el paquete plyr?", call. = FALSE)
	if (all(rownames(datos.calif) == 1:nrow(datos.calif)))
		warning("los nombres de las filas de datos.calif están ordenados,\n  ¿está haciendo trampa con el paquete plyr?", call. = FALSE)

	TRUE
}

## Ej. 3

cor2.c <- function() {
  # Cargar datos y script
  load('datos')

  # Cortar el archivo original y crear uno temporal
  arch <- readLines('lista.R')
  arch2 <- gsub(' ', '', arch)
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos
  cal <- cl()
  gen <- gn(cal)
  ctg <- ct(cal)
	tol <- 1e-8

  # Evaluación de objetos: analisis.calif
  conteo <- table(ctg)
  names(conteo) <- c("A", "B", "C", "D")
  datos.calif <- data.frame(nota = cal, genero = gen, franja = ctg)
	datos.calif <- datos.calif[order(cal),]
  v <- cal[gen == 'V']
  m <- cal[gen == 'M']
  apr.v <- sum(v >= 5)
  apr.m <- sum(m >= 5)
  p.apr <- 100 * sum(cal >= 5) / length(cal)
  p.apr.v <- 100 * apr.v / length(v)
  p.apr.m <- 100 * apr.m / length(m)
  source(tmp, local=TRUE)
  unlink(tmp)
  analisis.calif2 <- list(tabla = datos.calif,
													conteo = conteo,
                          aprob = list(atot = p.apr,
																			 avar = p.apr.v,
                                       amuj = p.apr.m))
  if (identical(analisis.calif, analisis.calif2))
    return(TRUE)

	# Nombres:
  objnames(names(analisis.calif2), analisis.calif, "analisis.calif")

  objnames(names(analisis.calif2$tabla), analisis.calif$tabla, "analisis.calif$tabla")

  objnames(names(analisis.calif2$conteo), analisis.calif$conteo, "analisis.calif$conteo")

  objnames(names(analisis.calif2$aprob), analisis.calif$aprob, "analisis.calif$aprob")

	# Valores:
	if (any(analisis.calif$tabla$nota != sort(analisis.calif$tabla$nota)))
		warning("  ¿tal vez la data.frame no está ordenada por la variable nota? (ver ej. 2.b)", call. = FALSE)

  if (!all(analisis.calif$tabla == datos.calif)) {
    mensaje <- mkmsj.df("Hay valores de analisis.calif$tabla no esperados", 
                        analisis.calif$tabla, datos.calif, tol)
    if (is.logical(mensaje)) break
    return(mensaje)
  }

	if (!all(conteo - analisis.calif$conteo < tol)) {
    mensaje <- mkmsj.v("Los valores del vector analisis.calif$conteo no son los esperados",
                        analisis.calif$tabla, datos.calif, tol)
    return(mensaje)
  }

	if (with(analisis.calif$aprob, any(atot <= 1 | avar <= 1 | amuj <= 1)))
		warning("  Al menos uno de los valores de analisis.calif$aprob es <= 1,\n  ¿tal vez no esté en porcentaje si no fracción?\n", call. = FALSE)

	if (!all(analisis.calif$aprob$atot - analisis.calif2$aprob$atot < tol))
		stop("el valor de analisis.calif$aprob$atot no es el esperado", call. = FALSE)
	if (!all(analisis.calif$aprob$avar - analisis.calif2$aprob$avar < tol))
		stop("el valor de analisis.calif$aprob$avar no es el esperado", call. = FALSE)
	if (!all(analisis.calif$aprob$amuj - analisis.calif2$aprob$amuj < tol))
		stop("el valor de analisis.calif$aprob$amuj no es el esperado", call. = FALSE)

  TRUE
}

cor2.d <- function() {
  # Cargar datos y script
  load('datos')
  source('print.listaCalif.R')

  # Generación de datos
  cal <- cl()
  gen <- gn(cal)
  ctg <- ct(cal)
  conteo <- as.numeric(table(ctg))
  names(conteo) <- c("A", "B", "C", "D")
  datos.calif <- data.frame(nota = cal, genero = gen, franja = ctg)
  v <- cal[gen == 'V']
  m <- cal[gen == 'M']
  apr.v <- sum(v >= 5)
  apr.m <- sum(m >= 5)
  p.apr.v <- 100 * apr.v / length(v)
  p.apr.m <- 100 * apr.m / length(m)
  a <- list(tabla = datos.calif,
						conteo = conteo,
						aprob = list(atot = 100 * sum(cal >= 5) / length(cal),
												 avar = p.apr.v,
												 amuj = p.apr.m))
  class(a) <- "listaCalif"

  # Evaluación de objetos: salida de print.listaCalif
  c1 <- capture.output(print.listaCalif(a))
  c2 <- capture.output(Print.listaCalif(a))

	if (!all(c1 == c2)) {
		mensajes <- c("\n  Ej. 2.d: la salida esperada es:\n",
									paste("   ", c2),
									"\n  pero la salida producida es:\n",
									paste("   ", c1),
									"  (los valores fueron generados aleatoriamente)")
		mensajes <- paste(mensajes, "\n")
		warning(mensajes, call. = FALSE)
		stop("la salida en consola difiere de lo esperado", call. = FALSE)
	}
	TRUE
}

corAll <- list(cor1.a, cor1.b, cor1.c, cor1.d, cor2.a, cor2.b, cor2.c, cor2.d)

################################################################################

### GUARDAR TODO
guardar <- unique(guardar)
save(list = guardar, file = 'datos')

### REINICIAR EL DIRECTORIO Y ZIP FILE

if (!file.exists(rdir))
  dir.create(rdir)
borrar <- dir(rdir)
borrar <- file.path(rdir, borrar)
unlink(borrar, recursive = TRUE)

file.copy(esperados, rdir, recursive = TRUE)
file.copy("../evaluar.R", rdir, recursive = TRUE)
# zipfile <- paste(rdir, 'zip', sep = '.')
# unlink(zipfile)
# zip(zipfile, paste(rdir, '/', sep=''))
