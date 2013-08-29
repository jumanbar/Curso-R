
cor1 <- function() {
  # Cargar datos y script
  load('datos')
  arch <- cut.script("1-varianza.R")
  parsed <- parse(text = arch)

  # Generación de datos
  #   semilla <- sample(1000, 1)
  semilla <- 444
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

cor3 <- function() TRUE
