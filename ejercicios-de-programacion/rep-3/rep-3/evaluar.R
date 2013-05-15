
if (tolower(getOption("encoding")) != "utf-8") {
  msjenc <- c("\n¡El encoding actual no es UTF-8!\n",
              "lo cual es un problema con tildes y enies,",
              "ajuste su configuracion con el comando:\n",
              "   options(encoding = 'utf-8')\n")
  msjenc <- paste(msjenc, "\n", sep = "")
  stop(msjenc, call. = FALSE) 
}

evaluar <- function(e) {
  #
  w <- try(load('datos'), silent = TRUE)
  if (class(w) == "try-error") {
    mensaje <- c("Tal vez ud. no esté trabajando en el directorio correcto,", 
                 "   su directorio de trabajo actual es:",
                 paste("   '", getwd(), "'", sep=""),
                 "   en caso necesario cambie de directorio con setwd, ej.:",
                 "   >>   setwd('~/CursoR/rep-X')",
                 "   (note que el camino a su carpeta puede ser diferente)")
    warning(paste(mensaje, "\n", sep=""), call. = FALSE)
    stop("evaluar no pudo encontrar el archivo 'datos', no se puede continuar ...", call. = FALSE)
  }
  nej <- length(corregir)
  #   hasmsj <- logical(nej)
  arc <- dir()
  #
  if (tolower(getOption("encoding")) != "utf-8") {
    mensaje <- c("\n¡El encoding actual no es UTF-8!\n",
                 "lo cual es un problema con tildes y enies,",
                 "ajuste su configuracion con el comando:\n",
                 "   options(encoding = 'utf-8')\n",
                 "y luego vuelva a ejecutar:\n",
                 "   source('evaluar.R')\n")
    mensaje <- paste(mensaje, "\n", sep = "")
    warning(mensaje, call. = FALSE) 
  }
  
  if (!all(f <- esperados %in% arc)) {
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
      msj.i <- paste("| ", msj[hasmsj][[1]])
      cat(msj.i, sep='')
    }
  }
  cat('\n==============================\n')

  cat('\nTotal hasta ahora:', sum(bien), 'de', oblg, 'ejercicios; NOTA:', round(notaActual), '% \n\n')
  
  if (sum(bien) == nej)
    cat("¡¡Felicitaciones, ha alcanzado la nota máxima!!\n")
  
#   print.data.frame(notas, row.names=FALSE, right=FALSE)
#   cat('\n')
  codigo <- lapply(corregir, readLines)
  names(codigo) <- corregir
  write.csv2(notas, file='notas.csv', row.names=FALSE)
  save(list=guardar, file='datos')
}

### FUNCIÓN PARA VER LAS NOTAS
verNotas <- function()
  print.data.frame(read.csv2('notas.csv'), row.names=FALSE, right=FALSE)

### FUNCIÓN DE FEEDBACK
feedback <- function(r, s) {
  if (!is.character(r) && r > 0) {
    cat('El script "', s, '" está perfecto, ¡Buen trabajo!\n\n', sep='')
  } else {
    cat('El script "', s, '" tiene algún error, lo siento :-(
    -> Verifique que su solución sea genérica y que sigue
       todas las consignas de la letra. \n\n', sep='')
  }
}

cat("\n Archivo de codigo fuente cargado correctamente\n\n")

