tfinal <- 1000
l <- 1
pos <- rep.int(0, tfinal)
posAll <- matrix(
for(j in 1:100) {
  for(i in 2:tfinal) {

    moneda <- sample(c(-1,1), 1 )
    pos[i] <- pos[i - 1] + l * moneda
  }
}
plot(pos, type='l', pch=20)
