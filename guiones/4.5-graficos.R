plot(x, cex=1.5, cex.axis=1.2, cex.lab=2.1, col.lab='green', type='o', lwd=3, xlab="ejemplo", ylab="numeros", main="Un ejemplito")

length(colors()) # 657 es aprox. 26 ^ 2
mat <- matrix(1:(26 ^ 2), 26, 26)
image(mat, col=colors())

image(mat, col=terrain.colors(26 ^ 2))
image(mat, col=rainbow(26 ^ 2))
image(mat, col=gray(seq(0, 1, , 26 ^ 2))) # este necesita valores entre 0 y 1
image(mat, col=heat.colors(26 ^ 2))
