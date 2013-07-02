
cor1.a <- function() {
  load("datos")
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
  #   aa <- gsub(" ", "", arch[fline])
  #   ab <- strsplit(aa, split = "in")[[1]][2]
  #   ac <- strsplit(ab, split = ")\\{")[[1]][1]

  rango <- gsub(" ", "", arch[fline])
  rango <- strsplit(rango, "")[[1]]
  pare  <- which(rango == "(")[1]
  rango <- rango[- (1:pare)]
  pare  <- which(rango == ")")
  rango <- rango[- (pare[length(pare)]:length(rango))]
  rango <- paste0(rango, collapse= "")
  rango <- strsplit(rango, "in")[[1]][2]
  rango <- eval(parse(text = rango))
  
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
  load("datos")
  arch  <- cut.script("2.a-zenon-recargado.R")
  arch  <- arch[!grepl("cat\\(", arch)]
  whlog <- grepl("\\bwhile\\b", arch)
  whnum <- grep("\\bwhile\\b", arch)
  whlin <- arch[whlog]
  notwh <- arch[!whlog]

  if (!any(whlog))
    stop("la función while no se encuentra en su código", call. = FALSE)
  cat("¿while en el código? ... OK\n")

  if (whnum == 1)
    stop("El código no parece tener líneas de 'Preparación' para el loop", call. = FALSE)
  cat("¿Preparación? ... OK\n")

  dowarn <- function()
    warning("2.a: tal vez los objetos n y/o Zn o bien no están definidos", 
            "o tienen valores incorrectos antes de iniciar el loop", call. = FALSE)
  arch <- c("X <- 1", 
            arch[1:(whnum - 1)],
            "l1 <- !exists('n') || n != 1", 
            "l2 <- !exists('Zn') || abs(Zn - .5) > 1e-8", 
            "if (l1 || l2) dowarn()", 
            arch[whnum], 
            "X <- X + 1",
            "if (X > 1e3)",
            "stop('el loop ha hecho más de 1000 iteraciones y se ha detenido forzosamente', call. = FALSE)",
            arch[(whnum + 1):length(arch)])

  if (!grepl("\\bepsilon\\b", whlin))
    stop("la variable epsilon no aparece en la condición del while", call. = FALSE)
  cat("¿epsilon en condición del while? ... OK\n")

  if (any(grepl("\\bepsilon\\b", notwh)))
    stop("la variable epsilon sólo puede ser usada en la condición del while", call. = FALSE)
  cat("¿epsilon afuera de condición while? ... OK\n")

  #   epsilon <- sample(1:5, 1) * 10 ^ (- sample(4:6, 1))
  epsilon <- round(runif(1), 2) * 10 ^ (- sample(4:6, 1))
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
  cars <- strsplit(whlin, "")[[1]]
  pare <- which(cars == "(")[1]
  cars <- cars[- (1:pare)]
  pare <- which(cars == ")")
  cars <- cars[- (pare[length(pare)]:length(cars))]
  cars <- paste0(cars, collapse= "")
  cars <- gsub("epsilon", 1 - Zn, cars)
  geq  <- eval(parse(text = cars)) # si TRUE, está bien, si no está mal

  if (!geq) {
    warning("2.a: recuerde que la condición lógica necesaria para el loop while debe ser ",
            "exactamente complementaria a la condición de interrupción", call. = FALSE)
    stop("la condición del while no es la correcta, tal vez por usar un operador relacional incorrecto", 
         call. = FALSE)
  }

  TRUE
}

