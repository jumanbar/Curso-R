
cor1.a <- function() {
  # Cargar 'datos'
  #   load('datos')
  source("hacemagia.R")
  arch <- cut.script('1.a-sexo.R')

  if (length(arch) == 0) # No hay nada escrito
    stop("el código no fue modificado (¿olvidó guardar sus cambios?)", call. = FALSE)

  sex <- as.factor(magic$genero)
  levels(sex) <- c("mujer", "hombre")
  eval(parse(text = arch))

  if (identical(magic$genero, sex))
    return(TRUE)

  if (!is.factor(magic$genero))
    stop("la variable magic$genero no es de clase factor", call. = FALSE)
  cat("is.factor(magic$genero) ... OK\n")

  if (any(levels(magic$genero) != levels(sex))) {
    msj <- mkmsj.v("los niveles de magic$genero no son los esperados",
                   levels(magic$genero), levels(sex))
    stop(msj, call. = FALSE)
  }

  if (any(magic$genero != sex)) {
    msj <- mkmsj.v("los valores de magic$genero no son los esperados",
                   magic$genero, sex)
    stop(msj, call. = FALSE)
  }

  TRUE
}

cor1.b <- function() {
  # Cargar 'datos'
  #   load('datos')
  on.exit({
    devs <- dev.list()
    if (any(names(devs) == "png")) {
      devs <- devs[grepl("png", names(devs))] 
      for (i in devs)
        dev.off(i)
    }
  })
  #   
  #   if (!is.factor(magic$genero))
  #     warning("la variable magic$genero no es de clase factor", call. = FALSE)
  source("hacemagia.R")
  #   magic$genero <- as.factor(magic$genero)
  #   levels(magic$genero) <- c("mujer", "hombre")

  png(tmp <- tempfile())
    hist.mm  <- hist(magic$altura[magic$genero == "mujer" | magic$genero == 1], breaks = 15)
    hist.hh  <- hist(magic$altura[magic$genero == "hombre" | magic$genero == 2], breaks = 15)
    hist.all <- hist(magic$altura, breaks = 15)
  dev.off()

  arch <- cut.script('1.b-hist.R')
  if (gsub(" ", "", arch[1]) == "hist.m<-0")
    stop("el código no fue modificado (¿olvidó guardar sus cambios?)", call. = FALSE)

  parlines <- grep("\\<par\\>", arch)
  if (!any(grepl("\\<par\\>", arch)))
    stop("la función par no figura en su código", call. = FALSE)
  cat("función par en el código ... OK\n")

  if (length(parlines) > 1)
    arch <- arch[- parlines[2:length(parlines)]]
  arch <- c(arch, "opp <- par(mfcol = c(1, 1))")
  png(tmp)
    eval(parse(text = arch))
  dev.off()
  unlink(tmp)

  if (!any(mf <- c("mfcol", "mfrow") %in% names(opp)))
    stop("no parece haber utilizado mfcol ni mfrow con la función par", call. = FALSE)
  cat("uso de mfcol/mfrow ... OK\n")

  mf <- c("mfcol", "mfrow")[mf]

  if (!all(opp[[mf]] == c(2, 1))) {
    mensaje <- mkmsj.v("los valores de mfcol/mfrow no son los esperados", opp[[mf]], c(2, 1))
    stop(mensaje)
  }
  cat("valor de mfcol/mfrow ... OK\n")

  if (identical(hist.m[1:4], hist.mm[1:4]) && identical(hist.h[1:4], hist.hh[1:4]))
    return(TRUE)

  if (!all(c(class(hist.m), class(hist.h)) %in% "histogram"))
    stop("la clase de alguno de los hist.x no es 'histogram'", call. = FALSE)
  cat("¿son los hist.x de clase histogram? ... OK\n")

  if (identical(hist.m[1:4], hist.all[1:4]))
    stop("su histograma hist.m tiene alturas de hombres y mujeres", call. = FALSE)
  if (identical(hist.h[1:4], hist.hh[1:4]))
    stop("su histograma hist.h tiene alturas de hombres y mujeres", call. = FALSE)
  cat("¿se separan los datos de hombres y mujeres? ... OK\n")

  if (!all(hist.m$breaks == hist.mm$breaks)) {
    mensaje <- mkmsj.v("los valores de hist.m$breaks no son los esperados", 
                       hist.m$breaks, hist.mm$breaks)
    warning("ej. 1.a - Tal vez no haya usado bien el argumento 'breaks'", call. = FALSE)
    stop(mensaje)
  }
  cat("revisando los breaks (hist.m) ... OK\n")

  if (!all(hist.h$breaks == hist.hh$breaks)) {
    mensaje <- mkmsj.v("los valores de hist.h$breaks no son los esperados", 
                       hist.h$breaks, hist.hh$breaks)
    warning("ej. 1.a - Tal vez no haya usado bien el argumento 'breaks'", call. = FALSE)
    stop(mensaje)
  }
  cat("revisando los breaks (hist.h) ... OK\n")

  TRUE
}

