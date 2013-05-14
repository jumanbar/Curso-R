## Extra: graficos simples para visualizar datos


## Gráficos simples para visualizar datos

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
# Aquí vemos la relación entre Sepal.Length y Sepal.Width para los tres 
# niveles del factor "Species", dados por la data.frame iris. Debido a que se 
# trata de una variable categórica, no se ve ninguna superposición en el 
# panel de arriba, pero esto cambia si usamos otra base de datos, en la que la 
# variable condicional es numérica (y continua). Veamos lo que pasa cuando 
# graficamos la ubicación geográfica de sismos cercanos a Fiji desde 1964, 
# dada la variable condicional "depth":
coplot(lat ~ long | depth, data = quakes)

# Como se ve aquí, los intervalos utilizados para cada gráfico de abajo se 
# superponen para distintos valores de profundidad ('depth'). Utilizando 
# varios argumentos de la función es posible controlar el grado de 
# superposición y el número de intervalos. En particular, para saber los 
# rangos de dichos intervalos se puede usar la función co.intervals:
co.intervals(quakes$depth)
# Nota: en este caso se trata de los valores por defectos. Vea la 
# documentación de "coplot" para comprender mejor cómo manipular las salidas 
# de estas dos funciones.

# La función 'boxplot' realiza gráficos del tipo boxplot o "box and
# whisker diagram". Este requiere de una fórmula que consiste en una
# variable y en función de la variable categórica, y ~ x. Es decir que la
# variable x es del tipo 'factor' (aunque esto no es del todo estricto). Por 
# ejemplo los valores de Sepal.Width por especie en la base iris se pueden
# visualizar así:
boxplot(Sepal.Width ~ Species, data=iris)

# Nota: cuando usamos la misma sintaxis pero con la función plot, en caso de 
# que x sea factor, se grafica lo mismo:
plot(weight ~ group, PlantGrowth)


# Cada caja contiene el 75% de los datos, la línea negra es la mediana (50%
# de los datos), los 'bigotes' o las líneas que sobresalen tanto por debajo
# como por arriba son los valores equivalentes al valor del extremo de la caja 
# - o + 1.5 * RIC (donde RIC = rango intercuartílico: 3er. cuartil - 1er. cuartil)
# respectivamente y los puntos son valores atípicos u "outliers". Ver también:
browseURL('https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Boxplot.svg/500px-Boxplot.svg.png')

# Por último, la función 'hist' nos devuelve un histograma de los datos en un 
# vector:
hist(iris$Sepal.Length)
hist(iris$Sepal.Length, breaks = 15)

# Este nos permite observar como se distribuyen los datos, por ejemplo si
# estos tienen una distribución aproximable a una Normal, Uniforme u otra.
# Nótese el uso del argumento breaks para determinar la cantidad de intervalos 
# en los que se hace conteo de ocurrencias.

## Resumen

# Estas funciones sencillas permiten tener visualizaciones muy informativas de 
# nuestros datos y por lo tanto son parte del arsenal básico que conviene 
# manejar casi siempre que usamos R.


# [1]
# Las fórmulas en R son una clase de objeto muy particular (¡otra más!), la 
# cual será explorada en mayor profundidad en la unidad siguiente.

