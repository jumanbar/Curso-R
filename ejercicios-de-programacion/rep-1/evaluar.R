evaluar <- function() {
  #
  cat("\nCargando funciones y datos para la corrección...\n\n")
  load('datos')
  nej <- length(corregir)
  hasmsj <- logical(nej)
  arc <- dir()
  #
  
  if (!all(f <- esperados %in% arc)) {
    cat("\n Faltan los siguientes archivos en el directorio de trabajo:\n")
    cat(paste("   - ", esperados[!f], '\n', sep=''), '\n', sep='')    
    cat(" ¡La corrección no puede continuar hasta que no se solucione este problema!\n\n")
    return('bye!')
  }

  ### Elección del archivo (y por lo tanto el ejercicio) a corregir
  s <- menu(c(paste('Ej. (', ejnum, "): ", corregir, sep=""), 'Todos'),
             title="Elija el archivo que desea corregir:")
  msj <- NULL
  if (s > nej) {
    for (i in 1:nej) {
      r <- try(do.call(paste('cor', ejnum[i], sep=''), list(a=1)), silent=TRUE)
      if (is.character(r)) {
        msj <- c(msj, r)
        hasmsj[i] <- TRUE
        notas$Nota[i] <- 0
      } else {
        notas$Nota[i] <- r
      }
    }
  } else {
    r <- try(do.call(paste('cor', ejnum[s], sep=''), list(a=1)), silent=TRUE)
    if (is.character(r)) {
      msj <- c(msj, r)
      hasmsj[s] <- TRUE
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
  if (!is.null(msj)) {
    msjEjNum <- ejnum[hasmsj]
    msjArch  <- corregir[hasmsj]
    cat("Se generaron los siguientes mensajes de error:\n")
    for (i in 1:sum(hasmsj)) {
      cat('\n==>> Al corregir el ej. ', msjEjNum[i], ', archivo ', msjArch[i], ':\n', sep='')
      cat(msj[i])
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
    cat('El script "', s, '" tiene algún error, lo siento :(\n\n', sep='')
  }
}

cat("\n Archivo de codigo fuente cargado correctamente\n\n")
