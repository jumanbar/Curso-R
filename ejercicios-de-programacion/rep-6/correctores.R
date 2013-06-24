
cor1.a <- function() {
  load("datos")
  #   src("../auxiliares.R")
  #   arch <- cut.script("tmp.R")
  #   cat("TMP.R!!!!!!!!!!\n")
  arch <- cut.script("1.a-loop-for.R")
  cat(">> Creando una nueva matriz 'datos' para la corrección:\n")
  datos <- matrix(rpois(rpois(1, 125) * 15, 43), ncol = 15)
#   datos[sample(length(datos), rpois(1, 250))] <- NA
  datos[sample(length(datos), 1)] <- 46
  parsed <- parse(text = arch)
  ddatos <- dim(datos)

  cat(">> dimensiones de la matriz creada:", paste0(ddatos, collapse = " x "), "\n")
  #   cat(">> dim(datos)\n [1]", paste0(ddatos, collapse = " "), "\n")

  if (any(c(grepl("while", arch), grepl("apply", arch))))
    stop("la/s función/es while y/o apply figuran en su código, lo cual no está permitido", call. = FALSE)
  cat("¿while o apply? ... OK\n")

  if (!any(grepl("for", arch)))
    stop("la función for no se encuentra en su código", call. = FALSE)
  cat("¿for en el código? ... OK\n")

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
  #   src("../auxiliares.R")
  #   arch <- cut.script("tmp.R")
  #   cat("TMP.R!!!!!!!!!!\n")
  arch <- cut.script("1.b-extra-apply.R")

  cat(">> Creando una nueva matriz 'datos' para la corrección:\n")
  datos <- matrix(rpois(rpois(1, 125) * 15, 43), ncol = 15)
  datos[sample(length(datos), 1)] <- 46
  parsed <- parse(text = arch)
  ddatos <- dim(datos)

  cat(">> dimensiones de la matriz creada:", paste0(ddatos, collapse = " x "), "\n")

  if (any(c(grepl("while", arch), grepl("for", arch))))
    stop("la/s función/es while y/o for figuran en su código, lo cual no está permitido", call. = FALSE)
  cat("¿while o for? ... OK\n")

  if (!any(grepl("apply", arch)))
    stop("la función apply no se encuentra en su código", call. = FALSE)
  cat("¿apply en el código? ... OK\n")

  outX <- apply(datos, 1, function(x) sum(x > 45))

  eval(parsed)
  if (!all(out == outX)) {
    msj <- mkmsj.v("los valores del vector out difieren de lo esperado", out, outX)
    stop(msj, call. = FALSE)
  }
  cat("valores de out ... OK\n")

  TRUE
}

cor2.a <- function() {
  #   src("../auxiliares.R")
  #   arch <- cut.script("tmp.R")
  #   cat("TMP.R!!!!!!!!!!\n")
  load("datos")
  arch <- cut.script("2.a-zenon-recargado.R")
  arch <- arch[!grepl("cat\\(", arch)]
  wlogic <- grepl("\\bwhile\\b", arch)
  wnumb <- grep("\\bwhile\\b", arch)
  wline <- arch[wlogic]
  notwh <- arch[!wlogic]

  if (!any(wlogic))
    stop("la función while no se encuentra en su código", call. = FALSE)
  cat("¿while en el código? ... OK\n")

  if (wnumb == 1)
    warning("El loop no parece tener líneas de 'Preparación'", call. = FALSE)
  cat("¿Preparación?\n")

  #   first <- TRUE
  #   arch <- c("X <- 1", 
  #             arch[1:wnumb], 
  #             "l1 <- !exists('n') || n != 1", 
  #             "l2 <- !exists('Zn') || abs(Zn - .5) > 1e-8", 
  #             "if ((l1 || l2) && first) {", 
  #             "warning('ej. 2.a: es posible que la preparación del loop esté incompleta', call. = FALSE)",
  #             "}",
  #             "first <- FALSE",
  #             "X <- X + 1",
  #             "if (X > 1e3)",
  #             "stop('el loop ha hecho más de 1000 iteraciones y se ha detenido forzosamente', call. = FALSE)",
  #             arch[(wnumb + 1):length(arch)])
  arch <- c("X <- 1", 
            arch[1:(wnumb - 1)],
            "l1 <- !exists('n') || n != 1", 
            "l2 <- !exists('Zn') || abs(Zn - .5) > 1e-8", 
            "if (l1 || l2) dowarn()", 
            arch[wnumb], 
            "X <- X + 1",
            "if (X > 1e3)",
            "stop('el loop ha hecho más de 1000 iteraciones y se ha detenido forzosamente', call. = FALSE)",
            arch[(wnumb + 1):length(arch)])

  if (!grepl("\\bepsilon\\b", wline))
    stop("la variable epsilon no aparece en la condición del while", call. = FALSE)
  cat("¿epsilon en condición del while? ... OK\n")

  if (any(grepl("\\bepsilon\\b", notwh)))
    stop("la variable epsilon sólo puede ser usada en la condición del while", call. = FALSE)
  cat("¿epsilon afuera de condición while? ... OK\n")

  epsilon <- sample(1:5, 1) * 10 ^ (- sample(4:6, 1))
  epsci <- format(epsilon, scientific = TRUE)
  cat(">> epsilon tomado para la corrección:", epsci, "\n")
  arch <- gsub("epsilon", epsci, arch)
  parsed <- parse(text = arch)

  if (any(c(grepl("\\bapply\\b", arch), grepl("\\bfor\\b", arch))))
    stop("la/s función/es apply y/o for figuran en su código, lo cual no está permitido", call. = FALSE)
  cat("¿apply o for? ... OK\n")

  nX <- 1
  ZnX <- sum(1 / (2 ^ (1:nX)))
  while (1 - ZnX > epsilon) {
    nX <- nX + 1
    ZnX <- sum(1 / (2 ^ (1:nX)))
  }

  #   eval(parsed)
  eval(parse(text = arch))

  if (n != nX) {
    msj <- mkmsj(paste0("para el epsilon usado (", epsci, ") el valor de n no es el esperado"), n, nX)
    stop(msj, call. = FALSE)
  }
  cat("valor de n ... OK\n")

  if (abs(Zn - ZnX) > 1e-8) {
    msj <- mkmsj("para el epsilon usado (", epsci, ") el valor de Zn no es el esperado", Zn, ZnX, 1e-8)
    stop(msj, call. = FALSE)
  }
  cat("valor de Zn ... OK\n")

  Zbackup <- Zn
  Zn <- - sample(1:9, 1)
  #   ab <- "1 - Zn >= epsilon"
  aa <- strsplit(wline, "\\(")[[1]][2]
  ab <- strsplit(aa, "\\)")[[1]][1]
  ab <- gsub("epsilon", 1 - Zn, ab)
  geq <- eval(parse(text = ab)) # si TRUE, está bien, si no está mal

  if (!geq) {
    warning("ej. 2.a: recuerde que la condición lógica necesaria para el loop while debe ser ",
            "exactamente complementaria a la condición de interrupción", call. = FALSE)
    stop("la condición del while no es la correcta, tal vez por usar un operador relacional incorrecto", 
         call. = FALSE)
  }

  TRUE
}