cor1.c <- function() {
  # Cargar 'datos'
  #   load('datos')
  source("hacemagia.R", local = TRUE)
  #   arch <- cut.script('1.c-cajas.R')
  arch <- cut.script("tmp.R")

  if (length(arch) == 0) # No hay nada escrito
    stop("el código no fue modificado (¿olvidó guardar sus cambios?)", call. = FALSE)

  magic$genero <- as.factor(magic$genero)
  levels(magic$genero) <- c("mujer", "hombre")
  #   eval(parse(text = arch))

  pline <- arch[grep("plot", arch)] # Identifica línea de plot o boxplot

  if (length(pline) == 0)
    stop("en su código no figuran las funciones plot o boxplot", call. = FALSE)
  cat("plot o boxplot ... OK\n")

  if (!grepl("main", pline))
    stop("en su código no figura el argumento necesario para poner título al plot", call. = FALSE)
  cat("argumento del título ... OK\n")

  if (!grepl("xlab", pline))
    stop("en su código no figura el arg. necesario para poner etiqueta en el eje horiz.", call. = FALSE)
  cat("argumento de la etiqueta del eje horiz. ... OK\n")

  if (!grepl("ylab", pline))
    stop("en su código no figura el arg. necesario para poner etiqueta en el eje vert.", call. = FALSE)
  cat("argumento de la etiqueta del eje vert. ... OK\n")


  cortado <- get.cortado(pline)
  main <- arget("main", cortado)
  xlab <- arget("xlab", cortado)
  ylab <- arget("ylab", cortado)
  data <- cortado[grep("data", cortado)]

  if (length(data) == 0)
    stop("en su código no figura el argumento 'data', ¿olvidó nombrarlo?", call. = FALSE)

  data <- gsub(" ", "", data)
  if (data != "data=magic")
    stop("no está asignando el objeto magic al argumento 'data'", call. = FALSE)
  cat("argumento 'data' ... OK\n")
      
  if (main != "Peso en funcion del genero") {
    msj <- mkmsj("el título del gráfico no es el esperado", main, "Peso en funcion del genero")
    stop(msj, call. = FALSE)
  }
  cat("texto del título ... OK\n")
      
  if (xlab != "Genero") {
    msj <- mkmsj("la etiqueta del eje horizontal no es la esperada", xlab, "Genero")
    stop(msj, call. = FALSE)
  }
  cat("etiqueta horizontal ... OK\n")

  if (ylab != "Peso (Kg)") {
    msj <- mkmsj("la etiqueta del eje vertical no es la esperada", ylab, "Peso (Kg)")
    stop(msj, call. = FALSE)
  }
  cat("etiqueta vertical ... OK\n")

  if (grepl("~", cortado[1])) {
    vars <- strsplit(cortado[1], "~")[[1]]
  } else {
    stop("el primer argumento debe ser una formula del tipo y ~ x", call. = FALSE)
  }
  cat("formula en el primer arg. ... OK\n")

  vars <- gsub(" ", "", vars)
  if (vars[1] != "peso")
    stop("la variable dependiente (eje vert.) no es 'peso', si no '", vars[1], "'", call. = FALSE)
  cat("variable y ... OK\n")

  if (vars[2] != "genero")
    stop("la variable independiente (eje horiz.) no es 'genero', si no '", vars[2], "'", call. = FALSE)
  cat("variable x ... OK\n")
      
  TRUE
}
