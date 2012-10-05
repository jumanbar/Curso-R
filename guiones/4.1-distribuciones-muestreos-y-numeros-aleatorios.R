
?Distributions

# Distibución Normal o Gaussiana

# dnorm : Función de Densidad de Probabilidad (PDF).
# pnorm : Función de Distribución de Probabilidad (CDF).
# qnorm : Función de Cuantiles.
# rnorm : Números aleatorios



# dnorm = densidad de probabilidad (PDF)
x <- seq(-3.5, 3.5, by = 0.01)
dy <- dnorm(x)
plot(x, dy, type = 'l', lwd = 2, main = "PDF (dnorm)")

py <- pnorm(x)
plot(x, py, type = 'l', lwd = 2, main = "CDF (pnorm)")

qy <- qnorm(py)
plot(py, qy, type = 'l', lwd = 2, main = "Cuantiles (qnorm)")

mean(qy - x)
all.equal(qy, x)


# Números aleatorios
r <- rnorm(1000)
mean(r)
sd(r)

sum(r <= 0) / length(r)
sum(r <= 1.96) / length(r)

summary(r)
qnorm(c(0.25, 0.75))

hist(r)

r <- rnorm(100)
densidad <- density(r)
plot(densidad, col = 3, lwd = 2)
hist(r, freq = FALSE, add = TRUE)
curve(dnorm(x), n=500, lwd=2, add=TRUE, col=2)
qqnorm(r)

## Función sample (muestreos aleatorios)
sample(1:5)
sample(5)
sample(c(6, 3.2, 7))

?sample
args(sample)

smps <- c('Homero', 'Marge', 'Bart', 'Lisa', 'Maggie')
sample(smps, 3, replace=TRUE)

sample(10.3)
sample(floor(10.3))
sample(-10.3)


# Argumento "prob"
x <- c('a', 'b', 'c')
p <- c(10,   5,   1)
m <- sample(x, size = 10000, replace = T, prob = p)

z <- table(m)
z
z['a'] / z['b']
z['a'] / z['c']

