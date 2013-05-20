################################################################################
################################################################################

## NÚMERO DE REPARTIDO!
nrep <- 3
rdir <- paste('rep', nrep, sep='-')

esperados <- c("datos", "notas.csv", "INSTRUCCIONES.pdf",
               "est.RData", "usa.xls", "usa-extra.csv")
# Los archivos de los ejercicios deben est
# correcto (para el menú de 'evaluar'):
corregir <- c("importar.R", "parche.R", "filtrado.R", "est.R", 
              "transformar.R", "nuevo-factor.R", "exportar.R")
esperados <- c(esperados, corregir)
codigo <- lapply(corregir, readLines)
names(codigo) <- corregir
ejnum  <- c('1.a', '1.b', '1.c', '1.d', '1.e', '1.f', '1.g')
notas <- data.frame(Parte = c(ejnum, 'Total (%)'),
                    Nota=numeric(length(corregir) + 1),
                    Script=c(corregir, '--'))
write.csv2(notas, file='notas.csv', row.names=FALSE)
extras <- c('1.d', '1.f')
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

cut.script <- function(arch) {
  arch <- readLines(arch)
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  arch <- sacar.comentarios(arch)
  tmp <- tempfile()
  writeLines(arch, tmp)
  return(tmp)
}
guardar <- c(guardar, 'cut.script')

# source('../auxiliares.R')
# guardar <- c(guardar, objetos)
source('make-aux.R')
load('auxiliar.RData')

### FUNCIONES DE CORRECCIÓN:

## Ej. 1

cor1.a <- function() {
  # Cargar 'datos'
  load('datos')

  # Cortar el archivo original y crear uno temporal
  tmp <- cut.script('importar.')
  
  # Evaluación de objetos: usa
  source(tmp, local = TRUE)
  unlink(tmp)

  cn  <- colnames(usa)
  cn2 <- colnames(usa.check)
  rn  <- rownames(usa)
  rn2 <- rownames(usa.check)

  if (!is.data.frame(usa))
    stop("usa no es 'data.frame'", call. = FALSE)

  if (!all(dim(usa) == dim(usa.check))) {
    mensaje <- mkmsj.v("las dimensiones de usa no son las esperadas",
                       dim(usa), dim(usa.check))
    return(mensaje)
  }

  if (all(toupper(cn) == toupper(cn2)) && any(cn != cn2))
    warning(" Parece haber un problema de mayúsculas/minúsculas en los nombres de las columnas", call. = FALSE)
  if (!all(cn == cn2))
    stop("Los nombres de las columnas de usa no son los esperados", call. = FALSE)

  if (all(toupper(cn) == toupper(cn2)) && any(cn != cn2))
    warning(" Parece haber un problema de mayúsculas/minúsculas en los nombres de las filas", call. = FALSE)
  if (!identical(rn, rn2))
    stop("Los nombres de las filas de usa no son los esperados", call. = FALSE)

  if (!all(usa == usa.check, na.rm = TRUE)) {
    mensaje <- mkmsj.df("Hay valores en la data.frame usa que no son los esperados",
                        usa, usa.check)
    return(mensaje)
  }

  clases1 <- sapply(usa, class)
  clases2 <- sapply(usa.check, class)
  if (!all(clases1 == clases2)) {
    mensaje <- mkmsj.v("Las clases de las columnas de usa no son las esperadas",
                       clases1, clases2)
    return(mensaje)
  }
  TRUE
}

cor1.b <- function() {
  # Cargar datos
  load('datos')
  # Cortar el archivo original y crear uno temporal
  tmp <- cut.script('parche.R')

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

  # Asegurarse de que no hay NA en Analf:
  if (any(is.na(usa2$Analf))) {
    donde <- paste(which(is.na(usa2$Analf)), collapse = " ")
    return(paste("La columna Analf aún tiene valores NA en las posiciones:", donde, "\n", sep = " "))
  }

  if (!identical(usa2$Analf, usaX$Analf)) {
    mensaje <- mkmsj.df("Los valores de usa2$Analf no son los esperados,\n",
                        usa2["Analf"], usaX["Analf"])
    return(mensaje)
  }

  if (!all(usa2 == usaX, na.rm = TRUE)) {
    mensaje <- mkmsj.df("Hay valores en la data.frame usa2 que no son los esperados",
                        usa2, usaX)
    return(mensaje)
  }
  TRUE
}

