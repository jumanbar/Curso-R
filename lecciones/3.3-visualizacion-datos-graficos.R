
## Gráfico de visualización para datos

# El objetivo de esta lección es brindar los elementos más básicos y
# universales posibles para poder visualizar nuestros datos en los gráficos
# en R.  Muchas veces es recomendable hacer un análisis visual de nuestros
# datos para tener una idea visual de como estos se relacionana frente a
# nuestras inquietudes.  Para esto existen gráficos exploratorios en R que
# dan cuenta de esta necesidad.
 
# La función 'plot' nos sirve para realizar estos análisis exploratorios...
plot(iris)

# Como veremos en la siguiente unidad, la función 'plot' la utilizamos
# generalmente para graficar por ejemplo dos variables que queremos relacionar.
# Pero en este caso en vez de incertar como argumento una fórmula estamos
# poniendo una base de datos.  La función nos retorna un gráfico en donde se
# relacionan todas las variables del data.frame entre si.  Como puede observarse
# en la diagonal se encuentran las variables, por lo que este gráfico
# es simétrico y puede leerse de la diagonal hacia arriba o hacia abajo.
# Depende de que variable quiéramos que sea x e y.

# Por ejemplo, si queremos ver como se correlaciona el ancho del pétalo en 
# función del largo del pétalo debemos fijarnos en la gráfica de la cuarta fila
#  y tercer columna.
# Por otro lado si lo que nos interesa es el largo de pétalo en función del 
# ancho del pétalo debemos fijarnos en la gráfica de la tercer fila y cuarta 
# columna.

# Una función que nos devuelve un gráfico casi idéntico al anterior pero
# con un agregado es:

pairs(iris, panel = panel.smooth)

# En este tipo de gŕafico se puede observar una línea roja suavizada que
# da cuenta de la relación entre ambas variables.  La línea suavizada nos
# ayuda muchs veces a visualizar mejor la correlación de los datos.

# La función 'coplot' nos retorna un gráfico de dispersión para dos variables
# separado por cada una de las clases o grupos.  Por ejemplo:
coplot(Sepal.Length ~ Sepal.Width | Species, data=iris)

# La función 'boxplot' realiza gráficos del tipo boxplot o box and
# whisker diagram.  Este requiere de una fórmula que consiste en una
# variable y en función de la variable grupos, y ~ grp.  Es decir que la
# variable x es del tipo 'factor'.
boxplot(Sepal.Width ~ Species, data=iris)
boxplot(Sepal.Length ~ Species, data=iris)
boxplot(Petal.Width ~ Species, data=iris)\
boxplot(Petal.Length ~ Species, data=iris)

# Cada caja contiene el 75% de los datos, la línea negra es la mediana (50%
# de los datos), los 'bigotes' o las líneas que sobresalen tanto por debajo
# como por arriba son los valores mínimos y máximos respectivamente y los
# puntos son valores extremos.

# Por último, la función 'hist' nos devuelve un histograma.
hist(iris$Sepal.Length) hist(iris$Sepal.Width)

# Este nos permite observar como se distribuyen los datos, por ejemplo si
# estos tienen una distribución Normal, Uniforme u otra.


## EXTRA

# Algunos gráfico avanzados que también nos dan una idea general de como
# se relacionan nuestros datos los podemos realizar utilizando los paquetes
# 'MASS' y 'lattice'.

# Por ejemplo, utilizando el paquete 'lattice'. (recuerde para utilizar una
# función específica de un paquete, ud. deberá cargarlo previamente: 
# install.packages("lattice") por si no lo han instalado y library(lattice)
# para cargarlo posteriormente).

xyplot(Sepal.Length ~ Sepal.Width | Species, data=iris)

# Es un gráfico 'similar' al primero que vimos, sólo que más sofisticado en
# cuanto a los comandos que requiere y a la imagen que devuelve.  Además es
# específico para las dos variables que le especificamos y a su vez nos separa
# los gráficos según los grupos.

xyplot(Sepal.Length ~ Sepal.Width | Species, data=iris, panel=function (x,y){
  panel.xyplot(x, y, col=1, cex=1.2, pch=1) panel.lmline(x, y, col=3, lwd=3,
  lty=2) panel.loess(x,y, col=2, lwd=1.5) })

# Es igual sólo que agrega el modelo teórico en línea verde rayada y la
# curva suavizada en linea roja continua.