cor2.b <- function() {
  src("../auxiliares.R")
  arch <- cut.script("tmp.R")
  arch <- arch[!grepl("cat\\(", arch)]
  cat("TMP.R!!!!!!!!!!\n")
  load("datos")
  #   arch <- cut.script("2.a-zenon-recargado.R")

  wlogic <- grepl("\\bwhile\\b", arch)
  wnumb <- grep("\\bwhile\\b", arch)
  wline <- arch[wlogic]
  notwh <- arch[!wlogic]

  if (!any(wlogic))
    stop("la función while no se encuentra en su código", call. = FALSE)
  cat("¿while en el código? ... OK\n")

  if (wnumb == 1)
    stop("El código no parece tener líneas de 'Preparación' para el loop", call. = FALSE)
  cat("¿Preparación?\n")

  dowarn <- function()
    warning("ej. 2.a: los objetos n y/o Zn o bien no están definidos, o tienen valores ",
            "incorrectos antes de iniciar el loop", call. = FALSE)

  arch <- c("X <- 1", 
            arch[1:(wnumb - 1)],
            "l1 <- !exists('n') || n != 1", 
            "l2 <- !exists('Zn') || abs(Zn - .5) > 1e-8", 
            "if (l1 || l2) dowarn()", 
            arch[wnumb], 
            "X <- X + 1",
            "if (X > 1e3)",
            "stop('el loop ha hecho más de 1000 iteraciones y se ha detenido forzosamente', call. = FALSE)",
            arch[(wnumb + 1):length(arch)])

  if (!grepl("\\bepsilon\\b", wline))
    stop("la variable epsilon no aparece en la condición del while", call. = FALSE)
  cat("¿epsilon en condición del while? ... OK\n")

  if (any(grepl("\\bepsilon\\b", notwh)))
    stop("la variable epsilon sólo puede ser usada en la condición del while", call. = FALSE)
  cat("¿epsilon afuera de condición while? ... OK\n")

  epsilon <- sample(1:5, 1) * 10 ^ (- sample(4:6, 1))
  epsci <- format(epsilon, scientific = TRUE)
  cat(">> epsilon tomado para la corrección:", epsci, "\n")
  arch <- gsub("epsilon", epsci, arch)
  parsed <- parse(text = arch)

  nX <- 1
  ZnX <- sum(1 / (2 ^ (1:nX)))
  ZX <- numeric(1e3)
  ZX[nX] <- ZnX
  while (1 - ZnX >= epsilon) {
    nX <- nX + 1
    ZnX <- sum(1 / (2 ^ (1:nX)))
    ZX[nX] <- ZnX
    # Esto es para mostrar el progreso en la consola:
    cat("nX =", nX, "- ZnX =", ZnX, "\nX")
  }
  ZX <- ZX[1:nX]
  # Preparación: Z inicial 

  # Loop: Z[n]
  # Final: Z

  TRUE
}
