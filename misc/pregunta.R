f <- function() {
  i <- 2
  j <- 0
  while (i %% 12 != 0) {
    if (j > 0)
      cat("incorrecto, lo siento, intente de nuevo ...\n\n")

    cat("Escriba un número múltiplo de 12: ")
    i <- readLines(n = 1)
    i <- as.numeric(i)
    j <- j + 1
  }
  cat("¡Muy bien!\n")
}

