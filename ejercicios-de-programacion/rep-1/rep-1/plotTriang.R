plotTriang <- function() {
  a <- c(2, 6)
  b <- c(2, 5)
  
  plot(a, b, pch=19, ylim=c(0, max(b) + 1), xlim=c(0, max(a) + 2), xlab='x', ylab='y')
  segments(x0=a[1], y0=b[1], x1=a[2], y1=b[2], lwd=2.5)
  segments(x0=a[1], y0=b[1], x1=a[2], y1=b[1], lty=2, lwd=2.5)
  segments(x0=a[2], y0=b[1], x1=a[2], y1=b[2], lty=2, lwd=2.5)
  
  text(a[1] - 0.3, b[1] - 0.2, labels="A", cex=2)
  text(a[2] + 0.3, b[2] + 0.2, labels="B", cex=2)
  text(a[2] + 0.3, b[1] - 0.2, labels="C", cex=2)
  text(mean(a), b[1] - 0.4, labels=expression((x[B] - x[A])), cex=1.5)
  text(a[2] + 1, mean(b), labels=expression((y[B] - y[A])), cex=1.5)
  text(mean(a) - .2, mean(b) + .2, labels='h', cex=1.5)
  
  cat("Coordenadas: A = (x_A, y_A) & B = (x_B, y_B)\n")
}
