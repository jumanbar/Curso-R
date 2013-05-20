
objetos <- NULL

### GENERALES

mkmsj <- function(msj.base = "", obs, esp) {
  # msj.base: mensaje indicando en qué objeto está el error,
  #           ej.: El or XXX no coincide con lo esperado
  #           nota: se agrega una coma y un \n al final.
  # obs, esp: ores observado y esperado respect.
  if (obs == esp)
    return(TRUE)
  output <- c(obs, esp)
  output <- c(as.character(obs), as.character(esp))
  names(output) <- c("Valor observado", "Valor esperado")
  output <- capture.output(print(output))
  mensaje <- c(paste(msj.base, ",\n", sep=""),
               "la diferencia observada es la siguiente:\n\n", 
               paste("  ", output, "\n", sep = ""))
  mensaje
}
objetos <- c(objetos, "mkmsj")


mkmsj.v <- function(msj.base = "", vec.obs, vec.esp, tol = 1e-8) {
  # msj.base: mensaje indicando en qué objeto está el error,
  #           ej.: El vector XXX no coincide con lo esperado
  #           nota: se agrega una coma y un \n al final.
  # vec.obs, vec.esp: vectores observado y esperado respect.
  donde <- which(vec.obs != vec.esp)
  dif <- rep(NA, length(donde))
  tabla <- cbind(vec.obs[donde], vec.esp[donde])
  if (is.factor(vec.obs))
    tabla <- cbind(as.character(vec.obs[donde]), as.character(vec.esp[donde]))
  colnames(tabla) <- c("Valor observado", "Valor esperado")
  if (is.null(names(vec.obs)))
    rownames(tabla) <- paste("Posición ", donde, ":", sep = "")
  if (is.numeric(vec.obs)) {
    dif <- abs(tabla[,1] - tabla[,2])
    tabla <- cbind(tabla, Dif. = dif)
    tabla <- tabla[dif > tol, , drop=FALSE]
    if (nrow(tabla) == 0)
      return(FALSE)
  }
  if (c1 <- nrow(tabla) > 10)
    tabla <- tabla[1:10,]
  op <- options(digits = 10)
  output <- capture.output(print(tabla))
  options(op)
  if (msj.base != "")
    msj.base <- paste(msj.base, ",\n", sep="")
  mensaje <- c(msj.base,
               "las diferencias observadas son las siguientes:\n\n", 
               paste("  ", output, "\n", sep = ""))
  if (c1)
    mensaje <- c(mensaje, "(se muestran sólo las primeras 10 diferencias)\n")
  mensaje
}
objetos <- c(objetos, "mkmsj.v")


mkmsj.m <- function(msj.base = "", m.obs, m.esp, tol = 1e-8) {
  # msj.base: mensaje indicando en qué objeto está el error,
  #           ej.: La matriz XXX no coincide con lo esperado
  #           nota: se agrega una coma y un \n al final.
  # m.obs, m.esp: matrices observadas y esperadas respect.
  donde <- which(m.obs != m.esp, arr.ind = TRUE)
  dif <- rep(NA, nrow(donde))
  tabla <- cbind(donde, m.obs[donde], m.esp[donde], dif)
  colnames(tabla) <- c("Fila", "Columna", "Valor observado", "Valor esperado", "Dif.")
  if (is.numeric(m.obs)) {
    dif <- abs(tabla[,3] - tabla[,4])
    tabla[,5] <- dif
    tabla <- tabla[dif > tol, , drop=FALSE]
    if (nrow(tabla) == 0)
      return(FALSE)
  } else {
    tabla <- tabla[,-5]
  }
  if (c1 <- nrow(tabla) > 10)
    tabla <- tabla[1:10,]
  op <- options(digits = 10)
  output <- capture.output(print(tabla))
  options(op)
  if (msj.base != "")
    msj.base <- paste(msj.base, ",\n", sep="")
  mensaje <- c(msj.base,
               "las diferencias observadas son las siguientes:\n\n", 
               paste("  ", output, "\n", sep = ""))
  if (c1)
    mensaje <- c(mensaje, "(se muestran sólo las primeras 10 diferencias)\n")
  mensaje
}
objetos <- c(objetos, "mkmsj.m")


