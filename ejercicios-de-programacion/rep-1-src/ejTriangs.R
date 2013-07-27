ptri <- function(ang, hip, anim=TRUE, enpdf=FALSE) {
# Hace uno o varios plot (según valor de "anim") en los que se muestra una
# una circunferencia y un triángulo rectángulo circunscripto (cuya hipotenusa es
# el diámetro por supuesto).
# ang: ángulo entre el tercer vértice, el centro de la cfa y el extremo
# "derecho" de la hipotenusa.
# hip: hipotenusa o diámetro de la cfa
# anim: si se hacen varios o un sólo plot
# enpdf: si se guardan los plots en un pdf llamado "tri-cfa.pdf"
  cfa <- mkcfa(hip / 2)
  xy <- getpts(ang, hip)
  if (anim) {
    if (enpdf)
      pdf('tri-cfa.pdf')
    for (i in 1:length(ang)) {
      rg <- range(cfa) * 1.1
      plot(cfa, type='l', xlab='x', ylab='y', xlim=rg, ylim=rg)
      abline(v=0, h=0, col='blue')
      drawtri(xy=xy[i,], hip)
      points(xy[i, 1], xy[i, 2], pch=19)
      lines(c(0, xy[i, 1]), c(0, xy[i, 2]), lty=2)
    }
    if (enpdf)
      dev.off()
  } else {
    plot(cfa, type='l')
    drawtri(xy=xy[1,], hip)
    points(xy[,1], xy[1, 2], pch=19)
  }
}
mkcfa <- function(r) {
# Crea los puntos necesarios para graficar una circunferencia.
  tau <- 2 * pi
  theta <- seq(0, tau, len=200)
  x <- r * cos(theta)
  y <- r * sin(theta)
  matrix(c(x, y), ncol=2)
}
getpts <- function(ang, hip) {
# Calcula coordenadas en base al ángulo y la hipotenusa (= diámetro)
  x <- (hip / 2) * cos(ang)
  y <- (hip / 2) * sin(ang)
  cbind(x, y)
}

drawtri <- function(xy, hip) {
# Dibuja el triángulo en la cfa.
  x <- c(xy[1], - hip / 2, hip / 2, xy[1])
  y <- c(xy[2], 0, 0, xy[2])
  lines(x, y)
}

# Ejemplo: graficar 24 triángulos cincunscriptos:
h <- 10
tau <- 2 * pi
ang <- seq(0, tau / 2, len=24)
ptri(ang, h)
