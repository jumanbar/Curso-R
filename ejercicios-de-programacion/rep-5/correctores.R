
### FUNCIONES DE CORRECCIÓN:

## Ej. 1
cor1 <- function() {
  load('datos')

  # Evaluación de la función "triangulo":
  #   source('1-triangulo.R', local = TRUE)
  source('tmp.R', local = TRUE)
  ca <- rpois(1, 10)
  co <- rpois(1, 10)
  out1 <- triangulo(ca, co)
  out2 <- tri(ca, co)
  tol <- 1e-8

  if (identical(out1, out2))
    return(TRUE)

  if (!is.list(out1))
    stop("la salida de la función no es una lista", call. = FALSE)
  cat("¿es lista la salida? (is.list) ... OK\n")

  if (!all(names(out1) == names(out2))) {
    if (all(tolower(names(out1)) == tolower(names(out2))))
      warning("ej. 1: hay un problema con las mayúsculas/minúsculas en los nombres de la salida", call. = FALSE)
    msj <- mkmsj.v("los nombres del objeto de salida no coinciden con los esperados",
                   names(out1), names(out2))
    stop(msj, call. = FALSE)
  }
  cat("nombres del objeto de salida ... OK\n")

  values1 <- unlist(out1)
  values2 <- unlist(out2)

  if (!all(abs(values1 - values2) < tol)) {
    mbase <- paste0("usando cat.ad = ", ca, " y cat.op = ", 
                    co, " se obtuvieron valores incorrectos")
    stop(mkmsj.v(mbase, values1, values2, tol), call. = FALSE)
  }
  cat("valores en la salida ... OK\n")

  TRUE
}

cor2.a <- function() {
  load("datos")
  source("2.a-filtroc.R", encoding = "UTF-8")
  #   source("tmp.R", encoding = "UTF-8")

  if (is.null(formals(filtroc)))
    stop("la función filtroc no parece tener argumentos definidos", call. = FALSE)
  cat("¿tiene argumentos? ... OK\n")

  f1 <- names(formals(filtroc))
  f2 <- names(formals(fc))
  names(f1) <- paste0("Argumento ", 1:length(f1), ":")
  names(f2) <- paste0("Argumento ", 1:length(f2), ":")

  if (length(f1) != length(f2))
    stop(mkmsj("la cantidad de argumentos no es la esperada", length(f1), length(f2)), call. = FALSE)
  cat("cantidad de argumentos (filtroc) ... OK\n")

  if (!all(f1 == f2))
    stop(mkmsj.v("los nombres de los argumentos de filtroc no son los esperados", f1, f2), call. = FALSE)
  cat("nombres de los argumentos (filtroc) ... OK\n")

  m <- matrix(rpois(6 * 3, 30), 3, 6) 
  m <- as.data.frame(m)
  doggies <- sample(6, 3)
  names(m)[doggies] <- paste0("perro", ".", 1:3)
  names(m)[- doggies] <- paste0("gato", ".", 1:3)

  letras <- unique(unlist(strsplit("perrogato", "")))
  camb <- paste(sample(letras, 4), collapse = "")
  key <- sample(c("perro", "gato"), 1)
  key <- chartr(camb, toupper(camb), key)
  llamado <- paste0("filtroc(m, '", key, "')")

  for (i in 1:6) {
    camb <- paste(sample(letras, 4), collapse = "")
    names(m)[i] <- chartr(camb, toupper(camb), names(m)[i])
  }


  cat("probando 'filtroc' con:\n>> ", llamado, "\n")

  out1 <- filtroc(m, key)
  out2 <- fc(m, key)
  msj <- c("\nLa función filtroc no funciona correctamente. Usando",
           "\ncomo prueba la siguiente data.frame (m):", 
           "\n\n", paste0(capture.output(m), "\n"),
           paste0("\n>> ", llamado, " # devuelve:"),
           "\n\n", paste0(capture.output(out1), "\n"),
           "\ncuando se esperaba:", 
           "\n\n", paste0(capture.output(out2), "\n"))
  if (!identical(out1, out2))
    stop(msj, call. = FALSE)
  cat("salida de filtroc ... OK\n")

  out3 <- filtroc(iris, "species")
  if (!is.data.frame(out3))
    stop("filtroc no devuelve un data.frame al seleccionar una sola columna. Ej: filtroc(cars, 'dist')", call. = FALSE)
  cat("¿salida de filtroc es siempre data.frame? ... OK\n")

  TRUE
}