mkmsj.df <- function(msj.base = "", df.obs, df.esp, tol = 1e-8) {
  # msj.base: mensaje indicando en qué objeto está el error,
  #           ej.: La data.frame XXX no coincide con lo esperado
  #           nota: se agrega una coma y un \n al final.
  # df.obs, df.esp: data.frames observadas y esperadas respect.
  donde <- which(df.obs != df.esp, arr.ind = TRUE)
  dif <- rep(NA, nrow(donde))
  tabla <- cbind(donde, df.obs[donde], df.esp[donde], dif)
  tabla[,2] <- colnames(df.obs)[donde[,2]]
  colnames(tabla) <- c("Fila", "Columna", "Valor observado", "Valor esperado", "Dif.")
  num <- sapply(df.obs, is.numeric)
  dnum <- num[donde[,2]]
  if (any(dnum)) {
    drow <- donde[dnum, 1]
    dcol <- donde[dnum, 2]
    num.obs <- numeric(sum(dnum))
    num.esp <- numeric(sum(dnum))
    for (i in 1:sum(dnum)) {
      num.obs[i] <- df.obs[drow[i], dcol[i]]
      num.esp[i] <- df.esp[drow[i], dcol[i]]
    }
    dif[dnum] <- abs(num.obs - num.esp)
    tabla[dnum,3] <- num.obs 
    tabla[dnum,4] <- num.esp 
    tabla[,5] <- dif
    sel <- dif > tol
    if (!any(sel))
      tabla <- tabla[,-5]
    sel[is.na(sel)] <- TRUE
    tabla <- tabla[sel, , drop=FALSE]
    if (nrow(tabla) == 0)
      return(FALSE)
  }
  if (c1 <- nrow(tabla) > 10)
    tabla <- tabla[1:10,]
  op <- options(digits = 10)
  output <- capture.output(print(tabla))
  options(op)
  if (msj.base != "")
    msj.base <- paste(msj.base, ",\n", sep="")
  mensaje <- c(msj.base,
               "las diferencias observadas son las siguientes:\n\n", 
               paste("  ", output, "\n", sep = ""))
  if (c1)
    mensaje <- c(mensaje, "(se muestran sólo las primeras 10 diferencias)\n")
  mensaje
}
objetos <- c(objetos, "mkmsj.df")


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

sacar.comentarios <- function(s) {
  # s: vector character
  # Saca comentarios en un vector character, el cual se supone
  # que contiene líneas de código R (cada elemento de s = una
  # línea de código).
  # i.e.: saca todo lo que viene después del # en cada línea
  s <- gsub("^ +", "", s) # Saca espacios en blanco iniciales
  s <- s[s != ""] # Saco líneas en blanco
  splited <- strsplit(s, "#") # Corta las líneas en los #
  for (i in 1:length(s)) {
    s[i] <- splited[[i]][1]
  }
  s <- s[s != ""] # Saco líneas en blanco
  gsub(" +$", "", s) # Borra espacios al final de las líneas
}
objetos <- c(objetos, "sacar.comentarios")

cut.script <- function(arch, cut.str = "#===") {
  # arch: nombre del script de R (= 1 ejercicio)
  # salida: el código del estudiante, sin comentarios,
  #         en un vector character.
  arch <- readLines(arch)
  if (!is.na(cut.str) || !is.null(cut.str) || cut.str != "") {
    gr <- grep(cut.str, arch, useBytes = TRUE)
    arch <- arch[gr[1]:gr[2]]
  }
  arch <- sacar.comentarios(arch)
  #   tmp <- tempfile()
  #   writeLines(arch, tmp)
  #   return(tmp)
  return(arch)
}
objetos <- c(objetos, 'cut.script')


### FUNCIÓN DE FEEDBACK
# Trabaja con evaluar
feedback <- function(r, s) {
  if (!is.character(r) && r > 0) {
    cat('El script "', s, '" está perfecto, ¡Buen trabajo!\n\n', sep='')
  } else {
    cat('El script "', s, '" tiene algún error, lo siento :-(
    -> Verifique que su solución sea genérica y que sigue
       todas las consignas de la letra. \n\n', sep='')
  }
}
objetos <- c(objetos, 'feedback')


print.codigo <- function(x) {
  # x es una lista cuyos elementos
  # son vectores character:
  #   líneas de código
  # x[[i]] corresponde al iésimo ejercicio.
  for (i in 1:length(x)) {
    cat("\nEjercicio ", i, ", ", names(x)[i], ":\n", sep="")
    out <- paste("  ", x[[i]], "\n")
    cat(out, sep="")
  }
}
objetos <- c(objetos, 'print.codigo')


### RELOAD

# Hay que probar esta última versión

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
  arch.datos <- readLines('datos.R')
  linea.final <- grep('### REINICIAR', arch.datos, useBytes = TRUE)[2]
  arch.datos <- arch.datos[1:(linea.final - 1)]
  eval(parse(text = arch.datos))
  #   tmp <- tempfile()
  #   writeLines(arch.datos, tmp)
  #   source(tmp)
  #   unlink(tmp)
  out <- file.copy('datos', rdir, overwrite = TRUE)
}
objetos <- c(objetos, "reload")


