################################################################################
################################################################################

## NÚMERO DE REPARTIDO!
nrep <- 3
rdir <- paste('rep', nrep, sep='-')

esperados <- c("evaluar.R", "datos", "notas.csv", "INSTRUCCIONES.pdf",
               "est.rda", "usa.xls", "usa-extra.csv",
               # Los archivos de los ejercicios deben estar en el orden 
               # correcto (para el menú de 'evaluar'):
               "importar.R", "parche.R", "filtrado.R", "est.R", 
               "transformar.R", "nuevo-factor.R", "exportar.R")
corregir <- esperados[- (1:7)]
codigo <- lapply(corregir, readLines)
names(codigo) <- corregir
ejnum  <- c('1.a', '1.b', '1.c', '1.d', '1.e', '1.f', '1.g')
notas <- data.frame(Parte = c(ejnum, 'Total (%)'),
                    Nota=numeric(length(corregir) + 1),
                    Script=c(corregir, '--'))
write.csv2(notas, file='notas.csv', row.names=FALSE)
extras <- c('1.d', '1.f')
oblg   <- sum(!(ejnum %in% extras))
guardar <- c('esperados', 'corregir', 'extras', 'oblg', 'ejnum', 'guardar',
             'notas', 'codigo', 'corAll')

### FUNCIONES Y DATOS AUXILIARES:

source('make-aux.R')
load('aux')
guardar <- c(guardar, 'usa.check', 'usa.inc', 'usa2', 'usa3', 'usaNorm', 'outAnalf')

.usainc <- function() {
  load('datos')
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
  if (!identical(dim(usa), dim(usa.check)))
    stop("las dimensiones de usa no son correctas", call. = FALSE)
  if (!identical(colnames(usa), colnames(usa.check)))
    stop("Los nombres de las columnas de usa no son los correctos", call. = FALSE)
  if (!identical(rownames(usa), rownames(usa.check)))
    stop("Los nombres de las filas de usa no son los correctos", call. = FALSE)
  if (!identical(usa, usa.check))
    stop("usa no es idéntica al objeto esperado", call. = FALSE)
  clases1 <- sapply(usa, class)
  clases2 <- sapply(usa.check, class)
  if (!identical(clases1, clases2))
    stop("las clases de las columnas de usa no son correctas", call. = FALSE)
  unlink(tmp)  
  TRUE
}

cor1.b <- function() {
  # Cargar datos
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
  usa  <- usaX
  usaX$Analf[nas] <- parche
  source(tmp, local = TRUE)
  unlink(tmp)
  if (!is.data.frame(usa2))
    stop("usa2 no es 'data.frame'", call. = FALSE)
  if (!identical(colnames(usa2), colnames(usaX)))
    stop("Los nombres de las columnas de usa2 no son los correctos", call. = FALSE)
  if (!identical(rownames(usa2), rownames(usaX)))
    stop("Los nombres de las filas de usa2 no son los correctos", call. = FALSE)
  if (!all(usa2 == usaX, na.rm = TRUE))
    stop("El usa2 resultante no tiene los valores correctos", call. = FALSE)
  if (!identical(usa2$Analf, usaX$Analf))
    stop("La columna 'Analf' de usa2 no toma los valres correctos", call. = FALSE)
  TRUE
}

