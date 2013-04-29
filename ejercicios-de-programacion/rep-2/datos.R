################################################################################
################################################################################

## NÚMERO DE REPARTIDO!
nrep <- 2
rdir <- paste('rep', nrep, sep='-')

esperados <- c("datos", "notas.csv", "INSTRUCCIONES.pdf", "calificaciones.R",
               "aprobados.R", "aprobados2.R", "mejorcitos.R", "franjas.R", "data.frame.R", "ordenacion.R",
               "lista.R", "print.listaCalif.R")
corregir <- esperados[- (1:4)]
codigo <- lapply(corregir, readLines)
names(codigo) <- corregir
ejnum  <- c('1.a', '1.b', '1.c', '1.d', '2.a', '2.b', '2.c', '2.d')

notas <- data.frame(Parte = c(ejnum, 'Total (%)'),
                    Nota=numeric(length(corregir) + 1),
                    Script=c(corregir, '--'))
write.csv2(notas, file='notas.csv', row.names=FALSE)
extras <- '2.d'
oblg   <- length(ejnum) - length(extras)
guardar <- c('esperados', 'corregir', 'extras', 'oblg', 'ejnum', 'guardar', 'reload',
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

cl <- function() {
  cal <- rpois(260 + sample(20, 1), 6)
  cal[cal > 12] <- 12
  cal[cal == 0] <- 1
  cal
}

gn <- function(cal)
  sample(c('V', 'M'), length(cal), replace=TRUE)
  
ct <- function(cal) {
  n <- length(cal)
  out <- character(n)
  out[cal <= 3] <- 'A'
  out[3 < cal & cal <= 6] <- 'B'
  out[6 < cal & cal <= 9] <- 'C'
  out[9 < cal] <- 'D'
  out
}

Print.listaCalif <- function(x) {
  cat('Porcentaje total de aprobaciones:', round(x$aprob$atot, 2), '%\n')
  cat('  En varones:', round(x$aprob$avar, 2), '%\n')
  cat('  En mujeres:', round(x$aprob$amuj, 2), '%\n')
  #===== Su código comienza aquí: =====#
  ptot <- mean(x$tabla$nota)
  pvar <- mean(x$tabla$nota[x$tabla$genero == 'V'])
  pmuj <- mean(x$tabla$nota[x$tabla$genero == 'M'])
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
  arch <- readLines('aprobados.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos nuevos aleatorios
  cal <- cl()
  gen <- gn(cal)
  
  # Evaluación de objetos: p.apr
  source(tmp, local = TRUE)
  unlink(tmp)  
  apr2   <- sum(cal >= 5)
  p.apr2 <- 100 * apr2 / length(cal)
	tol <- 1e-15

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
	tol <- 1e-15

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
	tol <- 1e-15

  # Evaluación de objetos: ctg y conteo
  source(tmp, local=TRUE)
  unlink(tmp)
  conteo2 <- table(ctg2)
  
	if (length(ctg) > length(ctg2))
		warning(" El valor length(ctg) es demasiado grande", call. = FALSE)
	if (length(ctg) < length(ctg2))
		warning(" El valor length(ctg) es demasiado pequeño", call. = FALSE)

	if (!all(ctg == ctg2))
		stop("el vector ctg obtenido no coincide con lo esperado", call. = FALSE)
	if (!all(conteo - conteo2 < tol))
		stop("los valores del vector conteo obtenido no coinciden con lo esperado", call. = FALSE)
	if (!all(names(conteo) == names(conteo2))) {
		warning(" Los nombres esperados para conteo son 'A', 'B', 'C' y 'D'", call. = FALSE)
		stop("los nombres del vector conteo obtenido no coinciden con lo esperado", call. = FALSE)
	}
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
	tol <- 1e-15

  # Evaluación de objetos: datos.calif
  source(tmp, local=TRUE)
  unlink(tmp)
  datos.calif2 <- data.frame(nota = cal, 
														 genero = gen, 
													 	 franja = ctg)

	if (any(names(datos.calif) != names(datos.calif2))) {
		warning(" Los nombres esperados son 'nota', 'genero' y 'franja'", call. = FALSE)
		stop("los nombres de las variables en datos.calif no parecen estar correctos", call. = FALSE)
	}
	if (!all(cal - datos.calif$nota < tol))
		stop("los valores de datos.calif$nota no coinciden con los de cal", call. = FALSE)
	if (any(gen != datos.calif$genero))
		stop("los valores de datos.calif$genero no coinciden con los de gen", call. = FALSE)
	if (any(ctg != datos.calif$franja))
		stop("los valores de datos.calif$franja no coinciden con los de ctg", call. = FALSE)
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
	tol <- 1e-15

  # Evaluación de objetos: datos.calif (ordenada)
  i2 <- order(datos.calif$nota)
  datos.calif2 <- datos.calif[i2,]
  source(tmp, local=TRUE)
  unlink(tmp)

	if (any(grepl("arrange", arch)))
		stop("la palabra 'arrange' figura en su script,\n  ¿está haciendo trampa con el paquete plyr?", call. = FALSE)
	if (all(rownames(datos.calif) == 1:nrow(datos.calif)))
		warning("los nombres de las filas de datos.calif están ordenados,\n  ¿está haciendo trampa con el paquete plyr?", call. = FALSE)

	if (!all(datos.calif$nota - datos.calif2$nota < tol))
		stop("los valores de datos.calif$nota no coinciden con los esperados", call. = FALSE)
	if (any(datos.calif$genero != datos.calif2$genero))
		stop("los valores de datos.calif$genero no coinciden con los esperados", call. = FALSE)
	if (any(datos.calif$franja != datos.calif2$franja))
		stop("los valores de datos.calif$franja no coinciden con los esperados", call. = FALSE)
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
	tol <- 1e-15
  
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
                          aprob = list(atot = 100 * sum(cal >= 5) / length(cal), 
																			 avar = p.apr.v,
                                       amuj = p.apr.m))

	# Nombres:
	if (!all(names(analisis.calif) == names(analisis.calif2)))
		stop("los nombres de analisis.calif no son los esperados", call. = FALSE)
	if (!all(names(analisis.calif$tabla) == names(analisis.calif2$tabla))) {
		warning(" Los nombres esperados para la tabla son 'nota', 'genero' y 'franja'", call. = FALSE)
		stop("los nombres de la data.frame analisis.calif$tabla no son los esperados", call. = FALSE)
	}
	if (!all(names(analisis.calif$conteo) == names(analisis.calif2$conteo))) {
		warning(" Los nombres esperados para conteo son 'A', 'B', 'C' y 'D'", call. = FALSE)
		stop("los nombres del vector analisis.calif$conteo no son los esperados", call. = FALSE)
	}
	if (!all(names(analisis.calif$aprob) == names(analisis.calif2$aprob)))
		stop("los nombres de la sublista analisis.calif$aprob no son los esperados", call. = FALSE)

	# Clases:
	if (!is.data.frame(analisis.calif$tabla))
		stop("la clase del objeto analisis.calif$tabla no es data.frame", call. = FALSE)
	if (!is.list(analisis.calif$aprob))
		stop("la clase del objeto analisis.calif$aprob no es list", call. = FALSE)

	# Valores:
	if (any(analisis.calif$tabla$nota != sort(analisis.calif$tabla$nota)))
		warning("  ¿tal vez la data.frame no está ordenada por la variable nota? (ver ej. 2.b)", call. = FALSE)

	if (any(analisis.calif$tabla$nota - analisis.calif2$tabla$nota > tol))
		stop("los valores de analisis.calif$tabla$nota no coinciden con los esperados", call. = FALSE)
	if (any(analisis.calif$tabla$genero != analisis.calif2$tabla$genero))
		stop("los valores de analisis.calif$tabla$genero no coinciden con los esperados", call. = FALSE)
	if (any(analisis.calif$tabla$franja != analisis.calif2$tabla$franja))
		stop("los valores de analisis.calif$tabla$franja no coinciden con los esperados", call. = FALSE)
	if (!all(conteo - analisis.calif$conteo < tol))
		stop("los valores del vector analisis.calif$conteo no son los esperados", call. = FALSE)

	if (with(analisis.calif$aprob, any(atot <= 1 | avar <= 1 | amuj <= 1)))
		warning("  Al menos uno de los valores de analisis.calif$aprob es <= 1,
    ¿tal vez no esté en porcentaje si no fracción?\n", call. = FALSE)

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
		mensajes <- c("\n  Ej. 2.d: la salida esparada es:\n", 
									paste("   ", c2), 
									"\n  pero la salida producida es:\n", 
									paste("   ", c1),
									"(los valores fueron generados aleatoriamente)")
		mensajes <- paste(mensajes, "\n")
		warning(mensajes, call. = FALSE)
		stop("la salida en consola difiere de lo esperado", call. = FALSE)
	}
	TRUE
}

corAll <- list(cor1.a, cor1.b, cor1.c, cor1.d, cor2.a, cor2.b, cor2.c, cor2.d)

################################################################################

### GUARDAR TODO
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
