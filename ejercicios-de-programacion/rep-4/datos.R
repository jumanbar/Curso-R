################################################################################
################################################################################

## NÚMERO DE REPARTIDO!
nrep <- 4
rdir <- paste('rep', nrep, sep='-')

esperados <- c("datos", "notas.csv", "INSTRUCCIONES.pdf",
               "edu.data.rda", "HandbookSpanish.pdf",
               # Los archivos de los ejercicios deben estar en el orden 
               # correcto (para el menú de 'evaluar'):
               "triangulo.R", "educacion.R", "cambiaPares.R", "radio.R", 
               "distancias.R")
corregir <- esperados[- (1:5)]
codigo <- lapply(corregir, readLines)
names(codigo) <- corregir
ejnum  <- c('1', '2', '3.a', '3.b', '3.c')
notas <- data.frame(Parte = c(ejnum, 'Total (%)'),
                    Nota=numeric(length(corregir) + 1),
                    Script=c(corregir, '--'))
write.csv2(notas, file='notas.csv', row.names=FALSE)
extras <- c('3.c')
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

tri <- function(cat.ad, cat.op) {
  hipot <- sqrt(cat.ad ** 2 + cat.op ** 2)
  area  <- cat.op * cat.ad / 2
  ang.ad <- acos(cat.ad / hipot) * 180 / pi
  ang.op <- asin(cat.ad / hipot) * 180 / pi
  out <- list(hipotenusa = hipot, area = area, 
              angulo.adyacente = ang.ad, 
              angulo.opuesto = ang.op)
  out
}

edu <- function(x, tmcol = grep('TM', names(x)), 
                      pacol = grep('PA', names(x)), 
                      tacol = "TA") {
  TM <- apply(x[, tmcol], 1, mean, na.rm=T)
  PA <- apply(x[, pacol], 1, mean, na.rm=T)
  TA <- x[, tacol]
  PC <- TM * PA / 100
  x <- cbind(x, TM, PA, PC)
  regresion <- lm(TA ~ PC)
  coeficientes <- coef(regresion)
  salida <- summary(regresion)
  r2 <- salida$r.squared
  p.valor <- salida$coefficients[, 4]
  return(list(coeficientes=coeficientes, p.valor=p.valor, r2=r2, datos=x))
}

cpr <- function(x, subs=0) {
  len <- length(x)
  pares <- seq(2, len, by=2)
  x[pares] <- subs
  return(x)
}

rad <- function(r) {
  r <- abs(r)
  perimetro <- 2 * pi * r
  area      <- pi * r ^ 2
  volumen   <- 4 * pi * r ^ 3 / 3
  cat('Perímetro:', round(perimetro, 2), '\n')
  cat('Área:     ', round(area, 2), '\n')
  cat('Volumen:  ', round(volumen, 2), '\n')
  salida <- c(P=perimetro, A=area, V=volumen)
  invisible(salida)
}

dis <- function(pnt, p = c(0, 0), ver = TRUE) {
  if (!(class(pnt) %in% c('data.frame', 'matrix')) || !is.numeric(pnt) || ncol(pnt) != 2)
        stop('El objeto pnt no tiene el formato adecuado')
  if (!is.numeric(p) || length(p) != 2)
        stop('El objeto p no es numérico o tiene longitud != 2')
  mp <- matrix(p, nrow = nrow(pnt), ncol = 2, byrow = TRUE)
  catetos <- abs(pnt - mp)            
  ord <- t(apply(catetos, 1, sort))   
  r <- ord[,1] / ord[, 2]             
  dists <- ord[, 2] * sqrt(1 + r ^ 2) 
  i.max <- which.max(dists)
  i.min <- which.min(dists)
  d.max <- dists[i.max]
  d.min <- dists[i.min]
  pout <- pnt[c(i.max, i.min), ]
  rownames(pout) <- c('d.max', 'd.min')
  colnames(pout) <- c('x', 'y')
  if (ver) {
    plot(pnt, xlab = 'Longitud', ylab = 'Latitud')
    points(p[1], p[2], pch = 19)
    points(pnt[c(i.max, i.min), ], pch = 19, col = 2:3)
    segments(p[1], p[2], pout[, 1], pout[, 2], col = 2:3, lwd = 2)
  }
  cat('d.max =', round(d.max, 2), '- punto:', round(pout[1, ], 2), '\n')
  cat('d.min =', round(d.min, 2), '- punto:', round(pout[2, ], 2), '\n')
  list(dists = c(d.max = d.max, d.min = d.min),
       posiciones = c(i.max = i.max, i.min = i.min),
       puntos = pout, centro = p)
}

guardar <- c(guardar, 'tri', 'edu', 'cpr', 'rad', 'dis')

### FUNCIONES DE CORRECCIÓN:

