
cor1 <- function() {
  # Cargar datos y script
  load('datos')
  arch <- cut.script("1-varianza.R")
  parsed <- parse(text = arch)

  # Generación de datos
  semilla <- sample(1000, 1)
  cat(">> Iniciando una nueva semilla:\n")
  cat(">> set.seed(", semilla,") ...\n", sep = "")
  set.seed(semilla)
  cat(">> Creando un nuevo vector x para la corrección:\n")
  cat(">> x <- rnorm(sample(10, 20, 1))\n")
  x <- rnorm(sample(10, 20, 1))

  cat(">> el nuevo x tiene", length(x), "elementos; su varianza es", var(x), "\n")

  # Evaluación de objetos: x_mean, s, out
  eval(parsed)
  x_m2 <- sum(x) / length(x)
  s2   <- (x - x_m2) ** 2
  out2 <- sum(s2) / (length(x) - 1)
  tol  <- .Machine$double.eps ^ 0.5

  if (abs(x_mean - x_m2) > tol)
    stop("el valor de x_mean obtenido no es el esperado", call. = FALSE)
  cat("valor de x_mean ... OK\n")

  if (length(s) != length(s2))
    stop(mkmsj("la longitud del vector s no es la esperada", length(s), length(s2)), call. = FALSE)
  cat("longitud de s ... OK\n")

  if (any(abs(s - s2) > tol))
    stop(mkmsj.v("los valores del s obtenido no son los esperados", s, s2), call. = FALSE)
  cat("valores de s ... OK\n")

  if (abs(out - (sum(s2) / length(x))) < tol)
    warning("ej. 1: es posible que falte un '- 1' en el denominador", call. = FALSE)

  if (abs(out - (sum(s2) / length(x) - 1)) < tol)
    warning("ej. 1: no es lo mismo 'a / (b + c)' que 'a / b + c' ...", call. = FALSE)

  if (abs(out - ((1 / length(x) - 1) * sum(s2))) < tol)
    warning("ej. 1: no es lo mismo 'a / (b + c)' que 'a / b + c' ...", call. = FALSE)

  if (abs(out - out2) > tol)
    stop(mkmsj("el valor de out obtenido no es el esperado", out, out2), call. = FALSE)
  cat("valor de out ... OK\n")

  TRUE
}

cor2 <- function() {
  # Cargar datos y script
  load('datos')
  arch <- cut.script("2-zenon.R")
  parsed <- parse(text = arch)

  # Evaluación de objetos: e, s, out
  eval(parsed)
  e2 <- 1:n
  s2 <- 1 / (2 ** e)
  out2 <- sum(s2)
  tol  <- .Machine$double.eps ^ 0.5

  if (n < 20) {
		warning("ej. 2: recuerde que el n es el mínimo tal que '1 - out < 1e-6'", call. = FALSE)
    stop("el valor de n obtenido es muy bajo", call. = FALSE)
	}

  if (n > 20) {
		warning("ej. 2: recuerde que el n es el mínimo tal que '1 - out < 1e-6'", call. = FALSE)
    stop("el valor de n obtenido es muy alto", call. = FALSE)
  }
  cat("valor de n ... OK\n")

  if (length(e) != n) {
    if (e[1] == 0)
      warning("ej. 2: ¡el primer valor de i debe ser 1, no 0!", call. = FALSE)
    stop(mkmsj("la longitud de e es distinta a n", length(e), n), call. = FALSE)
  }
  cat("longitud de e ... OK\n")

  if (any(abs(e - e2) > tol))
    stop(mkmsj.v("los valores del e obtenido no son los esperados", e, e2), call. = FALSE)
  cat("valores de e ... OK\n")

  if (length(s) != n)
    stop(mkmsj("la longitud de s es distinta a n", length(e), n), call. = FALSE)
  cat("longitud de s ... OK\n")

  if (any(abs(s - s2) > tol))
    stop(mkmsj.v("los valores del s obtenido no son los esperados", s, s2), call. = FALSE)
  cat("valores de s ... OK\n")

  if (any(abs(out - out2) > tol))
    stop(mkmsj("el valor del out obtenido no es el esperado", s, s2), call. = FALSE)
  cat("valor de out ... OK\n")

  TRUE
}

cor3 <- function() {
  # Cargar datos y script
  load('datos')
  arch <- cut.script("3-extra-dist.R")
  parsed <- parse(text = arch)

  # Generación de datos
  # Generación de datos
  semilla <- sample(1000, 1)
  cat(">> Iniciando una nueva semilla:\n")
  cat(">> set.seed(", semilla,") ...\n", sep = "")
  set.seed(semilla)
  cat(">> Creando nuevos vector arb.x y arb.y para la corrección:\n")
  cat(">> arb.x <- runif(20, 5, 10)\n")
  cat(">> arb.y <- runif(20, 5, 10)\n")
  arb.x <- runif (20, 5, 10)
  arb.y <- runif (20, 5, 10)

  # Evaluación de objetos: dst, i, j, A, B
  eval(parsed)
  ca2  <- arb.x - 0.431 
  co2  <- arb.y - 0.587
  dst2 <- sqrt(ca2 ** 2 + co2 ** 2)
  ii   <- which.min(dst2)
  jj   <- which.max(dst2)
  arb.cerca2 <- c(arb.x[ii], arb.y[ii])
  arb.lejos2 <- c(arb.x[jj], arb.y[jj])
  tol  <- .Machine$double.eps ^ 0.5

  if (any(abs(dst - dst2) > tol))
    stop(mkmsj.v("los valores del dst obtenido no son los esperados", dst, dst2), call. = FALSE)
  cat("valores de dst ... OK\n")

  if (i == jj)
    warning("  ¿Tal vez i y j son iguales?", call. = FALSE)
  if (i != ii)
    stop(mkmsj("el valor de i obtenido no es el esperado", i, ii), call. = FALSE)
  cat("valor de i ... OK\n")

  if (j == ii)
    warning("  ¿Tal vez i y j son iguales?", call. = FALSE)
  if (j != jj)
    stop(mkmsj("el valor de j obtenido no es el esperado", j, jj), call. = FALSE)
  cat("valor de j ... OK\n")

  if (any(abs(arb.cerca - arb.cerca2) > tol)) {
    if (all(arb.cerca == arb.lejos2))
      warning("ej. 3: su punto arb.cerca es el más lejano, en lugar del más cercano", call. = FALSE)
    stop(mkmsj.v("los valores del vector arb.cerca obtenido no son los esperados", arb.cerca, arb.cerca2), call. = FALSE)
  }
  cat("valores de arb.cerca ... OK\n")

  if (any(abs(arb.lejos - arb.lejos2) > tol)) {
    if (all(arb.lejos == arb.cerca2))
      warning("ej. 3: su punto arb.lejos es el más cercano, en lugar del más lejano", call. = FALSE)
    stop(mkmsj.v("los valores del vector arb.lejos obtenido no son los esperados", arb.lejos, arb.lejos2), call. = FALSE)
  }
  cat("valores de arb.lejos ... OK\n")

  TRUE
}

