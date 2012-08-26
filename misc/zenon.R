zenon <- function(n) {
  s <- (1 / 2) ** (1:n)
  plot(cumsum(s), type="o", xlab="n", ylab=expression(Z[n]))
  z <- sum(s)
  z
}

geom <- function(z, n) {
  s <- (1 / z) ** (0:n)
  plot(cumsum(s), type="o", xlab="n", ylab=expression(S[n]))
  out <- sum(s)
  out
}