cor2.b <- function() {
  load("datos")
  arch <- cut.script("2.b-guardar-valores.R")
  arch <- arch[!grepl("cat\\(", arch)]

  whlog <- grepl("\\bwhile\\b", arch)
  whnum <- grep("\\bwhile\\b", arch)
  whlin <- arch[whlog]
  notwh <- arch[!whlog]

  if (!any(whlog))
    stop("la función while no se encuentra en su código", call. = FALSE)
  cat("¿while en el código? ... OK\n")

  if (whnum == 1)
    stop("El código no parece tener líneas de 'Preparación' para el loop", call. = FALSE)
  cat("¿Preparación? ... OK\n")

  dowarn <- function()
    warning("2.b: tal vez los objetos n, Zn y/o Z o bien no están definidos", 
            "o tienen valores incorrectos antes de iniciar el loop", call. = FALSE)

  # Preparación: Z inicial 
  arch <- c("X <- 1", 
            arch[1:(whnum - 1)],
            "l1 <- !exists('n') || n != 1", 
            "l2 <- !exists('Zn') || abs(Zn - .5) > 1e-8", 
            "l3 <- !exists('Z') || abs(Z[1] - .5) > 1e-8", 
            "if (l1 || l2 || l3) dowarn()", 
            arch[whnum], 
            "X <- X + 1",
            "if (X > 1e3)",
            "stop('el loop ha hecho más de 1000 iteraciones y se ha detenido forzosamente', call. = FALSE)",
            arch[(whnum + 1):length(arch)])

  if (!grepl("\\bepsilon\\b", whlin))
    stop("la variable epsilon no aparece en la condición del while", call. = FALSE)
  cat("¿epsilon en condición del while? ... OK\n")

  if (any(grepl("\\bepsilon\\b", notwh)))
    stop("la variable epsilon sólo puede ser usada en la condición del while", call. = FALSE)
  cat("¿epsilon afuera de condición while? ... OK\n")

  epsilon <- round(runif(1), 2) * 10 ^ (- sample(4:6, 1))
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
  }
  ZX <- ZX[1:nX]

  # Final: Z
  eval(parsed)

  if (length(Z) != length(ZX))
    warning(mkmsj("ej. 2.b: la longitud de Z no es la esperada", length(Z), length(ZX)), call. = FALSE)

  if (Z[length(Z)] == 0)
    stop("el último valor de Z es 0", call. = FALSE)
  cat("ultimo valor de Z != 0 ... OK\n")

  if (!all(abs(Z - ZX) < 1e-8)) {
    msj <- mkmsj.v("Los valores de Z difieren de los esperados", Z, ZX)
    stop(msj, call. = FALSE)
  }
  cat("todos los valores de Z ... OK\n")

  TRUE
}

cor3.a <- function() {
  load("datos")
  arch <- cut.script("3.a-limites.R")

  if (length(arch) == 0)
    stop("su código parece vacío, ¿guardo los cambios que hizo?", call. = FALSE)
  cat("código en archivo ... OK\n")
  parsed <- parse(text = arch)

  maximo <- sample(40:100, 1)
  cat(">> nuevo maximo para la correccion: ", maximo, "\n")

  pasajeros <- maximo + 1
  cat(">> cantidad de pasajeros antes del código: ", pasajeros, "\n")
  eval(parsed)
  if (pasajeros != maximo) {
    warning("3.a: ¡verifique los signos de *ambos* condicionales por las dudas!", call. = FALSE)
    stop("el número de pasajeros es distinto 'maximo' (", maximo,") cuando se sobrecarga el bus", call. = FALSE)
  }
  cat("¿pasajeros != maximo? ... OK\n")

  pasajeros <- -1
  cat(">> cantidad de pasajeros antes del código: ", pasajeros, "\n")
  eval(parsed)
  if (pasajeros < 0) {
    warning("3.a: ¡verifique los signos de *ambos* condicionales por las dudas!", call. = FALSE)
    stop("el número de pasajeros distinto a 0 cuando se vacía el bus", call. = FALSE)
  }
  cat("¿pasajeros != 0? ... OK\n")

  TRUE
}