cor2.b <- function() {
  load('datos')
  filtroc <- fc
  #   source('2.b-aplicar.R', encoding = 'UTF-8')
  source('tmp.R', encoding = 'UTF-8')

  if (is.null(formals(aplicar)))
    stop("la función aplicar no parece tener argumentos definidos", call. = FALSE)
  cat("¿tiene argumentos? ... OK\n")

  f1 <- names(formals(aplicar))
  f2 <- names(formals(ap))
  names(f1) <- paste0("Argumento ", 1:length(f1), ":")
  names(f2) <- paste0("Argumento ", 1:length(f2), ":")

  if (length(f1) != length(f2))
    stop(mkmsj("la cantidad de argumentos no es la esperada", length(f1), length(f2)), call. = FALSE)
  cat("cantidad de argumentos (aplicar) ... OK\n")

  if (!all(f1 == f2))
    stop(mkmsj.v("los nombres de los argumentos de aplicar no son los esperados", f1, f2), call. = FALSE)
  cat("nombres de los argumentos (aplicar) ... OK\n")

  ## ... tiene que aparecer dos veces en el script!!!

  m <- matrix(rpois(8 * 4, 30), 4, 8)
  m[sample(length(m), 7)] <- NA
  m <- as.data.frame(m)
  doggies <- sample(ncol(m), ncol(m) / 2)
  names(m)[doggies] <- paste0("perro", ".", 1:length(doggies))
  names(m)[- doggies] <- paste0("gato", ".", 1:length(doggies))

  letras <- unique(unlist(strsplit("perrogato", "")))
  camb <- paste(sample(letras, 4), collapse = "")
  key <- sample(c("perro", "gato"), 1)
  key <- chartr(camb, toupper(camb), key)

  for (i in 1:ncol(m)) {
    camb <- paste(sample(letras, 4), collapse = "")
    names(m)[i] <- chartr(camb, toupper(camb), names(m)[i])
  }

  foos <- c("sum", "sample", "paste", "quantile")
  f <- sample(foos, 1)
  puntitos <- switch(f, 
                     sum = "na.rm = TRUE", 
                     sample = "size = 1", 
                     paste = paste0("collapse = ", sample(c("''", "'-'", "'='"), 1)), 
                     quantile = paste0("probs = ", round(runif(1, 0.4, 0.6), 3), ", na.rm = TRUE"))
  txt1 <- paste0("aplicar(m, key, ", f, ", ", puntitos, ")")
  txt2 <- paste0("ap(m, key, ", f, ", ", puntitos, ")")

  cat("probando 'aplicar' con:\n>> ", txt1, "\n")

  seed <- sample(100, 1)

  if (f == "sample") set.seed(seed)
  out1 <- eval(parse(text = txt1))
  if (f == "sample") set.seed(seed)
  out2 <- eval(parse(text = txt2))

  msj <- c("\nLa función aplicar no funciona correctamente. Usando",
           "\ncomo prueba la siguiente data.frame (m):", 
           "\n\n", paste0(capture.output(m), "\n"),
           paste0("\n>> ", txt1, " # devuelve:"),
           "\n\n", paste0(capture.output(out1), "\n"),
           "\ncuando se esperaba:", 
           "\n\n", paste0(capture.output(out2), "\n"))
  if (!identical(out1, out2)) {
    if (f == "sample")
      warning("ej. 2.b: la función sample se ejecutó con:   set.seed(", seed, ")", call. = FALSE)
    stop(msj, call. = FALSE)
  }
  cat("salida de aplicar ... OK\n")
}

