enviar <- function() {
  # Esta función debería servir 
  esperados <- c("fibonacci.R", "funcion-fibonacci.R")
  arch <- dir()
  if (!all(esperados %in% arch))
    stop("Faltan archivos en el directorio de trabajo. Verifique esta situación o
         descomprima nuevamente el archivo 'ejercicio4.zip'.")
}

cat("\n¡Función 'enviar' cargada correctamente!\n")