cor3.b <- function() {
  load("datos")
  arch <- cut.script("3.b-no-suben.R")

  if (length(arch) == 0)
    stop("su código parece vacío, ¿guardo los cambios que hizo?", call. = FALSE)
  cat("código en archivo ... OK\n")
  parsed <- parse(text = arch)

  aaa <- gsub(" ", "", arch)
  if (!any(grepl("nosuben\\[", aaa)))
    warning("3.b: ¡El vector 'nosuben' parece no estar indizado!", call. = FALSE)

  maximo  <- sample(40:100, 1)
  cat(">> nuevo maximo para la correccion: ", maximo, "\n")
  i <- sample(40:100, 1)
  nosuben <- numeric(100)
  suben <- rpois(1, 20) + 3
  pasajeros <- maximo + suben
  cat(">> cantidad de pasajeros antes del código: ", pasajeros, "\n")
  eval(parsed)

  if (pasajeros != maximo) {
    stop("el número de pasajeros es distinto 'maximo' (", maximo,") cuando se sobrecarga el bus", call. = FALSE)
  }
  cat("¿pasajeros != maximo? ... OK\n")

  if (nosuben[i] != suben) {
    stop(mkmsj("el número de personas que no suben es distinto al esperado", nosuben[i], suben), call. = FALSE)
  }
  cat("cantidad que no sube ... OK\n")

  TRUE
}

cor3.c <- function() {
  load("datos")
  arch <- cut.script("3.c-extra-heterogeneidad.R")

  if (length(arch) == 0)
    stop("su código parece vacío, ¿guardo los cambios que hizo?", call. = FALSE)
  cat("código en archivo ... OK\n")
  parsed <- parse(text = arch)

  arch <- gsub(" ", "", arch)
  pois <- paste0(c("- ", "- ", "+ ", "+ "), "rpois(1, ", c(2, 5, 3, 8), ")")
  pois2 <- gsub(" ", "", pois)
  where <- c(bpoco = grep("-rpois\\(1\\,2\\)", arch),
             bmucho = grep("-rpois\\(1\\,5\\)", arch),
             spoco = grep("+rpois\\(1\\,3\\)", arch),
             smucho = grep("+rpois\\(1\\,8\\)", arch))
  nombres <- c("bpoco", "bmucho", "spoco", "smucho")
  cond <- logical(4)
  whcat <- character(length(where))
  for (k in 1:4) {
    logico <- grepl(nombres[k], names(where))
    whcat[logico] <- nombres[k]
    cond[k] <- any(logico)
  }

  if (!all(cond))
    stop("la expresión '", pois[!cond][1], "' no se encontró en el archivo", call. = FALSE)
  cat("rpois presentes ... OK\n")

  for (k in 1:4) {
    logico <- whcat == nombres[k]
    donde <- where[logico]
    arch[donde] <- paste(names(where)[logico], "<- TRUE")
  }
  tmp <- deparse(names(where))
  mkobj <- gsub("\\\"", "", tmp) 
  arch <- c(arch, paste0("objs <- ", mkobj))

  ies <- c(sample(6:13, 1), 15, sample(16:32, 1), 33, 35, sample(37:50, 1))
  nfilas <- paste0("i=", ies)
  expsub <- pois2[c(3, 4, 4, 4, 4, 3)]
  expbaj <- pois2[c(1, 1, 1, 2, 2, 2)]
  expobs <- character(length(ies))
  tabla <- data.frame(Bajan = expbaj, Bajan.Obs. = expobs,
                      Suben = expsub, Suben.Obs. = expobs,
                      stringsAsFactors = FALSE)
  rownames(tabla) <- nfilas
  for (k in 1:length(ies)) {
    i <- ies[k]
    for (h in 1:length(where))
      assign(names(where)[h], FALSE)

    eval(parse(text = arch))
    names(objs) <- whcat
    for (j in 1:4) {
      sumar <- objs[whcat == nombres[j]]
      if (sum(sumar) > 1)
        stop("para i = ", i, " la expresión '", pois[j], "' se ejecutó más de una vez", call. = FALSE)
      #       if (k == 6 && j > 2) browser()
      if (sumar) {
        if (j <= 2) {
          tabla[k, 2] <- pois2[names(sumar) == nombres]
        } else {
          tabla[k, 4] <- pois2[names(sumar) == nombres]
        }
      }
    }
  }
  tA <- tabla[c(1, 3)]
  tB <- tabla[c(2, 4)]
  if (!all(tA == tB)) {
    out <- capture.output(tabla)
    msj <- c("las expresiones ejecutadas no ocurrieron en los momentos esperados:\n\n",
             paste0(out, "\n"),
             "\n")
    stop(msj, call. = FALSE)
  }
  cat("sumas y restas en los momentos apropiados ... OK\n")

  maximo <- 1e3
  m <- maximo
  pasajeros <- rpois(1, 100)
  pini <- pasajeros
  ps   <- pasajeros
  cat(">> nuevo maximo para la correccion: ", maximo, "\n")
  cat(">> cantidad de pasajeros antes del código: ", pasajeros, "\n")

  arch <- cut.script("3.c-extra-heterogeneidad.R")

  for (k in 1:length(ies)) {
    i <- ies[k]
    seed <- sample(1:100, 1)
    set.seed(seed)
    eval(parse(text = arch))
    set.seed(seed)
    if (i < 33) ps <- ps - rpois(1, 2) else ps <- ps - rpois(1, 5)
    if (15 <= i && i <= 35) ps <- ps + rpois(1, 8) else ps <- ps + rpois(1, 3)
    if (pasajeros != ps) {
      mb <- paste0("para i = ", i, ",  nro. de pasajeros iniciales = ", pini, 
                   " y capacidad máxima ", maximo, ",\n",
                   "el número de pasajeros finales no es el esperado ", 
                   "(se usó set.seed(", seed, "))") 
      stop(mkmsj(mb, pasajeros, ps), call. = FALSE)
    }
  }
  cat("cálculos de pasajeros ... OK\n")
      
  TRUE
}

