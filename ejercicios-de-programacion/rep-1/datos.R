################################################################################
################################################################################

## NÚMERO DE REPARTIDO!
nrep <- 1
rdir <- paste('rep', nrep, sep='-')

esperados <- c("datos", "notas.csv", "INSTRUCCIONES.pdf",
	       "ejTriangs.R", "plotTriang.R",
               # Los archivos de los ejercicios deben estar en el orden 
               # correcto (para el menú de 'evaluar'):
	       "hipot.R", "areaMax.R", "dist.R", "varianza.R", "zenon.R", "geom.R",
	       "shannon-1.R", "shannon-2.R")
corregir <- esperados[- (1:5)]
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
  # Cargar datos y script
  load('datos')
  # Cortar el archivo original y crear uno temporal
  source('hipot.R')
  rd <- runif (3, 4, 10)
  tol <- 1e-20

  if (abs(area(rd[1], rd[2]) - Area(rd[1], rd[2])) > tol)
    stop("la salida de la función area no la esperada", call. = FALSE)
  if (abs(co(rd[3], 12) - Co(rd[3], 12)) > tol)
    stop("la salida de la función co no la esperada", call. = FALSE)

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
	unlink(tmp)

	if (i == 72)
		warning("  El i == 72, ¿tal vez su solución no sea genérica?", call. = FALSE)

	if (i != who)
		stop("el valor de i obtenido no es el esperado", call. = FALSE)
	if (sol != cat.ad[who])
		stop("el valor de sol obtenido no es el esperado", call. = FALSE)
	if (amax != a[who])
		stop("el valor de amax obtenido no es el esperado", call. = FALSE)

	TRUE
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
  coorx <- runif (20, 5, 10)
  coory <- runif (20, 5, 10)

  # Evaluación de objetos: dst, i, j, A, B
  source(tmp, local=TRUE)
  unlink(tmp)
  ca2 <- coorx - 0.5
  co2 <- coory - 0.5
  dst2 <- Hipot(ca2, co2)
  i2 <- which.min(dst2)
  j2 <- which.max(dst2)
  A2 <- c(coorx[i2], coory[i2])
  B2 <- c(coorx[j2], coory[j2])
	tol <- 1e-20

	if (any(abs(dst - dst2) > tol))
		stop("los valores del dst obtenido no son los correctos", call. = FALSE)
	if (i != i2)
		stop("el valor de i obtenido no es el correcto", call. = FALSE)
	if (j != j2)
		stop("el valor de j obtenido no es el correcto", call. = FALSE)
	if (any(abs(A - A2) > tol))
		stop("los valores del A obtenido no son los correctos", call. = FALSE)
	if (any(abs(B - B2) > tol))
		stop("los valores de B obtenido no son los correctos", call. = FALSE)

	TRUE
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
  x <- runif (80, 40, 90)

  # Evaluación de objetos: x_mean, s, out
  source(tmp, local=TRUE)
  unlink(tmp)
  x_mean2 <- sum(x) / length(x)
  s2   <- (x - x_mean2) ** 2
  out2 <- sum(s2) / (length(x) - 1)
	tol <- 1e-20
	
  if (abs(x_mean - x_mean2) > tol)
    stop("el valor de x_mean obtenido no es el correcto", call. = FALSE)
	if (any(abs(s - s2) > tol))
		stop("los valores del s obtenido no son los correctos", call. = FALSE)
  if (abs(out - out2) > tol)
    stop("el valor de out obtenido no es el correcto", call. = FALSE)

	TRUE
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
  unlink(tmp)
  e2 <- 1:n
  s2 <- 1 / (2 ** e)
  out2 <- sum(s2)
	tol <- 1e-20

	if (any(abs(e - e2) > tol))
		stop("los valores del e obtenido no son los esperados", call. = FALSE)
	if (any(abs(s - s2) > tol))
		stop("los valores del s obtenido no son los esperados", call. = FALSE)
	if (any(abs(out - out2) > tol))
		stop("los valores del out obtenido no son los esperados", call. = FALSE)
  if (n < 20)
    stop("el valor de n obtenido es muy bajo", call. = FALSE)
  if (n > 20)
    stop("el valor de n obtenido es muy alto", call. = FALSE)
  TRUE
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
  n <- 10
  z <- runif(1, 1, 4)
  
  # Evaluación de objetos: e, s, out
  source(tmp, local=TRUE)
  unlink(tmp)
  e2 <- 0:n
  s2 <- 1 / (z ** e2)
  out2 <- sum(s2)
	tol <- 1e-10 # Acá la tolerancia es mayor que en otros ejercicios; se hicieron
               # pruebas y resultó necesario hacerlo.

  if (length(e) != length(e2))
	  stop("la longitud de e no es la esperada,
          ¿es posible que el primer término sea 1 y no 0?", call. = FALSE)
	if (any(abs(e - e2) > tol))
	  stop("los valores del e obtenido no son los esperados", call. = FALSE)
	if (any(abs(s - s2) > tol))
		stop("los valores del s obtenido no son los esperados", call. = FALSE)
	if (any(abs(out - out2) > tol))
		stop("el valor del out obtenido no es el esperado", call. = FALSE)
#   if (n != 20)
#     stop("el valor de n obtenido no es el correcto", call. = FALSE)

	TRUE
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
  unlink(tmp)
  n2 <- table(coleccion)
  N2 <- sum(n2)
  p2 <- n2 / N2
  dim(p) <- NULL
  H2 <- - p2 %*% log2(p2)
	tol <- 1e-20

	if (any(abs(n - n2) > tol))
		stop("los valores del n obtenido no son los esperados", call. = FALSE)
	if (abs(N - N2) > tol)
		stop("el valor del N obtenido no es el esperado", call. = FALSE)
	if (any(abs(p - p2) > tol))
		stop("los valores del p obtenido no son los esperados", call. = FALSE)
	if (abs(H[1] - H2[1]) > tol)
		stop("el valor del H obtenido no es el esperado", call. = FALSE)

	# Deprecated:
	#   gr2 <- grep('H<-', arch2)[1]
	#   x1 <- grepl("p%*%log(p,2)", arch2[gr2], fixed=TRUE)
	#   x2 <- grepl("p%*%log2(p)", arch2[gr2], fixed=TRUE)

	if (!all(dim(H) == c(1, 1)) || class(H) != "matrix") {
		warning(" ¿Es posible que haya usado una sumatoria para hallar H?", call. = FALSE)
		stop("el operador %*% no ha sido usado correctamente", call. = FALSE)

	if (any(grepl("diversity", arch)))
		stop("la palabra 'diversity' figura en su script,\n  ¿está haciendo trampa con el paquete vegan?", call. = FALSE)

	TRUE
}

cor3.b <- function() {
  # Cargar datos y script
  load('datos')
  source('shannon-2.R')

  # Generación de datos
  coleccion <- sample(20, 50, replace=TRUE)
	tol <- 1e-20
  
  # Evaluación de objetos: shannon
  if (abs(shannon(coleccion) - Shannon(coleccion)) > tol)
    stop("la salida de la función area no la esperada", call. = FALSE)

	TRUE
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
file.copy("../evaluar.R", rdir, recursive = TRUE)
# zipfile <- paste(rdir, 'zip', sep = '.')
# unlink(zipfile)
# zip(zipfile, paste(rdir, '/', sep=''))

