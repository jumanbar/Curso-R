############ FUNCIÓN leib #########################
## Correr estos comandos para que leib quede definida en nuestra área de trabajo
leib <- function(n) {
## Serie de Leibniz
  x <- 0:n
  imp <- 2 * x + 1
  inv <- 1 / imp
  elementos <- inv * (- 1) ^ x
  sum(elementos)
}
###################################################

############ FUNCIÓN estimaPi #####################
estimaPi <- function(n=5, error=0.01, show=TRUE) { ## linea 13
## Estima el valor de pi usando la serie de Leibniz
  dif <- Inf
  out <- NULL
  while(dif > error) {
    x <- leib(n) * 4
    dif <- abs(x - pi)
    out <- c(out, dif)
    n <- n + 1
  }
  if(show) plot(out)
  list(estimacion=x, nfinal=n - 1, error=error, dif=out)
} ## linea 26
###################################################