cor3.d <- function() {
  load("datos")
  arch <- cut.script("3.d-extremos.R")

  arch <- gsub(" ", "", arch)
  pois <- paste0(c("- ", "- ", "+ ", "+ "), "rpois(1, ", c(2, 5, 3, 8), ")")
  pois2 <- gsub(" ", "", pois)
  where <- c(bpoco = grep("-rpois\\(1\\,2\\)", arch),
             bmucho = grep("-rpois\\(1\\,5\\)", arch),
             spoco = grep("+rpois\\(1\\,3\\)", arch),
             smucho = grep("+rpois\\(1\\,8\\)", arch))

  arch[where[grepl("b", names(where))]] <- "bajan <-TRUE"
  arch[where[grepl("s", names(where))]] <- "suben <-TRUE"

  pasajeros <- 50
  maximo  <- 100
  nosuben <- numeric(100)
  ies <- c(1:4, 46:50)
  for (k in 1:length(ies)) {
    i <- ies[k]
    bajan <- FALSE
    suben <- FALSE
    eval(parse(text = arch))
    if (i < 5) {
      if (bajan)
        stop("para i = ", i, " < 5 su código permite bajar personas del bus", call. = FALSE)
    } else {
      if (suben)
        stop("para i = ", i, " > 45 su código permite subir personas al bus", call. = FALSE)
    }
  }
  cat("¿suben, bajan? ... OK\n")

  i <- 5
  bajan <- FALSE
  eval(parse(text = arch))
  if (!bajan)
    stop("para i = ", i, " su código no permite bajar personas del bus", call. = FALSE)
  cat("si i = 5 ... OK\n")

  suben <- FALSE
  eval(parse(text = arch))
  if (!suben)
    stop("para i = ", i, " su código no permite subir personas al bus", call. = FALSE)
  cat("si i = 45 ... OK\n")

  TRUE
}