### CHEQUEAR ÚLTIMA VERSIÓN DE "DATOS":

# Para implementar a futuro.
# Todavía no puesta a prueba, pero en principio sirve.

# Código tomado de: http://stackoverflow.com/questions/16578397/check-if-there-is-a-newer-version-of-my-local-file-in-github-with-r/16583492#16583492
# Gracias Dieter Menne por la colaboración! (http://stackoverflow.com/users/229794/dieter-menne)

check.datos.date <- function() {
  # Se supone que se debe ejecutar desde la carpeta del repartido... en un futuro estaría bueno que no sea necesario,
  # sobre todo si se hace un paquete del curso.
  repdir <- basename(getwd())
  if (!grepl("rep-[0-9]", repdir)) {
    warning("No se pudo chequear la fecha del archivo datos, debido a que no se encuentra en el directorio de trabajo del repartido")
    return(FALSE)
  }
  cat("Repartido actual:", gsub("[[:alpha:][:punct:]]", "", repdir), "\n")
  inst.pack <- rownames(installed.packages())
  if (!grepl("RCurl", inst.pack))
    install.packages("RCurl", repo = "http://mirror.fcaglp.unlp.edu.ar/CRAN/")
  if (!grepl("rjson", inst.pack))
    install.packages("rjson", repo = "http://mirror.fcaglp.unlp.edu.ar/CRAN/")

  require(RCurl)
  require(rjson)

  #   repdir <- "rep-2" # De prueba, comentar después
  destination <- "datos" # Debe ser en el directorio actual
  repo <- "https://api.github.com/repos/jumanbar/Curso-R/"
  path <- paste0("ejercicios-de-programacion/", repdir, "/", destination)
  myopts <- curlOptions(useragent = "Mozilla/5.0", ssl.verifypeer = FALSE)

  d <- fromJSON(getURL(paste0(repo, "commits?path=", path), 
                      useragent = "Mozilla/5.0", ssl.verifypeer = FALSE))[[1]]
  #   gitDate  <- as.POSIXct(d$commit$author$date)
  git.date <- paste(gsub("Z", "", strsplit(d$commit$author$date, "T")[[1]]), collapse = " ")
  #   git.date <- gsub(":[[:digit:][:punct:]]+$", "", git.date)
  git.date <- gsub(":[[:digit:]]+$", "", git.date)
  load("datos")
  dif <- difftime(git.date, rep.date, units = "hours")
  dif2 <- difftime(git.date, rep.date)
  if (dif <= 0)
    cat("No hay versión nueva disponible del archivo 'datos'\n")
  if (dif > 0.5) {
    cat("Su versión de 'datos' es", dif2, attr(dif2, "units"), "más vieja que la disponible para bajar\n")
    cat("==>> Se recomienda descargar una nueva versión del archivo 'datos'\n")
  }
  if (dif > 0 && dif <= 0.5) {
    cat("Su versión de 'datos' es", dif2, attr(dif2, "units"), "más vieja que la disponible para bajar\n")
    warning("Es probable que se trate de la misma versión, por ser tan poca la diferencia de tiempo")
  }

  s <- menu(c("Si", "No"), title="¿Desea descargar el archivo?")
  if (s == 1) {
    browseURL(url.desc)
    cat("Recuerde guardarlo en la carpeta del repartido:\n>>  ", getwd(), "\n")
    cat("sustituyendo al archivo 'datos' actual\n")
  }

  # Esto sería para bajar la nueva versión, todavía no funciona...
  #   MustDownload <- !file.exists(destination) |  file.info(destination)$mtime > gitDate
  #   if (MustDownload){
  #     url <- d$url
  #     commit = fromJSON(getURL(url, .opts=myopts))
  #     files = unlist(lapply(commit$files,"[[","filename"))
  #     rawfile = commit$files[[which(files==path)]]$raw_url
  #     download.file(rawfile,destination,quiet=TRUE)
  #     Sys.setFileTime(destination,gitDate)
  #     cat("Nuevo archivo 'datos' descargado")
  #   }
  return(TRUE)
}



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