cor1.c <- function() {
  # Cargar datos
  load('datos')
  
  # Cortar el archivo original y crear uno temporal
  tmp <- cut.script('filtrado.R')

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

  if (any(is.na(usa3$Ingresos))) {
    warning(" Ej. 1.c: En la corrección los NA son puestos en posiciones aleatorias de la columna", call. = FALSE)
    donde <- paste(which(is.na(usa3$Ingresos)), collapse = " ")
    return(paste("La columna Ingresos aún tiene valores NA en las posiciones:", donde, "\n", sep = " "))
  }

  if (!all(usa3 == usaX, na.rm = TRUE)) {
    mensaje <- mkmsj.df("Hay valores en la data.frame usa3 que no son los esperados",
                        usa3, usaX)
    return(mensaje)
  }

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
#   arch2 <- gsub(' ', '', arch)
#   f <- grep('est<-', arch2)
#   arch[f] <- sub('est', 'est.foo', arch[f])
  arch <- c(arch, "est.foo <- est")
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

  if (all(is.na(o1)))
    stop("los valores de salida de est son todos NA", call. = FALSE)

  if (is.na(o1) != is.na(x)) {
    warning("  En la corrección se utiliza un vector aleatorio como entrada de est (con NA's)", call. = FALSE)
    stop("las posiciones de los NA en la salida de est no son idénticas a las del vector de entrada", call. = FALSE)
  }

  if (!all(o1 == o2, na.rm = TRUE))
    stop("los valores de salida de la función est no es idéntica a la esperada", call. = FALSE)
  TRUE
}

