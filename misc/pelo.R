pelo <- function(n = 20, x = 0, y = 150, dy = 0, r = 15) {
  require(plotrix)
  plot(NA, ylim = c(0, 150), xlim =c(0, 150), ylab = 'Y', xlab = 'X')
  draw.ellipse(x, y, r, r)
  abline(h = 0, lwd = 4)
  for (i in 1:n) {
    Sys.sleep(0.07)
    cat('i =', i, '\r')
    x <- x + 3.0
    y <- y - dy
    if (y < r) {
      dy = - dy
      draw.ellipse(x, 0.8 * r, 1.2 * r, 0.8 * r)
    } else {
      dy = dy * 0.97 + 1.2
      draw.ellipse(x, y, r, r)
    }
  }
  cat('\n')
}
pelo(60)
