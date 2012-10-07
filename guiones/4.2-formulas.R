## Fórmulas

variable.de.respuesta ~ variables.explicativas

?formula

regresion_simple <- lm(variable.de.respuesta ~ variables.explicativas, data=DataFrame)

x <- runif(20, 5, 30)          # variable explicativa
y <- 1.3 * x + rnorm(20, sd=3) # variable de respuesta
y ~ x

y ~ 1 + x

form <- y ~ x
class(form)
plot(form)       # grafica los datos y ~ x
lm(form)         # regresión lineal
abline(lm(form)) # visualización del modelo de regresión

form2 <- y ~ - 1 + x # o
form2 <- y ~ x - 1   # o
form2 <- y ~ x + 0

class(form2)
plot(form2)
lm(form2)                  # nótese que solo nos brinda el parámetro pendiente
abline(lm(form))           # la recta anterior...
abline(lm(form2), col = 2) # nótese en donde corta el nuevo gráfico

z <- rnorm(20, -6, 10)
y ~ x + z # Agrega efectos aditivos, no interaccion
y ~ x * z # Agrega efectos aditivos, no interaccion
y ~ x + z + x:z # Ídem que el anterior, más explícito

r1 <- lm(y ~ x + z)
w <- cbind(x, z)
r1 <- lm(y ~ w)
r2 <- lm(y ~ x * z)

# Función I
y ~ x + z    # "y en función de x y z"
y ~ I(x + z) # "y en función de la suma de x y z"

y1 ~ a + I(b + c)
y2 ~ a + b + c
# ¿Cuántas variables explicativas tienen los modelos y1 e y2?

# maneras:
y ~ u + v + w + u:v + u:w + v:w + u:v:w
y ~ u * v * w
y ~ (u + v + w) ^ 3
# Son tres formas distintas de decir lo mismo: y es función de las variables u, v, w y de todas las interacciones posibles.

# Si queremos quitar la interacción de tres vías, cualquiera de las tres siguientes es válida:
y ~ u + v + w + u:v + u:w + v:w
y ~ u * v * w - u:v:w
y ~ (u + v + w) ^ 2

# El tipo de variable explicativa que se utiliza (binarias, categórica (factores) o numérica) determina la naturaleza del análisis.

y ~ u + v

y ~ A + x

r1 <- lm(Sepal.Length ~ Sepal.Width, data=iris)
r2 <- lm(Sepal.Length ~ Petal.Length * Petal.Width, data=iris)




