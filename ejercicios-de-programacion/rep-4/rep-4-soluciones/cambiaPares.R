cambiaPares.R <- function(x, subs = 0) {
  len <- length(x)
  pares <- seq(2, len, by=2)
  x[pares] <- subs
  return(x)
}