cor1.c <- function() {
  # Cargar datos
  load('datos')
  
  # Cortar el archivo original y crear uno temporal
  arch <- readLines('filtrado.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos
#   browser()
  usaX <- usa2
  usaX$Ingresos <- rpois(nrow(usaX), 5050)
  usaX$Ingresos[sample(nrow(usaX), sample(4:15, 1))] <- NA
  usa2 <- usaX
  usaX <- subset(usaX, !is.na(Ingresos))

  # Evaluación de objetos: usa3
  source(tmp, local = TRUE)
  unlink(tmp)
  if (!is.data.frame(usa3))
    stop("usa3 no es 'data.frame'", call. = FALSE)
  if (!identical(colnames(usa3), colnames(usa.check)))
    stop("Los nombres de las columnas de usa3 no son los correctos", call. = FALSE)
  if (!identical(rownames(usa3), rownames(usaX)))
    stop("Los nombres de las filas de usa3 no son los correctos", call. = FALSE)
  if (!all(!is.na(usa3$Ingresos)))
    stop("El usa3 resultante contiene NA's en la columna 'Ingresos'", call. = FALSE)
  if (!all(usa3 == usaX, na.rm = TRUE))
    stop("El usa3 resultante no tiene los valores correctos", call. = FALSE)
  TRUE
}

## Ej. 2

cor1.d <- function() {
  # Cargar datos
  load('datos')
  # Cortar el archivo original y crear uno temporal
  arch <- readLines('est.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  arch2 <- gsub(' ', '', arch)
  f <- grep('est<-', arch2)
  arch[f] <- sub('est', 'est.foo', arch[f])
  writeLines(arch, tmp)

  # Generación de datos
  estX <- function(x)
    (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)

  # Evaluación de objetos: ctg y conteo
  source(tmp, local=TRUE)
  unlink(tmp)
  x <- rnorm(100, 15, 3)
  x[sample(100, 3)] <- NA
  o1 <- est.foo(x)
  o2 <- estX(x)
  if (!sum(is.na(o1)) == sum(is.na(x)))
    stop("La función est no maneja correctamente los valores NA", call. = FALSE)
  if (!identical(o1, o2))
    stop("La salida de la función est no es idéntica a la esperada", call. = FALSE)
  TRUE
}

cor1.e <- function() {
  # Cargar datos
  load('datos')
  
  # Cortar el archivo original y crear uno temporal
  arch <- readLines('transformar.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)
  arch2 <- gsub(' ', '', arch)
  app <- grep('apply', arch2)
  arch[app] <- sub('est', 'estX', arch[app])
  writeLines(arch, tmp)
  
  # Generación de datos
  estX <- function(x)
    (x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE)
  datosNumericosX <- usa3[-c(1, 10)]
  datosTransX <- apply(datosNumericosX, 2, estX)
  datosTransX <- as.data.frame(datosTransX)
  usaNormX <- cbind(usa3['Abrev'], datosTransX, usa3['Division'])

  # Evaluación de objetos: datosNumericos, datosTrans, usaNorm
  source(tmp, local=TRUE)
  unlink(tmp)
  if (!all(apply(datosNumericos, 2, is.numeric)))
    stop("datosNumericos tiene columnas no numéricas", call. = FALSE)
  if (!all(datosNumericos == datosNumericosX, na.rm = TRUE)) {
    stop("datosNumericos no coincide con los valores de las columnas numéricas de usa3",
         call. = FALSE)
  }
  if (!all(datosTransX == datosTrans, na.rm = TRUE)) {
    stop("los valores de datosTrans no coinciden con los valores esperados",
         call. = FALSE)
  }
  rm(datosTrans)
  txt <- arch[app]
  txt <- sub('datosNumericos', 'datosNumericosX', txt)
  eval(parse(text = txt))
  datosTransX <- apply(datosNumericosX, 2, estX)
  if (!identical(datosTrans, datosTransX))
    stop("no parece que haya usado la función apply como se indica en la letra", call. = FALSE)
  if (!is.data.frame(usaNorm))
    stop("usaNorm no es de clase data.frame", call. = FALSE)
  if (!identical(colnames(usaNorm), colnames(usaNormX)))
    stop("los nombres de las columnas de usaNorm no son los correctos", call. = FALSE)
  if (!identical(rownames(usaNorm), rownames(usaNormX)))
    stop("los nombres de las filas de usaNorm no son los correctos", call. = FALSE)
  if (!all(usaNorm == usaNormX, na.rm = TRUE))
    stop("los valores de usaNorm no coinciden con los esperados", call. = FALSE)
  TRUE
}

cor1.f <- function() {
  # Cargar datos
  load('datos')

  # Cortar el archivo original y crear uno temporal
  arch <- readLines('nuevo-factor.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  bx <- grep('boxplot', arch)
  arch <- c(arch[1:(bx - 1)],
            "png(tmp2 <- tempfile())",
            arch[bx],
            "dev.off()")
  tmp <- tempfile()
  writeLines(arch, tmp)
  
  # Generación de datos
  usa3$Ingresos <- rpois(nrow(usa3), 5050)
  usaX <- usa3
  usaX$Ing.Cat <- cut(usaX$Ingresos, 4)
  salidaTapplyX <- tapply(usaX$Analf, usaX$Ing.Cat, summary)
  png(tmp3 <- tempfile())
    salidaBoxplotX <- boxplot(Analf ~ Ing.Cat, usaX)
  dev.off()
  unlink(tmp3)

  # Evaluación de objetos: usa3, salidaTapply, salidaBoxplot
  source(tmp, local=TRUE)
  unlink(tmp)
  unlink(tmp2)
  if (!identical(usa3$Ing.Cat, usaX$Ing.Cat))
    stop("El el factor Ing.Cat obtenido difiere del esperado", call. = FALSE)
  if (!identical(salidaTapply, salidaTapplyX))
    stop("El objeto salidaTapply resultante difiere del esperado", call. = FALSE)
  if (!identical(salidaBoxplot, salidaBoxplotX))
    stop("El objeto salidaBoxplot resultante difiere del esperado", call. = FALSE)
  TRUE
}

## Ej. 3

cor1.g <- function() {
  # Cargar datos
  load('datos')
  
  # Cortar el archivo original y crear uno temporal
  arch <- readLines('exportar.R')
  arch2 <- gsub(' ', '', arch)
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  tmp <- tempfile()
  writeLines(arch, tmp)

  # Generación de datos
  tmp2 <- tempfile()
  write.table(usaNorm, tmp2, row.names = TRUE, 
              col.names = TRUE, sep = ";", dec = ",")
  usa.tmp <- readLines(tmp2)
  usa.importX <- read.table(tmp2, header = TRUE, sep = ";", dec = ",",
                           row.names = 1)
  unlink(tmp2)

  # Evaluación de objetos: archivo 'usa-norm.csv'
  source(tmp, local=TRUE)
  unlink(tmp)
  usa.norm <- readLines('usa-norm.csv')
  usa.import <- read.table('usa-norm.csv', header = TRUE, sep = ";", dec = ",",
                           row.names = 1)
  if (ncol(usa.import) != ncol(usa.importX))
    stop("Aparentemente el separador de columnas no es ';'", call. = FALSE)
  if (!is.numeric(usa.import[,sample(2:9, 1)]))
    stop("Aparentemente el punto decimal no es ','", call. = FALSE)
  if (!identical(colnames(usa.importX), colnames(usa.import)))
    stop("Los nombres de las columnas no se guardaron correctamente", call. = FALSE)
  if (!identical(rownames(usa.importX), rownames(usa.import)))
    stop("Los nombres de las filas no son los correctos", call. = FALSE)
  if (!identical(usa.tmp, usa.norm))
    stop("El archivo usa-norm.csv no es idéntico al esperado", call. = FALSE)
  TRUE
}

corAll <- list(cor1.a, cor1.b, cor1.c, cor1.d, cor1.e, cor1.f, cor1.g)

################################################################################

save(list=guardar, file='datos')
borrar <- dir(rdir)
borrar <- file.path(rdir, borrar)
unlink(borrar, recursive=TRUE)

file.copy(esperados, rdir, recursive=TRUE)
zipfile <- paste(rdir, 'zip', sep = '.')
unlink(zipfile)
# print(dir())
zip(zipfile, paste(rdir, '/', sep=''))
