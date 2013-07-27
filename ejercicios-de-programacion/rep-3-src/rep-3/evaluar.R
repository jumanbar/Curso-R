
# if (tolower(getOption("encoding")) != "utf-8") {
#   msjenc <- c("\n¡El encoding actual no es UTF-8!\n",
#               "lo cual es un problema con tildes y enies,",
#               "ajuste su configuracion con el comando:\n",
#               "   options(encoding = 'utf-8')\n")
#   msjenc <- paste(msjenc, "\n", sep = "")
#   stop(msjenc, call. = FALSE) 
# }
cat("Los siguientes caracteres deben ser vocales con tilde:\n",
    "  á - é - í - ó - ú\n",
    "Si no se ven correctamente corra el siguiente comando:\n",
    "  source('evaluar.R', encoding = 'UTF-8')\n\n", sep = "")

evaluar <- function(e) {
  #
  arc <- dir()
  if (any(grepl("datos.", arc))) {
    n <- grep("datos.", arc)
    file.rename(arc[n], "datos")
    warning("Se cambió el nombre del archivo '", arc[n], "' por 'datos'")
  }
  if (!file.exists("datos")) {
    #     if (file.exists("datos.txt")) {
    # Por si existe un archivo datos.txt o cualquier datos.XXX
    mensaje <- c("Tal vez ud. no esté trabajando en el directorio correcto,", 
                 "   su directorio de trabajo actual es:",
                 paste("   '", getwd(), "'", sep=""),
                 "   en caso necesario cambie de directorio con setwd, ej.:",
                 "   >>   setwd('~/CursoR/rep-X')",
                 "   (note que el camino a su carpeta puede ser diferente)")
    warning(paste(mensaje, "\n", sep=""), call. = FALSE)
    stop("evaluar no pudo encontrar el archivo 'datos', no se puede continuar ...", call. = FALSE)
  }
  load("datos")
  nej <- length(corregir)
  #   hasmsj <- logical(nej)
  #
  #   if (tolower(getOption("encoding")) != "utf-8") {
  #     mensaje <- c("\n¡El encoding actual no es UTF-8!\n",
  #                  "lo cual es un problema con tildes y enies,",
  #                  "ajuste su configuracion con el comando:\n",
  #                  "   options(encoding = 'utf-8')\n",
  #                  "y luego vuelva a ejecutar:\n",
  #                  "   source('evaluar.R')\n")
  #     mensaje <- paste(mensaje, "\n", sep = "")
  #     warning(mensaje, call. = FALSE) 
  #   }
  
  arc <- dir()
  if (!all(f <- esperados %in% arc)) { # Es lo mismo poner f <- file.exists(esperados)
    mensaje <- c("  Tal vez ud. no esté trabajando en el directorio correcto,", 
                 "  utilice setwd para seleccionar la carpeta del repartido, ej.:",
                 "  >>   setwd('~/CursoR/rep-X')",
                 "  (note que el camino a su carpeta puede ser diferente)")
    warning(paste(mensaje, "\n", sep=""), call. = FALSE)
    cat("\n Faltan los siguientes archivos en el wd actual:\n")
    cat(paste("   - ", esperados[!f], '\n', sep=''), '\n', sep='')
    cat(" El wd actual es:\n  '", getwd(), "'\n\n", sep="")
    stop("\n  ¡la corrección no puede continuar hasta que no se solucione este problema!", call. = FALSE)
  }

  ### Elección del archivo (y por lo tanto el ejercicio) a corregir
  if (!missing(e)) {
    if (length(e) > 1)
      stop('Seleccione un único ejercicio o todos juntos (i.e.: ', nej + 1, ').')
    s <- e
  } else {
    s <- menu(c(paste('Ej. (', ejnum, "): ", corregir, sep=""), 'Todos'),
              title="Elija el archivo que desea corregir:")
  }
  msj <- vector("list", nej)
  if (s > nej) {
    for (i in 1:nej) {
      r <- try(corAll[[i]](), silent = TRUE)
      if (is.character(r) || is.na(r)) {
        msj[[i]] <- r
        #         hasmsj[i] <- TRUE
        notas$Nota[i] <- 0
      } else {
        notas$Nota[i] <- r
      }
    }
  } else {
    r <- try(corAll[[s]](), silent = TRUE)
    if (is.character(r) || is.na(r)) {
      msj[[s]] <- r
      #       hasmsj[s] <- TRUE
      notas$Nota[s] <- 0
    } else {
      notas$Nota[s] <- r
    }
  }

  ### Feedback general:
  cat('\n==========RESULTADOS==========\n\n')
  bien <- notas$Nota[- nrow(notas)] > 0
  notaActual <- 100 * sum(bien) / oblg
  notas$Nota[nrow(notas)] <- round(notaActual)
  # Nota: oblg es el número de ejercicios obligatorios. Si hay optativos, se
  # suman sus valores y entonces se puede llegar a porcentajes mayores a 100.
  if (s <= nej) {
    feedback(r, corregir[s])
  }
  correctos <- ejnum[bien]
  cat('Ejercicios correctos:\n\n==>> ')
  if (sum(bien) > 0) {
    cat(correctos, sep=', ')
  } else {
    cat('Ninguno por ahora')
  }
  cat('\n\n')
  hasmsj <- !sapply(msj, is.null)
  if (any(hasmsj)) {
    msjEjNum <- ejnum[hasmsj]
    msjArch  <- corregir[hasmsj]
    cat("Se generaron los siguientes mensajes de error:\n")
    for (i in 1:sum(hasmsj)) {
      cat('\n* Al corregir el ej. ', msjEjNum[i], ', archivo ', msjArch[i], ':\n', sep='')
      msj.i <- paste("| ", msj[hasmsj][[i]])
      cat(msj.i, sep='')
    }
  }
  cat('\n==============================\n')

  cat('\nTotal hasta ahora:', sum(bien), 'de', oblg, 'ejercicios; NOTA:', round(notaActual), '% \n\n')
  
  if (sum(bien) == nej)
    cat("¡¡Felicitaciones, ha alcanzado la nota máxima!!\n")
  
#   print.data.frame(notas, row.names=FALSE, right=FALSE)
#   cat('\n')
#   codigo <- lapply(corregir, readLines)
  codigo <- lapply(corregir, cut.script)
  names(codigo) <- corregir
  class(codigo) <- "codigo"
  write.csv2(notas, file='notas.csv', row.names=FALSE)
  save(list=guardar, file='datos')
}

### FUNCIÓN PARA VER LAS NOTAS
verNotas <- function()
  print.data.frame(read.csv2('notas.csv'), row.names=FALSE, right=FALSE)

# cat("\n Archivo de código fuente cargado correctamente\n\n")

