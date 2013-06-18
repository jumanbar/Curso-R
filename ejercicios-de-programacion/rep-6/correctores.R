cor1.a() {
  #   load("datos")
     src("../auxiliares.R")
  arch <- cut.script("tmp.R")
  cat("TMP.R!!!!!!!!!!\n")
  #   arch <- cut.script("1.a-loop-for.R")
  datos <- matrix(rpois(rpois(1, 125) * 15, 43), ncol = 15)
#   datos[sample(length(datos), rpois(1, 250))] <- NA
  parsed <- parse(text = arch)

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
     
  eval(parsed)
   
  TRUE
}
