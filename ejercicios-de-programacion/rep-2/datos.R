################################################################################
################################################################################

## NÚMERO DE REPARTIDO!
nrep <- 2
rdir <- paste('rep', nrep, sep='-')

esperados <- c("evaluar.R", "datos", "notas.csv", "INSTRUCCIONES.pdf", "calificaciones.R", "ej2.rda",
               "aprobados.R", "aprobados2.R", "mejorcitos.R", "franjas.R", "data.frame.R", "ordenacion.R",
               "lista.R", "print.listaCalif.R")
corregir <- esperados[- (1:6)]
codigo <- lapply(corregir, readLines)
names(codigo) <- corregir
ejnum  <- c('1.a', '1.b', '1.c', '1.d', '2.a', '2.b', '2.c', '2.d')

notas <- data.frame(Parte = c(ejnum, 'Total (%)'),
                    Nota=numeric(length(corregir) + 1),
                    Script=c(corregir, '--'))
write.csv2(notas, file='notas.csv', row.names=FALSE)
extras <- '2.d'
oblg   <- length(ejnum) - length(extras)
guardar <- c('esperados', 'corregir', 'extras', 'oblg', 'ejnum', 'guardar',
             'notas', 'codigo', 'Print.listaCalif', 'cl', 'gn', 'ct',
             'corAll')

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
  if (class(cnt) != 'numeric') stop('x$conteo no es numeric')
  names(cnt) <- c('1--3', '4--6', '7--9', '10--12')
  cat('Conteos por franja de nota:\n')
  print(cnt)
}

### FUNCIONES DE CORRECCIÓN:

## Ej. 1

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
  v2 <- cal[gen == 'V']
  m2 <- cal[gen == 'M']
  apr.v2 <- sum(v2 >= 5)
  apr.m2 <- sum(m2 >= 5)
  p.apr.v2 <- 100 * apr.v2 / length(v2)
  p.apr.m2 <- 100 * apr.m2 / length(m2)
  f1 <- all.equal(p.apr.v, p.apr.v2)
  f2 <- all.equal(p.apr.m, p.apr.m2)
  unlink(tmp)
  f1 * f2
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

  # Evaluación de objetos: i, mejores
  source(tmp, local=TRUE)
  n2   <- length(cal)
  ord2 <- sort(cal)
  i2   <- ceiling(n2 * 0.75)
  mejores2 <- ord[i2:n2]
  f1 <- all.equal(i, i2)
  f2 <- all.equal(mejores, mejores2)
  unlink(tmp)
  f1 * f2
}

## Ej. 2

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

  # Evaluación de objetos: ctg y conteo
  source(tmp, local=TRUE)
  conteo2 <- as.numeric(table(ctg2))
  names(conteo2) <- c("A", "B", "C", "D")
  f1 <- all.equal(ctg, ctg2)
  f2 <- all.equal(conteo, conteo2)
  unlink(tmp)
  f1 * f2
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

  # Evaluación de objetos: datosCalif
  source(tmp, local=TRUE)
  datosCalif2 <- data.frame(nota = cal, genero = gen, franja = ctg)
  f1 <- all.equal(datosCalif, datosCalif2)
  unlink(tmp)
  f1 * 1
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

  # Evaluación de objetos: datosCalif (ordenada)
  datosCalif <- data.frame(nota = cal, genero = gen, franja = ctg)
  i2 <- order(datosCalif$nota)
  datosCalif2 <- datosCalif[i2,]
  source(tmp, local=TRUE)
#   f1 <- all.equal(datosCalif, datosCalif2)
  f1 <- all(datosCalif == datosCalif2)
  unlink(tmp)
  f1
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
  
  # Evaluación de objetos: analisisCalif
  conteo <- as.numeric(table(ctg))
  names(conteo) <- c("A", "B", "C", "D")
  datosCalif <- data.frame(nota = cal, genero = gen, franja = ctg)
  v <- cal[gen == 'V']
  m <- cal[gen == 'M']
  apr.v <- sum(v >= 5)
  apr.m <- sum(m >= 5)
  p.apr <- 100 * sum(cal >= 5) / length(cal)
  p.apr.v <- 100 * apr.v / length(v)
  p.apr.m <- 100 * apr.m / length(m)
  source(tmp, local=TRUE)
  analisisCalif2 <- list(tabla = datosCalif, conteo = conteo,
                         aprob = list(atot = 100 * sum(cal >= 5) / length(cal), avar = p.apr.v,
                                      amuj = p.apr.m))
  f1 <- all.equal(analisisCalif, analisisCalif2)
  unlink(tmp)
  f1
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
  datosCalif <- data.frame(nota = cal, genero = gen, franja = ctg)
  v <- cal[gen == 'V']
  m <- cal[gen == 'M']
  apr.v <- sum(v >= 5)
  apr.m <- sum(m >= 5)
  p.apr.v <- 100 * apr.v / length(v)
  p.apr.m <- 100 * apr.m / length(m)
  a <- list(tabla = datosCalif, conteo = conteo, aprob = list(atot = 100 * sum(cal >= 5) / length(cal),
                                                              avar = p.apr.v, amuj = p.apr.m))
  class(a) <- "listaCalif"
  
  # Evaluación de objetos: salida de print.listaCalif
  c1 <- capture.output(print.listaCalif(a))
  c2 <- capture.output(Print.listaCalif(a))
  f1 <- all.equal(c1, c2)
  f1 * 1
}

corAll <- list(cor1.a, cor1.b, cor1.c, cor1.d, cor2.a, cor2.b, cor2.c, cor2.d)

################################################################################
save(list=guardar, file='datos')
if (!any(dir() == rdir))
  dir.create(rdir)
file.copy(esperados, rdir, recursive=TRUE)
zip(paste(rdir, 'zip', sep='.'), paste(rdir, '/', sep=''))
