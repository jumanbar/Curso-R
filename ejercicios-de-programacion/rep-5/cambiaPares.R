cambiaPares <- functon(x, subs=0) {
  # Cambia los valores originales de "x" por los valores
  # de "subs" en las posiciones pares.
  len <- length(x)
  pares <- seq(1, len, by=2)
  x[pares,] <- sub
  return(x)
}