cor1.e <- function() {
  # Cargar datos
  load('datos')
  
  # Cortar el archivo original y crear uno temporal
  arch <- readLines('transformar.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  arch <- sacar.comentarios(arch)
  tmp <- tempfile()
  writeLines(arch, tmp)
  arch2 <- gsub(' ', '', arch)
  app <- grep('apply', arch2)

  if (!any(grepl('apply', arch)))
    stop("la función apply no figura en su código", call. = FALSE)

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
  source(tmp, local = TRUE)
  unlink(tmp)

  if (!is.data.frame(datosNumericos) && !is.matrix(datosNumericos))
    stop("datosNumericos no es de clase matrix ni data.frame", call. = FALSE)

  if (is.data.frame(datosNumericos)) {
    num <- sapply(datosNumericos, is.numeric)
    if (!all(num)) {
      cols <- paste(names(datosNumericos)[!num], collapse = " ")
      stop(paste("datosNumericos tiene columnas no numéricas:", cols), call. = FALSE)
    }
  } else {
    if (!is.numeric(datosNumericos)) {
      clase <- class(datosNumericos[1])
      stop(paste("datosNumericos no es una matriz numérica si no", clase), call. = FALSE)
    }
  }

  if (!all(datosNumericos == datosNumericosX, na.rm = TRUE)) {
    mensaje <- mkmsj.df("datosNumericos no coincide con los valores de las columnas numéricas de usa3",
                        datosNumericos, datosNumericosX)
    return(mensaje)
  }

  if (!is.matrix(datosTrans))
    stop("datosTrans no es de clase matrix", call. = FALSE)

  if (!all(datosTrans == datosTransX, na.rm = TRUE)) {
    mensaje <- mkmsj.m("Los valores de datosTrans no coinciden con los valores esperados",
                        datosTrans, datosTransX)
    return(mensaje)
  }

  if (!is.data.frame(usaNorm))
    stop("usaNorm no es de clase data.frame", call. = FALSE)

  if (!all(colnames(usaNorm) == colnames(usaNormX))) {
    mensaje <- mkmsj.v("los nombres de las columnas de usaNorm no son los correctos",
                       colnames(usaNorm), colnames(usaNormX))
    return(mensaje)
  }

  if (!all(rownames(usaNorm) == rownames(usaNormX))) {
    mensaje <- mkmsj.v("los nombres de las filas de usaNorm no son los correctos",
                       rownames(usaNorm), rownames(usaNormX))
    return(mensaje)
  }

  if (!all(usaNorm == usaNormX, na.rm = TRUE)) {
    mensaje <- mkmsj.df("los valores de usaNorm no coinciden con los esperados",
                        usaNorm, usaNormX)
    return(mensaje)
  }
  
  TRUE
}

cor1.f <- function() {
  # Cargar datos
  load('datos')

  # Cortar el archivo original y crear uno temporal
  arch <- readLines('nuevo-factor.R')
  gr <- grep('#===', arch, useBytes = TRUE)
  arch <- arch[gr[1]:gr[2]]
  arch <- sacar.comentarios(arch)

  if (!any(grepl('tapply', arch)))
    stop("la función tapply no figura en su código", call. = FALSE)

  tp <- grep('tapply',  arch)
  if (!any(grepl('summary', arch[tp])))
    stop("la función summary no figura en la línea de tapply", call. = FALSE)

  if (!any(grepl('boxplot', arch)))
    stop("la función boxplot no figura en su código", call. = FALSE)

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
  levels(usaX$Ing.Cat) <- c("D", "C", "B", "A")
  salidaTapplyX <- tapply(usaX$Analf, usaX$Ing.Cat, summary)
  png(tmp3 <- tempfile())
    salidaBoxplotX <- boxplot(Analf ~ Ing.Cat, usaX)
  dev.off()
  unlink(tmp3)

  # Evaluación de objetos: usa3, salidaTapply, salidaBoxplot
  source(tmp, local=TRUE)
  unlink(tmp)
  unlink(tmp2)
  usa3a <- usa3 # Para tener a mano uno con el cual hacer pruebas... (usa3a es creado también en make-aux.R)

  if (!any("Ing.Cat" %in% names(usa3a)))
    stop("no hay columna llamada 'Ing.Cat' en usa3", call. = FALSE)

  if (!is.factor(usa3a$Ing.Cat))
    stop("la columna Ing.Cat de usa3 no es de clase factor", call. = FALSE)

  if (nlevels(usa3a$Ing.Cat) != 4)
    stop("el factor usa3$Ing.Cat no tiene 4 niveles como debería", call. = FALSE)

  if (!all(levels(usa3a$Ing.Cat) == c("D", "C", "B", "A"))) {
    levels(usa3a$Ing.Cat) <- c("D", "C", "B", "A")
    msj <- c("Se cambiaron los nombres de los niveles del factor:\n",
             "  > levels(usa3$Ing.Cat) <- c('D', 'C', 'B', 'A')\n")
    warning(msj, call. = FALSE)
  }

  if (!all(usa3a$Ing.Cat == usaX$Ing.Cat)) {
    warning("  Ej. 1.f: se crearon valores aleatorios de usa3$Ingresos para la corrección.", call. = FALSE)
    mensaje <- mkmsj.v("El el factor usa3$Ing.Cat obtenido difiere del esperado",
                       usa3a$Ing.Cat, usaX$Ing.Cat)
    return(mensaje)
  }

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

  if (grepl("^\"\";", usa.norm[1]))
    usa.norm[1] <- sub("^\"\";", "", usa.norm[1])
  usa.import <- read.table('usa-norm.csv', header = TRUE, sep = ";", dec = ",", row.names = 1)

  if (ncol(usa.import) != ncol(usa.importX)) {
    mensaje <- mkmsj.v("Al importar usa-norm.csv el número de columnas no es el esperado",
                       ncol(usa.import), ncol(usa.importX))
    warning(mensaje, call. = FALSE)
    stop("Aparentemente el separador de columnas no es ';'", call. = FALSE)
  }

  if (!is.numeric(usa.import[,sample(2:9, 1)]))
    stop("Aparentemente el punto decimal no es ','", call. = FALSE)

  if (!all(colnames(usa.importX) == colnames(usa.import))) {
    mensaje <- mkmsj.v("Los nombres de las columnas no se guardaron correctamente",
                       colnames(usa.import), colnames(usa.importX))
    return(mensaje)
  }

  if (!all(rownames(usa.importX) == rownames(usa.import))) {
    mensaje <- mkmsj.v("Los nombres de las filas no se guardaron correctamente",
                       rownames(usa.import), rownames(usa.importX))
    return(mensaje)
  }

  if (!all(usa.importX == usa.import, na.rm = TRUE)) {
    mensaje <- mkmsj.df("Los valores de usa.norm parece que no se guardaron correctamente",
                        usa.import, usa.importX)
    return(mensaje)
  }

  TRUE
}

corAll <- list(cor1.a, cor1.b, cor1.c, cor1.d, cor1.e, cor1.f, cor1.g)

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
