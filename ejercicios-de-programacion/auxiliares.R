### OBJETOS
# Es una lista de vectores character con los nombres de objetos necesarios
# para diferentes tareas:
#   generales: tareas de corrección comunes a todos los repartidos.
#   rep.X: tareas de corrección particulares del repartido X. A veces simplemente
#          se trata de construir objetos para guardarlos (e.g.: ej2.RData)
objetos <- vector("list")
objetos$generales <- NULL
objetos$rep.1 <- NULL
objetos$rep.2 <- NULL
objetos$rep.3 <- NULL
objetos$rep.4 <- NULL
objetos$rep.5 <- NULL
objetos$rep.6 <- NULL



### GENERALES

# Las funciones mkmsj
source("../mkmsj.R") # Se supone que esto es llamado desde una carpeta rep-X
objetos$generales <- c(objetos$generales, "mksmsj", "mksmsj.v", "mksmsj.m", "mksmsj.df")

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
objetos$generales <- c(objetos$generales, "objnames")

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
objetos$generales <- c(objetos$generales, "sacar.comentarios")

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
objetos$generales <- c(objetos$generales, 'cut.script')


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
objetos$generales <- c(objetos$generales, 'feedback')

# PRINT.CODIGO
# Función que ayuda a ver de forma "más linda" el código de los estudiantes
# en el momento de corregir.
print.codigo <- function(x) {
  # class(x) <- "codigo"
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
# objetos$generales$print.codigo <- print.codigo
objetos$generales <- c(objetos$generales, 'print.codigo')


### RELOAD
# Para facilitar el hacer pruebas en cambios en los correctores
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
objetos$generales <- c(objetos$generales, "reload")


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
objetos$generales <- c(objetos$generales, "check.datos.date")



## ======================================================================= ##

### REP 2

cl <- function() {
  cal <- rpois(260 + sample(20, 1), 6)
  cal[cal > 12] <- 12
  cal[cal == 0] <- 1
  cal
}
objetos$rep.2 <- c(objetos$rep.2, "cl")


gn <- function(cal)
  sample(c('V', 'M'), length(cal), replace=TRUE)
objetos$rep.2 <- c(objetos$rep.2, "gn")


ct <- function(cal) {
  n <- length(cal)
  out <- character(n)
  out[cal <= 3] <- 'A'
  out[3 < cal & cal <= 6] <- 'B'
  out[6 < cal & cal <= 9] <- 'C'
  out[9 < cal] <- 'D'
  out
}
objetos$rep.2 <- c(objetos$rep.2, "ct")


plf <- function(x) {
  # print.listaCalif
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
objetos$rep.2 <- c(objetos$rep.2, "plc")

### ARCHIVO AUXILIAR: ej2.RData

cal <- cl()
gen <- gn(cal)
ctg <- ct(cal)
datos.calif <- data.frame(nota = cal,
													genero = gen,
													franja = ctg)
datos.calif <- datos.calif[order(cal),]
conteo <- table(ctg)
p.apr <- 100 * sum(cal >= 5) / length(cal)
v <- cal[gen == "V"]
m <- cal[gen == "M"]
p.apr.v <- 100 * sum(v >= 5) / length(v)
p.apr.m <- 100 * sum(m >= 5) / length(m)
analisis.calif <- list(tabla = datos.calif,
											 conteo = table(ctg),
											 aprob = list(atot = p.apr,
																		avar = p.apr.v,
																		amuj = p.apr.m))
save(cal, gen, ctg, p.apr, p.apr.v, p.apr.m, datos.calif, conteo, analisis.calif,
		 file = "ej2.RData")

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
objetos$rep.3 <- c(objetos$rep.3, ".usainc")

.z <- function(x) (x - mean(x, na.rm = T)) / sd(x, na.rm = T)
est <- function(x) .z(x)
objetos$rep.3 <- c(objetos$rep.3, ".z", "est")

# save(objetos, file = "auxiliares.rda")


