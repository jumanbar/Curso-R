# Funciones para crear mensajes...
# Eventualmente se podrían convertir en funciones genéricas...

mkmsj <- function(msj.base = "", obs, esp) {
  # msj.base: mensaje indicando en qué objeto está el error,
  #           ej.: El or XXX no coincide con lo esperado
  #           nota: se agrega una coma y un \n al final.
  # obs, esp: ores observado y esperado respect.
  if (obs == esp)
    return(TRUE)
  output <- c(obs, esp)
  output <- c(as.character(obs), as.character(esp))
  names(output) <- c("Valor observado", "Valor esperado")
  output <- capture.output(print(output))
  mensaje <- c(paste(msj.base, ",\n", sep=""),
               "la diferencia observada es la siguiente:\n\n", 
               paste("  ", output, "\n", sep = ""))
  mensaje
}
objetos$generales <- c(objetos$generales, "mksmsj")


mkmsj.v <- function(msj.base = "", vec.obs, vec.esp, tol = 1e-8) {
  # msj.base: mensaje indicando en qué objeto está el error,
  #           ej.: El vector XXX no coincide con lo esperado
  #           nota: se agrega una coma y un \n al final.
  # vec.obs, vec.esp: vectores observado y esperado respect.
  donde <- which(vec.obs != vec.esp)
  dif <- rep(NA, length(donde))
  tabla <- cbind(vec.obs[donde], vec.esp[donde])
  if (is.factor(vec.obs))
    tabla <- cbind(as.character(vec.obs[donde]), as.character(vec.esp[donde]))
  colnames(tabla) <- c("Valor observado", "Valor esperado")
  if (is.null(names(vec.obs)))
    rownames(tabla) <- paste("Posición ", donde, ":", sep = "")
  if (is.numeric(vec.obs)) {
    dif <- abs(tabla[,1] - tabla[,2])
    tabla <- cbind(tabla, Dif. = dif)
    tabla <- tabla[dif > tol, , drop=FALSE]
    if (nrow(tabla) == 0)
      return(FALSE)
  }
  if (c1 <- nrow(tabla) > 10)
    tabla <- tabla[1:10,]
  op <- options(digits = 10)
  output <- capture.output(print(tabla))
  options(op)
  if (msj.base != "")
    msj.base <- paste(msj.base, ",\n", sep="")
  mensaje <- c(msj.base,
               "las diferencias observadas son las siguientes:\n\n", 
               paste("  ", output, "\n", sep = ""))
  if (c1)
    mensaje <- c(mensaje, "(se muestran sólo las primeras 10 diferencias)\n")
  mensaje
}
objetos$generales <- c(objetos$generales, "mkmsj.v")


mkmsj.m <- function(msj.base = "", m.obs, m.esp, tol = 1e-8) {
  # msj.base: mensaje indicando en qué objeto está el error,
  #           ej.: La matriz XXX no coincide con lo esperado
  #           nota: se agrega una coma y un \n al final.
  # m.obs, m.esp: matrices observadas y esperadas respect.
  donde <- which(m.obs != m.esp, arr.ind = TRUE)
  dif <- rep(NA, nrow(donde))
  tabla <- cbind(donde, m.obs[donde], m.esp[donde], dif)
  colnames(tabla) <- c("Fila", "Columna", "Valor observado", "Valor esperado", "Dif.")
  if (is.numeric(m.obs)) {
    dif <- abs(tabla[,3] - tabla[,4])
    tabla[,5] <- dif
    tabla <- tabla[dif > tol, , drop=FALSE]
    if (nrow(tabla) == 0)
      return(FALSE)
  } else {
    tabla <- tabla[,-5]
  }
  if (c1 <- nrow(tabla) > 10)
    tabla <- tabla[1:10,]
  op <- options(digits = 10)
  output <- capture.output(print(tabla))
  options(op)
  if (msj.base != "")
    msj.base <- paste(msj.base, ",\n", sep="")
  mensaje <- c(msj.base,
               "las diferencias observadas son las siguientes:\n\n", 
               paste("  ", output, "\n", sep = ""))
  if (c1)
    mensaje <- c(mensaje, "(se muestran sólo las primeras 10 diferencias)\n")
  mensaje
}
objetos$generales <- c(objetos$generales, "mkmsj.m")


mkmsj.df <- function(msj.base = "", df.obs, df.esp, tol = 1e-8) {
  # msj.base: mensaje indicando en qué objeto está el error,
  #           ej.: La data.frame XXX no coincide con lo esperado
  #           nota: se agrega una coma y un \n al final.
  # df.obs, df.esp: data.frames observadas y esperadas respect.
  donde <- which(df.obs != df.esp, arr.ind = TRUE)
  dif <- rep(NA, nrow(donde))
  tabla <- cbind(donde, df.obs[donde], df.esp[donde], dif)
  tabla[,2] <- colnames(df.obs)[donde[,2]]
  colnames(tabla) <- c("Fila", "Columna", "Valor observado", "Valor esperado", "Dif.")
  num <- sapply(df.obs, is.numeric)
  dnum <- num[donde[,2]]
  if (any(dnum)) {
    drow <- donde[dnum, 1]
    dcol <- donde[dnum, 2]
    num.obs <- numeric(sum(dnum))
    num.esp <- numeric(sum(dnum))
    for (i in 1:sum(dnum)) {
      num.obs[i] <- df.obs[drow[i], dcol[i]]
      num.esp[i] <- df.esp[drow[i], dcol[i]]
    }
    dif[dnum] <- abs(num.obs - num.esp)
    tabla[dnum,3] <- num.obs 
    tabla[dnum,4] <- num.esp 
    tabla[,5] <- dif
    sel <- dif > tol
    if (!any(sel))
      tabla <- tabla[,-5]
    sel[is.na(sel)] <- TRUE
    tabla <- tabla[sel, , drop=FALSE]
    if (nrow(tabla) == 0)
      return(FALSE)
  }
  if (c1 <- nrow(tabla) > 10)
    tabla <- tabla[1:10,]
  op <- options(digits = 10)
  output <- capture.output(print(tabla))
  options(op)
  if (msj.base != "")
    msj.base <- paste(msj.base, ",\n", sep="")
  mensaje <- c(msj.base,
               "las diferencias observadas son las siguientes:\n\n", 
               paste("  ", output, "\n", sep = ""))
  if (c1)
    mensaje <- c(mensaje, "(se muestran sólo las primeras 10 diferencias)\n")
  mensaje
}
