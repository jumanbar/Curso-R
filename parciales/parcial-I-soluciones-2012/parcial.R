# a.

magic <- read.csv('datos.csv')

# b.

age <- rpois(nrow(magic), lambda = 22)

# c.

magic$age <- age

# d.

magic$sex <- as.factor(magic$sex)
levels(magic$sex) <- c('mujer', 'hombre')

# e.

agef <- cut(age, 3)
magic$agef <- agef

# f.

levels(magic$agef) <- c("novatos", "intermedios", "expertos")

# g.

names(magic) <- c('peso', 'sexo', 'altura', 'edad', 'edadf')

# h.

plot(peso ~ sexo, magic, xlab = 'Sexo', ylab = 'Peso (Kg)', 
     main = 'Peso en función del sexo')

# i.

peso.sexo <- aov(peso ~ sexo, magic)

# j.

peso.hombre <- sum(coef(peso.sexo))

peso.mujer <- coef(peso.sexo)[1]

# k.

plot(I(altura ** 2) ~ peso, magic, ylab = 'Altura ^ 2 (m^2)', xlab = 'Peso (Kg)')

# l.

altura.peso <- lm(I(altura ^ 2) ~ peso - 1, magic)

# m.

altura.peso2 <- lm(I(altura ^ 2) ~ peso - 1, magic, subset = peso < 120)

# n.

p <- seq(40, 120, by = 0.5)

ae <- sqrt(p * coef(altura.peso2))

# o.

s <- summary(altura.peso2)
r2 <- s$r.squared

# p.

abline(altura.peso, lty = 2, lwd = 2)
abline(altura.peso2, lty = 1, lwd = 2)

# q.

abline(v = 120, lwd = 2, lty = 3, col = 8)

# r.

points(I(altura ^ 2) ~ peso, magic, pch = 18, cex = 1.5, subset = peso >= 120)

# s.

magic$IMC <- magic$peso / magic$altura ^ 2

# t.

write.table(magic, 'magic.csv', sep = ',', row.names = F)
