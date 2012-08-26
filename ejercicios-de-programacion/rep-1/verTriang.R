h <- 10
tau <- 2 * pi
ang <- seq(0, tau / 2, len=24)
x <- (h / 2) * cos(ang)
y <- (h / 2) * sin(ang)
for (i in 1:length(sca)) {
  a <- area(ca[i], co[i])
}

ptri <- function(ang, hip, anim=TRUE, enpdf=FALSE) {
  cfa <- mkcfa(hip / 2)
  xy <- getpts(ang, hip)
  if (anim) {
    if (enpdf)
      pdf('~/Desktop/Rplots.pdf')
    for (i in 1:length(ang)) {
      plot(cfa, type='l')
      drawtri(xy=xy[i,], hip)
      points(xy[i, 1], xy[i, 2], pch=19)
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
  tau <- 2 * pi
  theta <- seq(0, tau, len=200)
  x <- r * cos(theta)
  y <- r * sin(theta)
  matrix(c(x, y), ncol=2)
}
getpts <- function(ang, hip) {
  x <- (hip / 2) * cos(ang)
  y <- (hip / 2) * sin(ang)
  cbind(x, y)
}
drawtri <- function(xy, hip) {
  x <- c(xy[1], - hip / 2, hip / 2, xy[1])
  y <- c(xy[2], 0, 0, xy[2])
  lines(x, y)
}
