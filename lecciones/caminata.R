# Preparación:
pos <- 0
x <- pos
# Loop:
while (abs(pos) <= 10) {
  pos <- pos + rnorm(1)
  x <- c(x, pos)
}
plot(x, xlab = "Nro. de iteración", 
     ylab = "Posición del borracho", 
     type = "o", pch = 20)

