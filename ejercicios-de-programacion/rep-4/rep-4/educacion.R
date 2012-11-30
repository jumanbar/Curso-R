educacion <- function(x, tmcol, pacol, tacol) {
  TM <- apply(x[, tmcol], 1, mean, na.rm=T)
  PA <- apply(x[, pacol], 1, mean, na.rm=T)
  TA <- x[, tacol]
  PC <- TM * PA / 100
  x <- cbind(x, TM, PA, PC)
  regresion <- lm(TA ~ PC)
  coeficientes <- coef(regresion)
  
  # Salida gráfica opcional:
  plot(TA ~ PC, xlab = "Tasa de conclusión de primaria", ylab = "Tasa de Alfabetización")
  abline(regresion, col = "green", lwd = 2)
  
  salida <- summary(regresion)
  r2 <- salida$r.squared
  p.valor <- salida$coefficients[, 4]
  return(list(coeficientes=coeficientes, p.valor=p.valor, r2=r2, datos=x))
}

