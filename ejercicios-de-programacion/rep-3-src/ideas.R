setwd("~/projects/Curso-R/ejercicios-de-programacion/rep-2")
source('calificaciones.R')
# x <- rpois(267, 6)
# x[x > 12] <- 12
# x[x == 0] <- 1
# y <- sample(c('V', 'M'), length(x), replace=TRUE)
# write(x, 'cal.txt', length(x))
# write(y, 'gen.txt', length(y))
# cal <- scan('cal.txt')
# gen <- scan('gen.txt', what = 'character')

apr <- sum(cal >= 6)
apr.p <- 100 * apr / length(cal)

# 25% de notas más altas
tot <- length(cal)
a <- ceiling(tot * 0.75)
ordenado <- sort(cal)
altos <- ordenado[a:tot]

apr <- cal >= 6
tot <- length(cal)
apr.g <- gen[apr]
apr.v <- sum(apr.g == 'V')
apr.m <- length(apr.g) - apr.v
tot.v <- sum(gen == 'V')
tot.m <- tot - tot.v
apr.p <- round(100 * sum(apr) / tot, 2)
apr.v.p <- round(100 * apr.v / tot.v, 2)
apr.m.p <- round(100 * apr.m / tot.m, 2)

l1 <- cal <= 3
l2 <- cal > 3 & cal <= 6
l3 <- cal > 6 & cal <= 9
l4 <- cal > 9

ctg <- character(length(cal))
ctg[l1] <- 'A'
ctg[l2] <- 'B'
ctg[l3] <- 'C'
ctg[l4] <- 'D'

plot(c(sum(l1), sum(l2), sum(l3), sum(l4)), cex=2, pch=19)

d <- data.frame(franja=ctg, nota=cal, genero=gen)

ind <- order(d$nota)
d <- d[ind,]

hist(cal)
table(ctg)
plot(table(ctg))

notasM <- cal[gen == 'M']
notasH <- cal[gen == 'V']

g <- data.frame(gen = c('M', 'V'),
                nota.promedio = c(mean(notasM), mean(notasH)),
                nota.desvio = c(sd(notasM), sd(notasH)))  

summary(notasM)
summary(notasH)

plot(nota ~ factor(gen), d)

out <- list(dist=table(ctg), genero=g, datos=d)

str(out)

class(out) <- c('calif', class(out))
class(out)


print.calif <- function(x) {
  apr <- x$datos$nota >= 5
  tot <- nrow(x$datos)
  apr.g <- x$datos$genero[apr]
  apr.v <- sum(apr.g == 'V')
  apr.m <- length(apr.g) - apr.v
  tot.v <- sum(x$datos$genero == 'V')
  tot.m <- tot - tot.v
  apr.p <- round(100 * sum(apr) / tot, 2)
  apr.v.p <- round(100 * apr.v / tot.v, 2)
  apr.m.p <- round(100 * apr.m / tot.m, 2)
  cat('Porcentaje total de aprobaciones:', apr.p, '%\n')
  cat('  En varones:', apr.v.p, '%\n')
  cat('  En mujeres:', apr.m.p, '%\n')
  tb <- x$dist
  names(tb) <- c('1--3', '4--6', '7--9', '10--12')
  tabla <- capture.output(tb)
  cat('Cantidades por rangos de nota:\n')
  cat(' ', tabla[1], '\n')
  cat(' ', tabla[2], '\n')
  cat('Notas promedio:\n')
  cat('  Varones:', round(x$genero[2, 2], 2), '\n')
  cat('  Mujeres:', round(x$genero[1, 2], 2), '\n')
}

out
