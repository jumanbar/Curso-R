################################################################################
################################################################################

## NÚMERO DE REPARTIDO!
nrep <- 3
rdir <- paste('rep', nrep, sep='-')

esperados <- c("evaluar.R", "datos", "notas.csv", "INSTRUCCIONES.pdf", "aux",
               "est.rda",
               "importar.R", "parche.R", "filtrado.R")
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
             'notas', 'codigo', 'corAll')

### FUNCIONES Y DATOS AUXILIARES:

load('usa.rda')
guardar <- c(guardar, 'usa.check')

.usainc <- function() {
  load('aux')
  n <- is.na(usa.inc$Analf)
  usa.inc$Analf[n] <- outAnalf + sample(c(-0.1, 0.1), sum(n), replace = TRUE)
  write.csv2(usa.inc, file = 'usa-extra.csv')
  cat("¡Se han cambiado algunos valores del archivo 'usa-extra.csv'!\n")
}
guardar <- c(guardar, '.usainc')


### FUNCIONES DE CORRECCIÓN:

## Ej. 1

cor1.a <- function() {
  # Cargar 'datos'
  load('datos')

  # Cortar el archivo original y crear uno temporal
  arch <- readLines('importar.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)
  
  # Evaluación de objetos: usa
  source(tmp, local = TRUE)
  f1 <- identical(usa, usa.check)
  unlink(tmp)  
  f1
}

cor1.b <- function() {
  # Cargar datos y script
  load('datos')
  
  # Cortar el archivo original y crear uno temporal
  arch <- readLines('parche.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Evaluación de objetos: usa2
  .usainc()
  usaExtra <- read.csv2('usa-extra.csv', row.names = 1)
  nas <- is.na(usa.check$Analf)
  estados <- rownames(usa.check)[nas]
  parche <- usaExtra$Analf[rownames(usaExtra) %in% estados]
  usaX <- usa.check
  usaX$Analf[is.na(usa.check$Analf)] <- parche
  source(tmp, local = TRUE)
  f1 <- identical(usa2, usaX)
  unlink(tmp)
  f1
}

cor1.c <- function() {
  # Cargar datos y script
  load('datos')
  
  # Cortar el archivo original y crear uno temporal
  arch <- readLines('filtrado.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos

  # Evaluación de objetos: usa2
  source(tmp, local=TRUE)
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
