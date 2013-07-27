apr <- sum(cal >= 5)
p.apr <- 100 * apr / length(cal)
v <- cal[gen == 'V']
m <- cal[gen == 'M']
apr.v <- sum(v >= 5)
p.apr.v <- 100 * apr.v / length(v)
apr.m <- sum(m >= 5)
p.apr.m <- 100 * apr.m / length(m)
conteo <- c(sum(l1), sum(l2), sum(l3), sum(l4))
names(conteo) <- LETTERS[1:4]
save(gen, cal, apr, p.apr, v, m, apr.v, p.apr.v, apr.m, p.apr.m, conteo, ctg, file='ej2.rda')
