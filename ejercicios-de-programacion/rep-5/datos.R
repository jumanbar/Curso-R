################################################################################
### NÚMERO DE REPARTIDO!
rdir <- basename(getwd())
nrep <- as.numeric(gsub("[[:alpha:][:punct:]]", "", rdir))
rep.date <- format(Sys.time(), "%Y-%m-%d %H:%M %Z") # Fecha en que se hizo "datos"
url.datos <- "" # URL acortada para bajar el archivo datos
if (url.datos == "") stop("FALTA URL.DATOS!")
url.fecha <- "https://www.dropbox.com/s/yupjqgoe33fdu3c/fecha-datos-rep-5.txt"
guardar <- c("guardar", "rdir", "nrep", "rep.date", "url.datos")
writeLines(rep.date, paste0("~/../Dropbox/IMSER/fecha-datos-", rdir, ".txt"))

# Existe ya el subdir?
if (!file.exists(rdir))
  dir.create(rdir)

### BORRAR LOS ARCHIVOS:
unlink(file.path(rdir, dir(rdir)), recursive = TRUE)

### ARCHIVOS AUXILIARES:
aux <- c("../evaluar.R", "datos", "INSTRUCCIONES.pdf", "edu.data.rda", "HandbookSpanish.pdf")

### SCRIPTS DE EJERCICIOS:
# Es importante que un guión separe el número del nombre en sí...
# Formato:
# [1-N].[a-z]-[palabra en minúscula, sólo letras].R
corregir <- c("1-triangulo.R", "2.a-filtroc.R", "3.a-cambiaPares.R", "3.b-radio.R", "3.c-extra-distancias.R")
corregir <- sort(corregir)
guardar  <- c(guardar, "corregir", "aux")

### Números de ejercicios
cor.split <- strsplit(corregir, "-")
ejnum <- unlist(cor.split)[grepl("^[0-9]", unlist(cor.split))]

### FUNCIONES AUXILIARES:
source("../auxiliares.R", encoding = "UTF-8")
guardar <- c(guardar, objetos)

### CORRECTORES
source("correctores.R", encoding = "UTF-8")
corAll <- vector("list") # Lista con funciones de corrección
eval(parse(text = paste0("corAll$cor", ejnum, " <- cor", ejnum)))
guardar <- c(guardar, "corAll")

### NOTAS
extras <- ejnum[grep("extra", corregir)]
# extras <- ''
oblg <- sum(!(ejnum %in% extras)) # Cuantos són los obligatorios?
notas <- data.frame(Parte = c(ejnum, 'Total (%)'),
                    Nota=numeric(length(corregir) + 1),
                    Script=c(corregir, '--'))
guardar <- c(guardar, "ejnum", "notas", "extras", "oblg")

### AUXILIAR.RDATA
source("make-aux.R", encoding = "UTF-8")
aux <- c(aux, "auxiliar.RData")

## Guardando el código:
codigo <- lapply(corregir, cut.script)
names(codigo) <- corregir
class(codigo) <- "codigo"
guardar <- c(guardar, "codigo")

### El total de los esperados...:
esperados <- c(aux, corregir) # evaluar.R todavía no!!
guardar <- c(guardar, "esperados")

### GUARDAR TODO
guardar <- unique(guardar)
save(list = guardar, file = 'datos')

file.copy(esperados, rdir, recursive = TRUE)


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

