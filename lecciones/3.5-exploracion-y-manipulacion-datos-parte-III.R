## Trabajo con tablas: una introducción (parte I)


### Gráficos de visualización para datos

# El objetivo de esta lección es brindar los elementos más básicos y
# universales posibles para poder visualizar nuestros datos en los gráficos
# en R. Muchas veces es recomendable hacer un análisis visual de nuestros
# datos para tener una idea de como estos se relacionan frente a nuestras 
# inquietudes. Para esto existen gráficos exploratorios en R que dan cuenta de 
# esta necesidad.

# La función 'plot' nos sirve para un pantallazo general de un data.frame
plot(iris)

# Como veremos en la siguiente unidad, la función 'plot' la utilizamos
# generalmente para graficar por ejemplo dos variables que queremos relacionar.
# Pero en este caso en vez de insertar como argumento una fórmula[1] estamos
# poniendo una base de datos. La función nos retorna un gráfico en donde se
# relacionan todas las variables del data.frame entre si. Como puede observarse
# en la diagonal se encuentran las variables, por lo que este gráfico
# es simétrico y puede leerse de la diagonal hacia arriba o hacia abajo.

# Por ejemplo, si queremos ver como se correlaciona el ancho del pétalo en 
# función del largo del pétalo debemos fijarnos en la gráfica de la cuarta fila
# y tercer columna.

# Por otro lado si lo que nos interesa es el largo de pétalo en función del 
# ancho del pétalo debemos fijarnos en la gráfica de la tercer fila y cuarta 
# columna.

# Una función que nos devuelve un gráfico casi idéntico al anterior pero
# con un agregado es:

pairs(iris, panel = panel.smooth)

# En este tipo de gŕafico se puede observar una línea roja suavizada que
# da cuenta de la relación entre ambas variables. La línea suavizada nos
# ayuda muchas veces a visualizar mejor la correlación de los datos. Vea la 
# ayuda de la función pairs para más opciones de esta útil herramienta.

# La función 'coplot' nos retorna un gráfico de dispersión para dos variables
# separado por cada una de las clases o grupos.  Por ejemplo:
coplot(Sepal.Length ~ Sepal.Width | Species, data=iris)

# La función 'boxplot' realiza gráficos del tipo boxplot o "box and
# whisker diagram". Este requiere de una fórmula que consiste en una
# variable y en función de la variable categórica, y ~ x. Es decir que la
# variable x es del tipo 'factor'.
boxplot(Sepal.Width ~ Species, data=iris)
boxplot(Sepal.Length ~ Species, data=iris)
boxplot(Petal.Width ~ Species, data=iris)
boxplot(Petal.Length ~ Species, data=iris)

# Cada caja contiene el 75% de los datos, la línea negra es la mediana (50%
# de los datos), los 'bigotes' o las líneas que sobresalen tanto por debajo
# como por arriba son los valores equivalentes al valor del extremo de la caja 
# - o + 1.5 * RQ (donde RQ = rango intercuartílico: 3er. cuartil - 1er. cuartil)
# respectivamente y los puntos son valores atípicos u "outliers".

# Por último, la función 'hist' nos devuelve un histograma de los datos en un 
# vector:
hist(iris$Sepal.Length)
hist(iris$Sepal.Width)

# Este nos permite observar como se distribuyen los datos, por ejemplo si
# estos tienen una distribución aproximable a una Normal, Uniforme u otra.


## Resumen

# Estas funciones sencillas permiten tener visualizaciones muy informativas de 
# nuestros datos y por lo tanto son parte del arsenal básico que conviene 
# manejar casi siempre que usamos R.


# [1]
# Las fórmulas en R son una clase de objeto muy particular (¡otra más!), la 
# cual será explorada en mayor profundidad en la unidad siguiente.
