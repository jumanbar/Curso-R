cl <- function() {
  cal <- rpois(260 + sample(20, 1), 6)
  cal[cal > 12] <- 12
  cal[cal == 0] <- 1
  cal
}

gn <- function(cal)
  sample(c('V', 'M'), length(cal), replace=TRUE)

ct <- function(cal) {
  n <- length(cal)
  out <- character(n)
  out[cal <= 3] <- 'A'
  out[3 < cal & cal <= 6] <- 'B'
  out[6 < cal & cal <= 9] <- 'C'
  out[9 < cal] <- 'D'
  out
}

Print.listaCalif <- function(x) {
  cat('Porcentaje total de aprobaciones:', round(x$aprob$atot, 2), '%\n')
  cat('  En varones:', round(x$aprob$avar, 2), '%\n')
  cat('  En mujeres:', round(x$aprob$amuj, 2), '%\n')
  #===== Su código comienza aquí: =====#
  ptot <- mean(x$tabla$nota)
  pvar <- mean(x$tabla$nota[x$tabla$genero == 'V'])
  pmuj <- mean(x$tabla$nota[x$tabla$genero == 'M'])
  #====== Aquí finaliza su código =====#
  cat('La nota promedio fue de:', round(ptot, 2), '\n')
  cat('  En varones:', round(pvar, 2), '\n')
  cat('  En mujeres:', round(pmuj, 2), '\n')
  cnt <- x$conteo

  if (all(is.na(as.numeric(conteo))))
		stop('x$conteo no tiene números si no cadenas de caracteres')

  names(cnt) <- c('1--3', '4--6', '7--9', '10--12')
  cat('Conteos por franja de nota:\n')
  print(cnt)
}

nr <- 1e5
o <- numeric(nr)
tol <- 1e-15
for (i in 1:nr) {
  cal <- cl()
  p <- sum(cal >= 5)
  p1 <- 100 * p / length(cal)
  p2 <- 100 * (p / length(cal))

  if (p1 - p2 > tol)
    o[i] <- p1 - p2
}
o <- o[o != 0]
