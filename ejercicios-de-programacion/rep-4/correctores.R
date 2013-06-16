
###############################################################################

cor1.a <- function(dbg = FALSE) {
  # Cargar 'datos'
  if (!dbg)
    load('datos')
  source("hacemagia.R", local = TRUE)
  arch <- cut.script('1.a-genero.R')

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
  cat("niveles del factor ... OK\n")

  if (any(magic$genero != sex)) {
    msj <- mkmsj.v("los valores de magic$genero no son los esperados",
                   magic$genero, sex)
    stop(msj, call. = FALSE)
  }
  cat("valores del factor ... OK\n")

  TRUE
}


###############################################################################

cor1.b <- function() {
  # Cargar 'datos'
  load('datos')
  arch <- cut.script('1.b-hist.R')
  if (gsub(" ", "", arch[1]) == "hist.m<-0")
    stop("el código no fue modificado (¿olvidó guardar sus cambios?)", call. = FALSE)
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
  source("hacemagia.R", local = TRUE)
  magic$genero <- as.factor(magic$genero)
  levels(magic$genero) <- c("mujer", "hombre")

  png(tmp <- tempfile())
    hist.mmm  <- hist(magic$altura[magic$genero == "mujer"], breaks = 25)
    hist.hhh  <- hist(magic$altura[magic$genero == "hombre"], breaks = 25)
    hist.all <- hist(magic$altura, breaks = 15)
  dev.off()


  parlines <- grep("\\<par\\>", arch)
  if (!any(grepl("\\<par\\>", arch)))
    stop("la función par no figura en su código", call. = FALSE)
  cat("función par en el código ... OK\n")

  if (length(parlines) > 1) {
    arch <- arch[- parlines[2:length(parlines)]]
    warning("ej. 1.b: la función par aparecía varias veces, ", 
            "se descartan todas menos la primer ocurrencia", call. = FALSE)
  }
  arch <- c(arch, "opp <- par(mfcol = c(1, 1))") # en opp va a quedar mfcol siempre
  #   arch <- c(arch, "opp <- par(mfrow = c(1, 1))")
  png(tmp)
    eval(parse(text = arch))
  dev.off()
  unlink(tmp)

  if (!grepl("mfcol", arch[parlines[1]]) && !grepl("mfrow", arch[parlines[1]]))
    stop("no parece haber utilizado mfcol ni mfrow con la función par", call. = FALSE)
  cat("uso de mfcol/mfrow ... OK\n")
    #   if (!any(mf <- c("mfcol", "mfrow") %in% names(opp)))

  #   mf <- c("mfcol", "mfrow")[mf]

  if (!all(opp$mfcol == 2:1)) {
    mensaje <- mkmsj.v("los valores de mfcol/mfrow no son los esperados", opp$mfcol, 2:1)
    stop(mensaje)
  }
  cat("valor de mfcol/mfrow ... OK\n")

  if (identical(hist.m[1:4], hist.mmm[1:4]) && identical(hist.h[1:4], hist.hhh[1:4]))
    return(TRUE)

  if (!all(c(class(hist.m), class(hist.h)) %in% "histogram"))
    stop("la clase de alguno de los hist.x no es 'histogram'", call. = FALSE)
  cat("¿son los hist.x de clase histogram? ... OK\n")

  if (identical(hist.m[1:4], hist.all[1:4]))
    stop("su histograma hist.m tiene alturas de hombres y mujeres", call. = FALSE)
  if (identical(hist.h[1:4], hist.all[1:4]))
    stop("su histograma hist.h tiene alturas de hombres y mujeres", call. = FALSE)
  cat("¿se separan los datos de hombres y mujeres? ... OK\n")

  if (length(hist.m$breaks) != length(hist.mmm$breaks))
    stop("la longitud de hist.m$breaks no es la esperada en hist.m,\n",
         "tal vez no está usando correctamente el argumento correspondiente", call. = FALSE)
  cat("revisando los breaks (hist.m) ... OK\n")

  if (length(hist.h$breaks) != length(hist.hhh$breaks))
    stop("la longitud de hist.m$breaks no es la esperada en hist.m,\n",
         "tal vez no está usando correctamente el argumento correspondiente", call. = FALSE)
  cat("revisando los breaks (hist.h) ... OK\n")

  TRUE
}


