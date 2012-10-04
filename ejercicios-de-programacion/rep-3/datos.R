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

load('aux')
guardar <- c(guardar, 'usa.check', 'usa.inc', 'usa2', 'usa3', 'usaNorm', 'outAnalf')

.usainc <- function() {
#   browser()
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
  f0 <- identical(usa, usa.check)
  if (!f0)
    stop("usa no es idéntica al objeto esperado", call. = FALSE)
  unlink(tmp)  
  f0
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
  f0 <- is.data.frame(usa2)
  if (!f0)
    stop("usa2 no es 'data.frame'", call. = FALSE)
  f1 <- identical(colnames(usa2), colnames(usaX))
  if (!f1)
    stop("Los nombres de las columnas de usa2 no son los correctos", call. = FALSE)
  f2 <- identical(rownames(usa2), rownames(usaX))
  if (!f2)
    stop("Los nombres de las filas de usa2 no son los correctos", call. = FALSE)
  f3 <- all(usa2 == usaX, na.rm = TRUE)
  if (!f3)
    stop("El usa2 resultante no tiene los valores correctos", call. = FALSE)
  f4 <- identical(usa2$Analf, usaX$Analf)
  if (!f4)
    stop("La columna 'Analf' de usa2 no toma los valres correctos", call. = FALSE)
  all(f0, f1, f2, f3, f4)
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
  f0 <- is.data.frame(usa3)
  if (!f0)
    stop("usa3 no es 'data.frame'", call. = FALSE)
  f1 <- identical(colnames(usa3), colnames(usa.check))
  if (!f1)
    stop("Los nombres de las columnas de usa3 no son los correctos", call. = FALSE)
  f2 <- identical(rownames(usa3), rownames(usaX))
  if (!f2)
    stop("Los nombres de las filas de usa3 no son los correctos", call. = FALSE)
  f3 <- all(!is.na(usa3$Ingresos))
  if (!f3)
    stop("El usa3 resultante contiene NA's en la columna 'Ingresos'", call. = FALSE)
  f4 <- all(usa3 == usaX, na.rm = TRUE)
  if (!f4)
    stop("El usa3 resultante no tiene los valores correctos", call. = FALSE)
  all(f0, f1, f2, f3, f4)
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
    (x - mean(x, na.rm = T)) / sd(x, na.rm = T)

  # Evaluación de objetos: ctg y conteo
  source(tmp, local=TRUE)
  unlink(tmp)
  x <- rnorm(100, 15, 3)
  x[sample(100, 3)] <- NA
  o1 <- est.foo(x)
  o2 <- estX(x)
  f0 <- sum(is.na(o1)) == sum(is.na(x))
  if (!f0)
    stop("La función est no maneja correctamente los valores NA", call. = FALSE)
  f1 <- identical(o1, o2)
  if (!f1)
    stop("La salida de la función est no es idéntica a la esperada", call. = FALSE)
  all(f0, f1)
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
  
  # Generación de datos
  datosNumericosX <- usa3[-c(1, 10)]
  datosTransX <- apply(datosNumericosX, 2, est)
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
  if (!any(grepl('datosTrans<-apply\\(datosNumericos,2,est\\)', arch2)))
    stop("No parece que haya usado la función apply como se indica en la letra", call. = FALSE)
  if (!all(datosTransX == datosTrans, na.rm = TRUE)) {
    stop("Los valores de datosTrans no coinciden con los valores esperados",
         call. = FALSE)
  }
  if (!is.data.frame(usaNorm))
    stop("usaNorm no es de clase data.frame", call. = FALSE)
  if (!identical(colnames(usaNorm), colnames(usaNormX)))
    stop("Los nombres de las columnas de usaNorm no son los correctos", call. = FALSE)
  if (!identical(rownames(usaNorm), rownames(usaNormX)))
    stop("Los nombres de las filas de usaNorm no son los correctos", call. = FALSE)
  if (!all(usaNorm == usaNormX, na.rm = TRUE))
    stop("Los valores de usaNorm no coinciden con los esperados", call. = FALSE)
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
if (!any(dir() == rdir)) {
  dir.create(rdir)
} else {
  unlink(file.path(rdir, '*'))
}
file.copy(esperados, rdir, recursive=TRUE)
zip(paste(rdir, 'zip', sep='.'), paste(rdir, '/', sep=''))
