
cor1.a <- function() {
  load("datos")
  #   src("../auxiliares.R")
  #   arch <- cut.script("tmp.R")
  #   cat("TMP.R!!!!!!!!!!\n")
  arch <- cut.script("1.a-loop-for.R")
  cat(">> Creando una nueva matriz 'datos' para la corrección:\n")
  datos <- matrix(rpois(rpois(1, 125) * 15, 43), ncol = 15)
#   datos[sample(length(datos), rpois(1, 250))] <- NA
  datos[sample(length(datos), 1)] <- 45
  parsed <- parse(text = arch)
  ddatos <- dim(datos)

  cat(">> dimensiones de la matriz creada:", paste0(ddatos, collapse = " x "), "\n")
  #   cat(">> dim(datos)\n [1]", paste0(ddatos, collapse = " "), "\n")

  if (any(c(grepl("while", arch), grepl("apply", arch))))
    stop("la/s función/es while y/o apply figuran en su código, lo cual no está permitido", call. = FALSE)
  cat("¿while o apply? ... OK\n")

  fline <- grep("for", arch)
  eval(parsed[1:(fline - 1)])

  if (length(out) < nrow(datos))
    stop("la longitud de out al iniciar el loop es menor a la cantidad de filas de datos", call. = FALSE)
  if (length(out) > nrow(datos))
    stop("la longitud de out al iniciar el loop es mayor a la cantidad de filas de datos", call. = FALSE)
  cat("length(out) ... OK\n")
     
  # Estas no se si voy a usarlas aún, pero tengo que acordarme de
  # agregar un if para asegurar que la llave de apertura esté en la
  # fline...
  aa <- gsub(" ", "", arch[fline])
  ab <- strsplit(aa, split = "in")[[1]][2]
  ac <- strsplit(ab, split = ")\\{")[[1]][1]
  rango <- eval(parse(text = ac))

  if (length(rango) != nrow(datos))
    stop(mkmsj("el número de iteraciones de su loop es distinto a la cantidad de filas de la matriz", 
               length(rango), nrow(datos)), call. = FALSE)
  cat("número de iteraciones ... OK\n")

  outX <- apply(datos, 1, function(x) sum(x > 45))

  eval(parsed)
  if (!all(out == outX)) {
    msj <- mkmsj.v("los valores del vector out difieren de lo esperado", out, outX)
    stop(msj, call. = FALSE)
  }
  cat("valores de out ... OK\n")
   
  TRUE
}

cor1.b <- function() {
  load("datos")
  src("../auxiliares.R")
  arch <- cut.script("tmp.R")
  cat("TMP.R!!!!!!!!!!\n")
  #   arch <- cut.script("1.b-loop-for.R")

}
