promedio <- mean(x)

mi.otro.vector <- c(45, -76, 3, 4, 5, 6, 0.333)
# o 
mi.otro.vector <- c(45, -76, 3:6, 0.333)

mi.vector[2:3] <- c(100, 104)
# o
mi.vector[c(2, 3)] <- c(100, 104)

mi.vector[6:1]

mi.vector[length(mi.vector):1]