cor2.c <- function() {
  # Cargar datos
  load('datos')
  aplicar <- ap
  filtroc <- fc
  load('edu.data.RData')
  d <- edu.data

  # Evaluación de la función "educacion":
  #   source('2.c-educacion.R', encoding = "UTF-8")
  source('tmp.R', encoding = "UTF-8")

  if (is.null(formals(educacion)))
    stop("la función educacion no parece tener argumentos definidos", call. = FALSE)
  cat("¿tiene argumentos? ... OK\n")

  f1 <- names(formals(educacion))
  f2 <- names(formals(edu))
  names(f1) <- paste0("Argumento ", 1:length(f1), ":")
  names(f2) <- paste0("Argumento ", 1:length(f2), ":")

  if (length(f1) != length(f2))
    stop(mkmsj("la cantidad de argumentos no es la esperada", length(f1), length(f2)), call. = FALSE)
  cat("cantidad de argumentos (educacion) ... OK\n")

  if (!all(f1 == f2))
    stop(mkmsj.v("los nombres de los argumentos de educacion no son los esperados", f1, f2), call. = FALSE)
  cat("nombres de los argumentos (educacion) ... OK\n")

  pos <- sample(nrow(edu.data), 1)
  txt <- paste0("edu.data <- edu.data[-", pos, ",]")

  cat("alterando la data.frame de entrada:\n>>  ", txt, "\n")
  d <- d[-pos,]

  out1 <- educacion(d)
  out2 <- edu(d)

  if (identical(out1, out2))
    return(TRUE)

  if (!is.list(out1))
    stop("la salida de educacion no es una lista", call. = FALSE)
  cat("is.list(out) ... OK\n")

  if (class(out1) != "edu")
    stop("la salida de educacion no es de clase 'edu'", call. = FALSE)
  cat("class(out) ... OK\n")

  if (!all(names(out1) == names(out2))) {
    msj <- mkmsj.v("los nombres del objeto de salida no coinciden con los esperados", names(out1), names(out2))
    if (all(tolower(names(out1)) == tolower(names(out2)))) {
      warning("ej. 2.c: parece haber un problema de mayúsculas/minúsculas en los nombres el objeto de salida", 
              call. = FALSE)
    }
    stop(msj, call. = FALSE)
  }
  cat("nombres del objeto de salida ... OK\n")

  if (!is.data.frame(out1$datos))
    stop("el objeto datos dentro de la salida de educacion no es data.frame", call. = FALSE)
  cat("¿out$datos es data.frame? ... OK\n")

  if (!all(dim(out1$datos) == dim(out2$datos))) {
    if (nrow(out1$datos) == nrow(d) + 1)
      warning("ej. 2.c: es posible que esté trabajando con 'edu.data' dentro de su función, en lugar de 'x'", 
              call. = FALSE)
    stop("las dimensiones esperadas de datos son: ", paste(dim(out2$datos), collapse = ", "),
         ", sin embargo se observaron estas dimensiones: ", paste(dim(out1$datos), collapse = ", "),
         call. = FALSE)
  }
  cat("dimensiones de out$datos ... OK\n")

  if (!all(out1$datos == out2$datos, na.rm = TRUE)) {
    warning("ej. 2.c: tal vez el orden de las columnas no sea el esperado", call. = FALSE)
    msj <- mkmsj.df("la data.frame datos contiene valores diferentes a los esperados",
                    out1$datos, out2$datos)
    stop(msj, call. = FALSE)
  }
  cat("valores de out$datos ... OK\n")

  if (class(out1$reg) != "lm")
    stop("el objeto reg dentro de la salida de educacion no es de clase 'lm'", call. = FALSE)
  cat("¿out$reg es lm? ... OK\n")

  v <- c(1:2, 5, 8)
  ra <- out1$reg[v]
  attr(ra[[1]], "names") <- letters[1:length(ra[[1]])]
  rb <- out2$reg[v]
  attr(rb[[1]], "names") <- letters[1:length(ra[[1]])]
  ra$ta <- out1$reg[[12]][,1]
  ra$pc <- out1$reg[[12]][,2]
  rb$ta <- out2$reg[[12]][,1]
  rb$pc <- out2$reg[[12]][,2]
  c1 <- capture.output(out1$reg$call)
  c2 <- capture.output(out2$reg$call)

  if (!identical(ra, rb))
    stop("hay alguna diferencia en la regresión respecto a lo esperado", call. = FALSE)
  cat("regresión TA ~ PC\n")

  TRUE
}

cor3.a <- function() {
  # Cargar datos
  load('datos')
  
  # Generación de datos
  n <- sample(10:100, 1)
  v <- rpois(n, 80)
  s <- - rpois(1, 300)
  source('cambiaPares.R', local = TRUE)
  out1 <- cambiaPares(v, s)
  out2 <- cpr(v, s)
  if (!identical(out1, out2))
    stop("¡el script 'cambiaPares.R' aún tiene errores!", call. = FALSE)
  TRUE
}

cor3.b <- function() {
  # Cargar datos
  load('datos')

  # Generación de datos
  r <- rnorm(1, sd = 30)
  source('radio.R', local = TRUE)
  p1 <- capture.output(out1 <- radio(r))
  p1 <- gsub(' ', '', p1)
  p2 <- capture.output(out2 <- rad(r))
  p2 <- gsub(' ', '', p2)
  if (!all(p1 == p2))
    stop("el mensaje que 'radio' imprime en la consola no coincide con el esperado.", call. = FALSE)
  if (!identical(out1, out2))
    stop("el objeto de salida ('salida') es distinto al esperado.", call. = FALSE)
  TRUE
}

cor3.c <- function() {
  # ARREGLAR PARA 2013: LA FUNCIÓN NO EVALÚA SI SE PRODUCE UN GRÁFICO O NO... (ES DECIR,
  # IGNORA EL ERROR DE LA LÍNEA 34 ("!"ver debe cambiarse por "ver"
  # Cargar datos
  load('datos')
  
  # Generación de datos
  p <- rnorm(2)
  x <- matrix(rnorm(80, sd = 30), ncol = 2)
  source('distancias.R', local = TRUE)
  p1 <- capture.output(out1 <- distancias(x, p, FALSE))
  p2 <- capture.output(out2 <- dis(x, p, FALSE))
  if (!identical(p1, p2))
    stop("¡el script 'distancias.R' aún tiene errores!", call. = FALSE)
  if (!identical(out1, out2))
    stop("¡el script 'distancias.R' aún tiene errores (en el objeto de salida)!", call. = FALSE)
  TRUE
}

################################################################################
