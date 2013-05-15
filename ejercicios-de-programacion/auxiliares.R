
objetos <- NULL

### GENERALES

mkmsj.v <- function(msj.base = "", vec.obs, vec.esp) {
  # msj.base: mensaje indicando en qué objeto está el error,
  #           ej.: El vector XXX no coincide con lo esperado
  #           nota: se agrega una coma y un \n al final.
  # vec.obs, vec.esp: vectores observado y esperado respect.
  donde <- which(vec.obs != vec.esp)
  output <- cbind(vec.obs[donde], vec.esp[donde])
  if (is.factor(vec.obs))
    output <- cbind(as.character(vec.obs[donde]), as.character(vec.esp[donde]))
  colnames(output) <- c("Valor observado", "Valor esperado")
  if (is.null(names(vec.obs)))
    rownames(output) <- paste("Posición ", donde, ":", sep = "")
  output <- capture.output(print(output))
  mensaje <- c(paste(msj.base, ",\n", sep=""),
               "las diferencias observadas son las siguientes:\n\n", 
               paste("  ", output, "\n", sep = ""))
  mensaje
}
objetos <- c(objetos, "mkmsj.v")


mkmsj.df <- function(msj.base = "", df.obs, df.esp) {
  # msj.base: mensaje indicando en qué objeto está el error,
  #           ej.: La data.frame XXX no coincide con lo esperado
  #           nota: se agrega una coma y un \n al final.
  # df.obs, df.esp: data.frames observadas y esperadas respect.
  donde <- which(df.obs != df.esp, arr.ind = TRUE)
  output <- cbind(donde, df.obs[donde], df.esp[donde])
  output[,2] <- colnames(df.obs)[as.numeric(output[,2])]
  colnames(output) <- c("Fila", "Columna", "Valor observado", "Valore esperado")
  output <- capture.output(print(output))
  mensaje <- c(paste(msj.base, ",\n", sep=""),
               "las diferencias observadas son las siguientes:\n\n", 
               paste("  ", output, "\n", sep = ""))
  mensaje
}
objetos <- c(objetos, "mkmsj.df")


mkmsj.m <- function(msj.base = "", m.obs, m.esp) {
  # msj.base: mensaje indicando en qué objeto está el error,
  #           ej.: La matriz XXX no coincide con lo esperado
  #           nota: se agrega una coma y un \n al final.
  # m.obs, m.esp: matrices observadas y esperadas respect.
  donde <- which(m.obs != m.esp, arr.ind = TRUE)
  output <- cbind(donde, m.obs[donde], m.esp[donde])
  colnames(output) <- c("Fila", "Columna", "Valor observado", "Valore esperado")
  output <- capture.output(print(output))
  mensaje <- c(paste(msj.base, ",\n", sep=""),
               "las diferencias observadas son las siguientes:\n\n", 
               paste("  ", output, "\n", sep = ""))
  mensaje
}
objetos <- c(objetos, "mkmsj.m")

objnames <- function(esp, obj, oname, filas = FALSE) {

  if (is.matrix(obj)) {
    nombres <- colnames(obj)
    msj <- paste("los nombres de las columnas de", oname)
  } else {
    nombres <- names(obj)
    if (is.data.frame(obj)) {
      msj <- paste("los nombres de las variables de", oname)
    } else {
      msj <- paste("los nombres de los elementos de", oname)
    }
  }

  if (filas) {
    nombres <- rownames(obj)
    msj <- paste("los nombres de las filas del objeto", oname)
  }

  if (identical(nombres, esp))
    return(TRUE)

  if (is.null(nombres))
    stop(paste(msj, "es un vector NULL"), call. = FALSE)

  if (any(is.na(nombres))) 
    stop(paste(msj, "contiene NAs"), call. = FALSE)

	if (!all(nombres == esp)) {
    warn <- mkmsj.v(paste("Están mal los nombres de filas/columnas/elementos de", oname), nombres, esp)
    warning(warn, call. = FALSE)
    stop(paste(msj, "no son los/as esperados"), call. = FALSE)
	}
  FALSE
}

sacarComentarios <- function(s) {
  # Saca comentarios en un vector character, el cual se supone
  # que contiene líneas de código R (cada elemento de s = una
  # línea de código).
  # i.e.: saca todo lo que viene después del # en cada línea
  s <- s[s != ""] # Saco líneas en blanco
  splited <- strsplit(s, "#") # Corta las líneas en los #
  for (i in 1:length(s)) {
    s[i] <- splited[[i]][1]
  }
  gsub(" +$", "", s) # Borra espacios al final de las líneas
}
objetos <- c(objetos, "sacarComentarios")

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
objetos <- c(objetos, "reload")


## ======================================================================= ##

### REP 2

cl <- function() {
  cal <- rpois(260 + sample(20, 1), 6)
  cal[cal > 12] <- 12
  cal[cal == 0] <- 1
  cal
}
objetos <- c(objetos, "cl")


gn <- function(cal)
  sample(c('V', 'M'), length(cal), replace=TRUE)
objetos <- c(objetos, "gn")


ct <- function(cal) {
  n <- length(cal)
  out <- character(n)
  out[cal <= 3] <- 'A'
  out[3 < cal & cal <= 6] <- 'B'
  out[6 < cal & cal <= 9] <- 'C'
  out[9 < cal] <- 'D'
  out
}
objetos <- c(objetos, "ct")


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
objetos <- c(objetos, "Print.listaCalif")


## ======================================================================= ##

### REP 3

.usainc <- function() {
  load('datos')
  n <- is.na(usa.inc$Analf)
  #   usa.inc$Analf[n] <- outAnalf + sample(c(-0.1, 0.1), sum(n), replace = TRUE)
  usa.inc$Analf[n] <- outAnalf + round(runif(sum(n), -0.1, 0.1), 1)
  write.csv2(usa.inc, file = 'usa-extra.csv')
  warning("Como parte de la correción, se han cambiado algunos valores del archivo 'usa-extra.csv'\n", call. = FALSE)
}
objetos <- c(objetos, ".usainc")

.z <- function(x) (x - mean(x, na.rm = T)) / sd(x, na.rm = T)
est <- function(x) .z(x)
objetos <- c(objetos, ".z", "est")

# save(objetos, file = "auxiliares.rda")


