evaluar <- function() {
  #
  cat("\nCargando funciones y datos para la corrección...\n\n")
  load('datos')
  arch <- dir()
  #
  
  if (!all(f <- esperados %in% arch)) {
    cat("\n Faltan los siguientes archivos en el directorio de trabajo:\n")
    cat(paste("   - ", esperados[!f], '\n', sep=''), '\n', sep='')    
    cat(" ¡La corrección no puede continuar hasta que no se solucione este problema!\n\n")
    return('bye!')
  }

  ### Elección del archivo (y por lo tanto el ejercicio) a corregir
  s  <- menu(corregir, title="Elija los archivos que desea corregir:")
  r <- do.call(paste('cor_', gsub('.R', '', corregir[s]), sep=''), list(a=1))
  notas$Nota[s] <- r

  ### Feedback:
  cat('\n==========RESULTADOS==========\n\n')
  feedback(r, corregir[s])
  notaActual <- 100 * sum(notas$Nota[- nrow(notas)]) / oblg
  notas$Nota[nrow(notas)] <- notaActual
  # Nota: oblg es el número de ejercicios obligatorios. Si hay optativos, se
  # suman sus valores y entonces se puede llegar a porcentajes mayores a 100.
  cat('\n==============================\n')

  cat('\nNota total hasta ahora:\n\n')
  
  print.data.frame(notas, row.names=FALSE, right=FALSE)
  cat('\n')

  write.csv2(notas, file='notas.csv', row.names=FALSE)
  save(list=guardar, file='datos')
}

### FUNCIÓN PARA VER LAS NOTAS
verNotas <- function()
  print.data.frame(read.csv2('notas.csv'), row.names=FALSE, right=FALSE)

### FUNCIÓN DE FEEDBACK
feedback <- function(r, s) {
  if (r) {
    cat('El script ', s, ': está perfecto, ¡Buen trabajo!\n', sep='')
  } else {
    cat('El script ', s, ': tiene algún error, lo sientimos :(\n', sep='')
  }
}

cat("\n Código fuente cargado correctamente\n\n")
