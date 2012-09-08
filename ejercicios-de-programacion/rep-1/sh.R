sh <- function(x) {
  n <- table(x)
  N <- sum(n)
  p <- n / N
  H <- - sum(p * log(p, 2))
  H
}
