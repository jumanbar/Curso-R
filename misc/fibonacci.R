fibonacci <- function(n) {
  out <- numeric(n)
  out[2] <- 1
  for (i in 3:n) {
    out[i] <- out[i - 1] + out[i - 2]
  }
  out
}


fibonacci <- function(n, init = 0:1) {
  out <- numeric(n)
  out[1:2] <- init
  for (i in 3:n) {
    out[i] <- out[i - 1] + out[i - 2]
  }
  out
}
