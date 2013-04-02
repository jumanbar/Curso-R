################################################################################
################################################################################

## NÚMERO DE REPARTIDO!
nrep <- 1
rdir <- paste('rep', nrep, sep='-')

esperados <- c("evaluar.R", "datos", "notas.csv", "INSTRUCCIONES.pdf",
               # Los archivos de los ejercicios deben estar en el orden 
               # correcto (para el menú de 'evaluar'):
							 "hipot", "areaMax.R", "dist.R", "varianza.R", "zenon.R", "geom.R",
		           "shannon-1.R", "shannon-2.R")
corregir <- esperados[- (1:4)]
codigo <- lapply(corregir, readLines)
names(codigo) <- corregir
ejnum  <- c('1.a', '1.b', '1.c', '2.a', '2.b', '2.c', '3.a', '3.b')

notas <- data.frame(Parte = c(ejnum, 'Total (%)'),
                     Nota=numeric(length(corregir) + 1),
                     Script=c(corregir, '--'))
write.csv2(notas, file='notas.csv', row.names=FALSE)
extras <- c('2.c', '3.b')
oblg   <- length(ejnum) - length(extras)
oblg   <- sum(!(ejnum %in% extras))
guardar <- c('esperados', 'corregir', 'extras', 'oblg', 'ejnum', 'guardar', 'reload'
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

### FUNCIONES Y DATOS AUXILIARES:

Hipot <- function(a, b)
  sqrt(a ** 2 + b ** 2)

Area <- function(a, b)
  a * b / 2

Co <- function(a, h)
  sqrt(h ** 2 - a ** 2)

Zenon <- function(n)
  sum(1 / 2 ** (1:n))

Geom <- function(n, z)
  sum(1 / z ** (1:n))

Shannon <- function(x) {
  n <- table(x)
  p <- n / sum(n)
  - p %*% log(p, 2)
}

guardar <- c(guardar, 'Hipot', 'Area', 'Co', 'Zenon', 'Geom', 'Shannon')

### FUNCIONES DE CORRECCIÓN:

## Ej. 1

cor1.a <- function() {
  load('datos')
  source('hipot.R')
  rd <- runif(2, 4, 10)
  f1 <- area(rd[1], rd[2]) == Area(rd[1], rd[2])
  f2 <- co(rd[3], 12) == Co(rd[3], 12)
  f1 * f2
  if (!is.list(out1))
    stop("la salida no es una lista", call. = FALSE)
  if (!all(names(out1) == names(out2)))
    stop("los nombres del objeto de salida no coinciden con los esperados", call. = FALSE)
  if (abs(out1$hipotenusa - out2$hipotenusa) > tol)
    stop("el valor de la hipotenusa no es correcto", call. = FALSE)
  if (abs(out1$area - out2$area) > tol)
    stop("el valor del area no es correcto", call. = FALSE)
  if (abs(out1$angulo.adyacente - out2$angulo.adyacente) > tol)
    stop("el valor del angulo.adyacente no es correcto", call. = FALSE)
  if (abs(out1$angulo.opuesto - out2$angulo.opuesto) > tol)
    stop("el valor del angulo.opuesto no es correcto", call. = FALSE)
  TRUE
}

cor1.b <- function() {
  # Cargar datos y script
  load('datos')
  
  # Cortar el archivo original y crear uno temporal
  arch <- readLines('areaMax.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos nuevos aleatorios
  hip <- runif(1, 8, 12)
  cat.ad <- runif(100, 0.001, hip - 0.001)
  cat.op <- Co(cat.ad, hip)
  a <- Area(cat.ad, cat.op)

  # Evaluación de objetos: i, sol, amax
  source(tmp, local=TRUE)
  who <- which.max(a)
  f1 <- i == who
  f2 <- sol == cat.ad[who]
  f3 <- amax == a[who]
  unlink(tmp)
  f1 * f2 * f3
}

cor1.c <- function() {
  # Cargar datos y script
  load('datos')
  
  # Cortar el archivo original y crear uno temporal
  arch <- readLines('dist.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos
  coorx <- runif(20, 5, 10)
  coory <- runif(20, 5, 10)

  # Evaluación de objetos: dst, i, j, A, B
  source(tmp, local=TRUE)
  ca2 <- coorx - 0.5
  co2 <- coory - 0.5
  dst2 <- Hipot(ca2, co2)
  i2 <- which.min(dst2)
  j2 <- which.max(dst2)
  A2 <- c(coorx[i2], coory[i2])
  B2 <- c(coorx[j2], coory[j2])
  f1 <- all(dst == dst2)
  f2 <- i == i2
  f3 <- j == j2
  f4 <- all(A == A2)
  f5 <- all(B == B2)
  unlink(tmp)
  f1 * f2 * f3 * f4 * f5
}

## Ej. 2

cor2.a <- function() {
  # Cargar datos y script
  load('datos')
  source('varianza.R')
  
  # Cortar el archivo original y crear uno temporal
  arch <- readLines('varianza.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos
  x <- runif(80, 40, 90)

  # Evaluación de objetos: x_mean, s, out
  source(tmp, local=TRUE)
  x_mean2 <- sum(x) / length(x)
  s2   <- (x - x_mean2) ** 2
  out2 <- sum(s2) / (length(x) - 1)
  f1 <- x_mean == x_mean2
  f2 <- all(s == s2)
  f3 <- out == out2
  unlink(tmp)
  f1 * f2 * f3
}

cor2.b <- function() {
  # Cargar datos y script
  load('datos')
  source('zenon.R')
  
  # Cortar el archivo original y crear uno temporal
  arch <- readLines('zenon.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Evaluación de objetos: e, s, out
  source(tmp, local=TRUE)
  e2 <- 1:n
  s2 <- 1 / (2 ** e)
  out2 <- sum(s2)
  f1 <- all(e == e2)
  f2 <- all(s == s2)
  f3 <- all(out == out2)
  f4 <- n == 20
  unlink(tmp)
  f1 * f2 * f3 * f4
}

cor2.c <- function() {
  # Cargar datos y script
  load('datos')
  source('geom.R')
  
  # Cortar el archivo original y crear uno temporal
  arch <- readLines('geom.R')
  arch2 <- gsub(' ', '', arch)
  gr1 <- grep('z<-', arch2, useBytes = TRUE)[1] + 1
  gr2 <- grep('#===', arch, useBytes = TRUE)[2]
  arch <- arch[gr1:gr2]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos
  n  <- sample(20:40, 1)
  z  <- rnorm(1, 1, 1)
  
  # Evaluación de objetos: e, s, out
  source(tmp, local=TRUE)
  e2 <- 0:n
  s2 <- 1 / (z ** e2)
  out2 <- sum(s2)
  f1 <- all(e == e2)
  f2 <- all(s == s2)
  f3 <- all(out == out2)
  unlink(tmp)
  f1 * f2 * f3
}

## Ej. 3

cor3.a <- function() {
  # Cargar datos y script
  load('datos')
  source('shannon-1.R')
  
  # Cortar el archivo original y crear uno temporal
  arch <- readLines('shannon-1.R')
  arch2 <- gsub(' ', '', arch)
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos
  coleccion <- sample(20, 50, replace=TRUE)
  
  # Evaluación de objetos: n, N, p, H y el operador %*%
  source(tmp, local=TRUE)
  n2 <- table(coleccion)
  N2 <- sum(n2)
  p2 <- n2 / N2
  dim(p) <- NULL
  H2 <- - p2 %*% log2(p2)
  f1 <- all(n == n2)
  f2 <- all(N == N2)
  f3 <- all(p == p2)
  f4 <- H[1] == H2[1]
  gr2 <- grep('H<-', arch2)[1]
  f5 <- grepl("p%*%log(p,2)", arch2[gr2], fixed=TRUE)
  f6 <- grepl("p%*%log2(p)", arch2[gr2], fixed=TRUE)
  f7 <- f5 || f6
  unlink(tmp)
  f1 * f2 * f3 * f4 * f7
}

cor3.b <- function() {
  # Cargar datos y script
  load('datos')
  source('shannon-2.R')

  # Generación de datos
  coleccion <- sample(20, 50, replace=TRUE)
  
  # Evaluación de objetos: n, N, p, H y el operador %*%
  (shannon(coleccion) == Shannon(coleccion)) * 1
}

corAll <- list(cor1.a, cor1.b, cor1.c, cor2.a, cor2.b, cor2.c, cor3.a, cor3.b)

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
zipfile <- paste(rdir, 'zip', sep = '.')
unlink(zipfile)
zip(zipfile, paste(rdir, '/', sep=''))