###############################################################################

cor1.c <- function(dbg = FALSE) {
  # Cargar 'datos'
  if (!dbg)
    load('datos')
  source("hacemagia.R", local = TRUE)
  arch <- cut.script('1.c-cajas.R')
  if (length(arch) == 0) # No hay nada escrito
    stop("el código no fue modificado (¿olvidó guardar sus cambios?)", call. = FALSE)

  parsed <- parse(text = arch)
  arch <- as.character(parsed)
  #   arch <- cut.script("tmp.R")

# Ideas tomadas de lm para sacar ciertos valores... para usar en 2014?
  # a <- parsed[grep("plot", arch)]
  # mf <- match.call(lm, call = a)
  ###m <- match(c("formula", "data", "subset", "xlim", "ylim", "col"), names(mf))
  # m <- match(c("formula", "data", "subset"), names(mf))
  # mf <- mf[c(1L, m)]
  # mf[[1L]] <- as.name("model.frame")
  # mf <- eval(mf, parent.frame())
  #   magic$genero <- as.factor(magic$genero)
  #   levels(magic$genero) <- c("mujer", "hombre")
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
    stop("no está asignando correctamente el objeto magic al argumento 'data'", call. = FALSE)
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


###############################################################################


cor1.d <- function(dbg = FALSE) {
  # Cargar 'datos'
  if (!dbg)
    load('datos')
  source("hacemagia.R", local = TRUE)
  arch <- cut.script('1.d-regresion.R')
  parsed <- parse(text = arch)
  arch <- as.character(parsed)
  #   arch <- cut.script('tmp.R')
  if (gsub(" ", "", arch[1]) == "reg.a<-0")
    stop("el código no fue modificado (¿olvidó guardar sus cambios?)", call. = FALSE)

  magic$genero <- as.factor(magic$genero)
  levels(magic$genero) <- c("mujer", "hombre")
  pesox <- magic$peso
  magic$peso <- rnorm(nrow(magic), 95, 0.5)
  magic$peso[sample(nrow(magic), 3)] <- 95
  eval(parsed)
  reg.aaa <- lm(altura ^ 2 ~ peso - 1, magic)
  reg.bbb <- lm(altura ^ 2 ~ peso - 1, magic, subset = peso < 95)
  ## altura esperada
  aeee <- sqrt(coef(reg.bbb) * p)
  ## R ^ 2
  rrr2 <- summary(reg.bbb)$r.squared

  if (class(reg.a) != "lm")
    stop("la clase de reg.a no es lm", call. = FALSE)
  cat("clase de reg.a ... OK\n")

  if (length(reg.a$residuals) != nrow(magic))
    stop("resid(reg.a) tiene ", length(reg.a$residuals),
         " elementos, distinto a nrow(magic): ", nrow(magic), call. = FALSE)
  cat("cantidad de valores ... OK\n")

  if (attr(reg.a$terms, "intercept") == 1) # si no tiene intercepto
    stop("hizo la reg.a con intercepto, debe hacerse sin", call. = FALSE)
  cat("intercepto en reg.a ... OK\n")

  if (!all(reg.a$model[[1]] == magic$altura ** 2)) {
    if (all(reg.a$model[[1]] == magic$altura))
      warning("parece que no elevó altura al cuadrado", call. = FALSE)
    stop("los valores de la variable de respuesta (altura ^ 2) en reg.a no son los esperados", call. = FALSE)
  }
  cat("variable de respuesta reg.a ... OK\n")

  if (!all(reg.a$model[[2]] == magic$peso)) # los valores de la variable explicativa están bien? 
    stop("los valores de la variable explicativa (peso) en reg.a no son los esperados", call. = FALSE)
  cat("variable explicativa reg.a ... OK\n")

  if (length(coef(reg.a)) > 1) # Hay demasiados coeficientes?
    stop(mkmsj("la reg.a tiene demasiados coef.", length(coef(reg.a)), 1), call. = FALSE)
  cat("length(coef(reg.a)) ... OK\n")

  if (class(reg.b) != "lm")
    stop("la clase de reg.b no es lm", call. = FALSE)
  cat("clase de reg.b ... OK\n")

  if (!all(reg.b$model[[2]] < 95))
    stop("las observaciones utilizadas en reg.b no cumplen con la condición: eliminar pesos >= 95", call. = FALSE)
  cat("filtrado por pesos ... OK\n")

  if (attr(reg.b$terms, "intercept") == 1) # si no tiene intercepto
    stop("hizo la reg.b con intercepto, debe hacerse sin", call. = FALSE)
  cat("intercepto en reg.b ... OK\n")

  alturax <- magic$altura[magic$peso < 95]
  if (!all(reg.b$model[[1]] == alturax ** 2)) {
    if (all(reg.b$model[[1]] == alturax))
      warning("parece que no elevó altura al cuadrado", call. = FALSE)
    stop("los valores de la variable de respuesta (altura ^ 2) en reg.b no son los esperados", call. = FALSE)
  }
  cat("variable de respuesta reg.b ... OK\n")

  peso <- magic$peso[magic$peso < 95]
  if (!all(reg.b$model[[2]] == peso)) # los valores de la variable explicativa están bien? 
    stop("los valores de la variable explicativa (peso) en reg.b no son los esperados", call. = FALSE)
  cat("variable explicativa reg.b ... OK\n")

  if (length(coef(reg.b)) > 1) # Hay demasiados coeficientes?
    stop(mkmsj("la reg.b tiene demasiados coef.", length(coef(reg.b)), 1), call. = FALSE)
  cat("length(coef(reg.b)) ... OK\n")

  ## altura esperada
  if (length(ae) != length(p))
    stop(mkmsj("la longitud de ae no es la esperada", length(ae), length(p)))
  cat("longitud de ae ... OK\n")

  if (!all(ae == aeee)) {
    if (all(ae == sqrt(coef(reg.a) * p)))
      warning("parece que usó la reg.a en lugar de reg.b para hallar ae", call. = FALSE)
    if (all(ae == coef(reg.bbb) * p))
      warning("parece que no ha hecho la raíz cuadarada para hallar ae", call. = FALSE)
      msj <- mkmsj.v("los valores de ae no son los esperados", ae, aeee)
    stop(msj, call. = FALSE)
  }
  cat("valores de ae ... OK\n")
  
  ## R^2
  if (!(is.numeric(r2) && length(r2) == 1))
    stop("o bien r2 no es un número o es un vector de más de 1 elemento", call. = FALSE)
  cat("propieadades de r2 ... OK\n")

  if (r2 != rrr2) {
    if (r2 == summary(reg.bbb)$adj.r.squared)
      warning("está usando el R^2 ajustado, en lugar del R^2 normal", call. = FALSE)
    if (r2 == summary(reg.a)$r.squared)
      warning("está usando el R^2 de la reg.a, en lugar de reg.b", call. = FALSE)
    stop(mkmsj("el valor de r2 no es el esperado", r2, rrr2), call. = FALSE)
  }
  cat("valor de r2 ... OK\n")

  TRUE
}

###############################################################################

cor1.e <- function() {
  load("datos")
  source("hacemagia.R", local = TRUE)
  magic$genero <- as.factor(magic$genero)
  levels(magic$genero) <- c("mujer", "hombre")
  arch <- cut.script('1.e-dispersion.R')
  #   arch <- cut.script('tmp.R')
  parsed <- parse(text = arch)
  arch <- as.character(parsed)

  on.exit({
    devs <- dev.list()
    if (any(names(devs) == "png")) {
      devs <- devs[grepl("png", names(devs))] 
      for (i in devs)
        dev.off(i)
    }
  })

  plotline <- grep("plot", arch)
  pointsline <- grep("points", arch)
  ablline <- grep("ablline", arch)

  if (any(plotline > c(pointsline, ablline)))
    stop("hay al menos una función gráfica de bajo nivel antes de la función de alto nivel", call. = FALSE)
  cat("HL plot primero ... OK\n")

  pesoline <- grep("sbs.peso", arch[pointsline])

  if (pointsline[pesoline] < pointsline[- pesoline])
    warning("los outliers se grafican antes que los valores de los hombres, a diferencia de la fig. 4", call. = FALSE)
  
  png(tmp <- tempfile())
    eval(parsed)
  dev.off()
  unlink(tmp)

  if (length(unique(cols)) < 3) {
    a <- unique(cols)
    stop("el vector cols no tiene tres valores distintos, si no sólamente ", length(a), ": ", 
         paste(a, collapse = " "), call. = FALSE)
  }
  cat("vector cols ... OK\n")

  if (length(unique(pchs)) < 3) {
    a <- unique(pchs)
    stop("el vector pchs no tiene tres valores distintos, si no sólamente ", length(a), ": ", 
         paste(a, collapse = " "), call. = FALSE)
  }
  cat("vector pchs ... OK\n")

  if (xlim[1] > min(magic$peso)) {
    warning("se utilizó una nueva data.frame magic para la corrección", call. = FALSE)
    stop("el límite inferior en el eje horizonal del gráfico es demasiado alto", call. = FALSE)
  }
  if (xlim[2] < max(magic$peso)) {
    warning("se utilizó una nueva data.frame magic para la corrección", call. = FALSE)
    stop("el límite superior en el eje horizonal del gráfico es demasiado bajo", call. = FALSE)
  }
  cat("vector xlim ... OK\n")
  
  if (ylim[1] > min(magic$altura ^ 2)) {
    warning("se utilizó una nueva data.frame magic para la corrección", call. = FALSE)
    stop("el límite inferior en el eje vertical del gráfico es demasiado alto", call. = FALSE)
  }
  if (ylim[2] < max(magic$altura ^ 2)) {
    warning("se utilizó una nueva data.frame magic para la corrección", call. = FALSE)
    stop("el límite superior en el eje vertical del gráfico es demasiado bajo", call. = FALSE)
  }
  cat("vector ylim ... OK\n")

  if (ltys[1] == 1)
    stop("la línea vertical parece ser contínua", call. = FALSE)
  if (ltys[2] != 1)
    stop("la línea inclinada parece no ser contínua", call. = FALSE)
  cat("vector ltys ... OK\n")

  ### sbs.muj 
  if (sum(sbs.muj) != nrow(magic) / 2)
    stop("la cantidad de TRUEs en sbs.muj no es igual a nrow(magic) / 2", call. = FALSE)
  cat("sum(sbs.muj) ... OK\n")

  if (!all(magic$genero[sbs.muj] == "mujer"))
    stop("los valores de magic$genero[sbs.muj] no son todos 'mujer'", call. = FALSE)
  cat("magic$genero[sbs.muj] .. OK\n")
  
  ### sbs.peso
  spl <- grep("^sbs.peso", arch)
  magic$peso <- rnorm(nrow(magic), 95, 0.5)
  sbs.peso <- eval(parsed[spl])
  if (sum(sbs.peso) != sum(magic$peso >= 95)) {
    msj <- ifelse(sum(sbs.peso) > sum(magic$peso >= 95), "demasiado alto", "demasiado bajo")
    warning("ej. 1.e: el valor de sum(sbs.peso) es ", msj, call. = FALSE)
    stop("la cantidad de TRUEs en sbs.peso no es la esperada", call. = FALSE)
  }
  cat("sum(sbs.peso) ... OK\n")

  if (!all(magic$peso[sbs.peso] >= 95))
    stop("los valores de magic$peso[sbs.peso] no son todos >= 95", call. = FALSE)
  cat("magic$genero[sbs.peso] .. OK\n")
  
  ### sbs.hom
  if (sum(sbs.hom) != nrow(magic) / 2)
    stop("la cantidad de TRUEs en sbs.hom no es igual a nrow(magic) / 2", call. = FALSE)
  cat("sum(sbs.hom) ... OK\n")

  if (!all(magic$genero[sbs.hom] == "hombre"))
    stop("los valores de magic$genero[sbs.hom] no son todos 'hombre'", call. = FALSE)
  cat("magic$genero[sbs.hom] .. OK\n")

  TRUE
}

