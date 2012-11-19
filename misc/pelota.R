pelota <- function(n = 150, x = 0, y = 15, dy = 0, t.step = 0.05, 
                   r = 2, dx = 0.1, elast = 0.9, borrar = TRUE,
                   freno = 1e-4) {
  require(plotrix)
  y0 <- y
  x0 <- x
  fondo(x0, y0)
  dibuja(x, y, r, dy)
  for (i in 1:n) {
    cat('i =', i, '\r')
    x <- x + dx
    dx <- dx * (1 - freno)
    y <- y + dy
    if (y <= r) {
      dy <- - dy * elast
      y <- r
      if (borrar) {
        fondo(x0, y0)
      }
      dibuja(x, y, r, dy, TRUE)
    } else {
      dy <- dy - 9.8 * t.step ** 2
      if (borrar) {
        fondo(x0, y0)
      }
      dibuja(x, y, r, dy)
    }
    Sys.sleep(t.step * 0.5)
  }
  cat('\n')
}


dibuja <- function(x, y, r, dy, choque = FALSE ) {
  if (choque) {
    cfn <- dy * .2 / (1 + dy)
    draw.ellipse(x, (1 - cfn) * r, (1 + cfn) * r, (1 - cfn) * r,
                 lwd = 4, border = '#9933FF')
  } else {
    draw.ellipse(x, y, r, r,
                 lwd = 4, border = '#9933FF')
  }
}

fondo <- function(x0, y0) {
  par(mar = rep(0, 4))
  plot(NA, ylab = '', xlab = '', ylim = c(x0, y0), xlim =c(0, y0),
       bty = 'n', xaxt = 'n', yaxt = 'n')
  abline(h = 0, lwd = 4)
}
# pelota(170, elast = 0.65)
# pelota(170, elast = 0.7, borrar = FALSE)
pelota(100, elast = 0.7, dx = 0.2, borrar = FALSE) 