## Ej. 1
cor1 <- function() {
  load('datos')

  # Evaluación de la función "triangulo":
  source('triangulo.R', local = TRUE)
  ca <- rpois(1, 10)
  co <- rpois(1, 10)
  out1 <- triangulo(ca, co)
  names(out1) <- tolower(names(out1))
  out2 <- tri(ca, co)
  tol <- 1e-4
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

cor2 <- function() {
  # Cargar datos
  load('datos')
  load('edu.data.rda')

  # Evaluación de la función "educacion":
  source('educacion.R', local = TRUE)
  fnames1 <- sort(names(formals(educacion)))
  fnames2 <- sort(names(formals(edu)))
  e <- edu.data[- sample(nrow(edu.data), 1), sample(ncol(edu.data))]
  tmc <- grep('TM', names(e))
  pac <- grep('PA', names(e))
  tac <- grep('TA', names(e))
  tmp <- tempfile()
  png(tmp)
  out1 <- educacion(x=e, tmcol=tmc, pacol=pac, tacol=tac)
  dev.off()
  unlink(tmp)
  names(out1) <- tolower(names(out1))
  out2 <- edu(x=e, tmcol=tmc, pacol=pac, tacol=tac)
  tm <- out2$datos$TM
  pa <- out2$datos$PA
  pc <- out2$datos$PC
  if (!all(fnames1 == fnames2))
    stop("los nombres de los argumentos no son los indicados por la letra")
  if (!is.list(out1))
    stop("la salida no es una lista", call. = FALSE)
  if (!all(names(out1) == names(out2)))
    stop("los nombres del objeto de salida no coinciden con los esperados", call. = FALSE)
  if (!all(out1$coeficientes == out2$coeficientes))
    stop("los valores de los coeficientes no son correctos", call. = FALSE)
  if (!all(out1$p.valor == out2$p.valor))
    stop("los valores de los p.valor no son correctos", call. = FALSE)
  if (out1$r2 != out2$r2)
    stop("los valores del r2 no son correctos", call. = FALSE)
  if (!is.data.frame(out1$datos))
    stop("los datos de la salida no están en formato de data.frame", call. = FALSE)
  if (!any(apply(out1$datos == tm, 2, all)))
    stop("falta o está mal la columna con los TM promedios en los datos de salida", call. = FALSE)
  if (!any(apply(out1$datos == pa, 2, all)))
    stop("falta o está mal la columna con los PA promedios en los datos de salida", call. = FALSE)
  if (!any(apply(out1$datos == pc, 2, all)))
    stop("falta o está mal la columna con los PC promedios en los datos de salida", call. = FALSE)
  TRUE
}

cor3.a <- function() {
  # Cargar datos
  load('datos')
  
  # Generación de datos
  n <- sample(10:100, 1)
  v <- rpois(n, 80)
  s <- - rpois(1, 300)
  source('cambiaPares.R', local = TRUE)
  out1 <- cambiaPares(v, s)
  out2 <- cpr(v, s)
  if (!identical(out1, out2))
    stop("¡el script 'cambiaPares.R' aún tiene errores!", call. = FALSE)
  TRUE
}

cor3.b <- function() {
  # Cargar datos
  load('datos')

  # Generación de datos
  r <- rnorm(1, sd = 30)
  source('radio.R', local = TRUE)
  p1 <- capture.output(out1 <- radio(r))
  p1 <- gsub(' ', '', p1)
  p2 <- capture.output(out2 <- rad(r))
  p2 <- gsub(' ', '', p2)
  if (!all(p1 == p2))
    stop("el mensaje que 'radio' imprime en la consola no coincide con el esperado.", call. = FALSE)
  if (!identical(out1, out2))
    stop("el objeto de salida ('salida') es distinto al esperado.", call. = FALSE)
  TRUE
}

cor3.c <- function() {
  # ARREGLAR PARA 2013: LA FUNCIÓN NO EVALÚA SI SE PRODUCE UN GRÁFICO O NO... (ES DECIR,
  # IGNORA EL ERROR DE LA LÍNEA 34 ("!"ver debe cambiarse por "ver"
  # Cargar datos
  load('datos')
  
  # Generación de datos
  p <- rnorm(2)
  x <- matrix(rnorm(80, sd = 30), ncol = 2)
  source('distancias.R', local = TRUE)
  p1 <- capture.output(out1 <- distancias(x, p, FALSE))
  p2 <- capture.output(out2 <- dis(x, p, FALSE))
  if (!identical(p1, p2))
    stop("¡el script 'distancias.R' aún tiene errores!", call. = FALSE)
  if (!identical(out1, out2))
    stop("¡el script 'distancias.R' aún tiene errores (en el objeto de salida)!", call. = FALSE)
  TRUE
}
corAll <- list(cor1, cor2, cor3.a, cor3.b, cor3.c)

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

