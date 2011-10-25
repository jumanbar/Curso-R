
# GRÁFICOS: UNA INTRODUCCIÓN
# Aclaramos que se trata de una introducción al conocimiento en general, ya que
# el universo de los gráficos posibles en R es muy, muy vasto. Pueden
# profundizar sobre este tema a través de los "links de interés" dispuestos en
# la sección "recursos".

# El objetivo de esta lección es brindar los elementos más básicos y universales
# posibles para trabajar con gráficos en R.
# Una práctica recomendable es la de escribir los pasos necesarios para lograr
# el gráfico que deseamos en un script de R (con extensión ".R"), de forma tal
# que se pueden hacer cambios paso por paso y lograr resultados bastante
# complejos y reproducibles. 
 
# Para abrir una nueva ventana en la consola de R:
# X11() under UNIX
# windows() under Windows
# and quartz() under Mac OS X
# Esto sirve para poder visualizar mas de un gráfico en R.
 
# PARÁMETROS DE GRÁFICOS
# par
# Es el conjunto de los parámetros gráficos, las funciones de plot de los
# objetos generados en R, le pasan sus argumentos a la función par, la mayoría a
# través del argumento especial "...", cuando se ejecutan.
#
?par

# Un ejemplo introductorio... 
# Creo un vector para plotear
x <- sort(rnorm(100))
# Uso "mar" para agrandar el margen izquierdo... "mar" es un argumento que
# acepta como opción un vector numérico con 4 valores
# (por defecto mar=c(5, 4, 4, 2) + .1). Este vector define el tamaño de los 4
# márgenes de la ventana del gráfico.
op <- par(mar=c(5, 6, 4, 2)) # Aća estoy cambiando el tamaño de los margenes
                             # del gráfico. En este caso estoy cambiando los dos
                             # primeros valores que equivalen al margen
                             # inferior y al margen izquierdo. El oreden de
                             # los margenes es a partir del inferior en sentido
                             # horario.
                             # Es común guardar en un objeto (en este caso "op")
                             # la salida para volver a usar los parámetros
                             # anteriores luego.
                             
# Un ejemplo en el que se ajustan muchos parámetros...
plot(x, cex=1.5, cex.axis=1.2, cex.lab=2.1, col.lab='green', type='o', lwd=3,
xlab="ejemplo", ylab="numeros", main="Ejem-plot")
# Jugando con los valores de cada uno pueden ver el significado de cada uno
# (en general los nombres buscan ser informativos).
# En caso de no entender el uso o las opciones posibles, en la ayuda de "par" o
# "plot" van a poder encontrar la documentación necesaria.
par(op) # vuelven los parámetros anteriores a la ventana de gráficos.

## GRÁFICOS: UNA INTRODUCCIÓN

# Aclaramos que se trata de una introducción, ya que el universo de los gráficos posibles en R es muy,
# muy vasto. Pueden profundizar sobre este tema a través de los "links de interés" dispuestos en la
# sección "recursos".
# El objetivo de esta lección es brindar los elementos más básicos y universales posibles para trabajar
# con gráficos en R.
 
# Una práctica recomendable es la de escribir los pasos necesarios para lograr el gráfico que deseamos
# en un script de R (con extensión ".R"), de forma tal que se pueden hacer cambios paso por paso y
# lograr resultados bastante complejos y reproducibles. 
 
# Para abrir una nueva ventana:
# X11() under UNIX
# windows() under Windows
# and quartz() under Mac OS X
 
# PARÁMETROS DE GRÁFICOS
# par
# Es el conjunto de los parámetros gráficos, las funciones de plot le pasan sus argumentos, la
# mayoría a través del argumento especial "...", cuando se ejecutan.
#
?par
 
# Creo un vector para plotear
x <- sort(rnorm(100))
# Uso "mar" para agrandar el margen izquierdo... "mar" es un argumento que acepta como opción un
# vector numérico con 4 valores (por defecto mar=c(5, 4, 4, 2) + .1).
op <- par(mar=c(5, 6, 4, 2)) # Es común guardar en un objeto la salida para volver a usar los
                             # parámetros anteriores luego
# Un ejemplo en el que se ajustan muchos parámetros...
plot(x, cex=1.5, cex.axis=1.2, cex.lab=2.1, col.lab='green', type='o', lwd=3, xlab="ejemplo", ylab="numeros", main="Ejem-plot")
# Jugando con los valores de cada uno pueden ver el significado de cada uno (en general los nombres
# buscan ser informativos).
# En caso de no entender el uso o las opciones posibles, en la ayuda de "par" o "plot" van a poder
# encontrar la documentación necesaria.
par(op) # vuelven los parámetros anteriores a la ventana de gráficos.


# Ahora quiero agregar nuevos puntos al gráfico
y <- sort(rnorm(100, 1))
points(y, col='green', lwd=6)
lines(y, col='red', lwd=3)

 
# Ahora quiero agregar nuevos puntos al gráfico...
y <- sort(rnorm(100, 1))
points(y, col='green', lwd=6) # Agrega un nuevo conjunto de puntos.
lines(y, col='red', lwd=3) # Líena que une puntos.
 

 
# COLORES EN LOS GRAFICOS
# El parámetro "col", usado dentro de la función "plot" (u otras funciones de
# gráficos) establece el color de lo graficado. Es un parámetro versátil, ya que
# acepta números, strings (palabras) o códigos RGB...
# Si se usan los enteros del 1 al 8 los colores ploteados son estos:
palette()
 
# Hay muchos nombres de colores posibles, los cuales se pueden conocer con la
# funcion "colors":

# COLORES EN LOS GRAFICOS
# El parámetro "col", usado dentro de la función "plot" (u otras funciones de gráficos) establece
# el color de lo graficado. Es un parámetro versátil, ya que acepta números, strings (palabras) o
# códigos RGB...
 
# Si se usan los enteros del 1 al 8 los colores ploteados son estos:
palette()
 
# Hay muchos nombres de colores posibles, los cuales se pueden conocer con la funcion "colors":

?colors
colors()
 
# Para visualizarlos:
length(colors()) # 657
mat <- matrix(1:(26 * 26), 26, 26)
image(mat, col=colors())
 

# También existen algunas funciones que generan gradientes de colores
# preestablecidos, por ejemplo:

# También existen algunas funciones que generan gradientes de colores preestablecidos, por ejemplo:

# gray, rainbow, terrain.colors, heat.colors
image(mat, col=terrain.colors(26 * 26))
image(mat, col=terrain.colors(26 * 26))
image(mat, col=rainbow(26 * 26))
image(mat, col=gray(seq(0, 1, , 26 * 26))) # este necesita valores entre 0 y 1
image(mat, col=heat.colors(26 * 26))
 

# Es posible usar colores definidos por códigos de RGB. Estos se escriben con un
# "#" y 3 valores en hexagesimal (son 6 dígitos, 2 para Red, 2 para Green y 2
# para Blue).

# Ejemplo:
curve(sin(x) / x, from=-20, to=20, lwd=15, col='#5D5EB6')
# Existen programas y páginas web para elegir colores que devuelven el código
# RGB:
browseURL('http://www.colorpicker.com/')
 

# Es posible usar colores definidos por códigos de RGB. Estos se escriben con un "#" y 3 valores
# en hexagesimal (son 6 dígitos, 2 para Red, 2 para Green y 2 para Blue).
# Ejemplo:
curve(sin(x) / x, from=-20, to=20, lwd=15, col='#5D5EB6')
# Existen programas y páginas web para elegir colores que devuelven el código RGB:
browseURL('http://www.colorpicker.com/')
 
 

# Algunos parámetros se pueden sólo manejar con par directamente
# "ask",
# "fig", "fin",
# "lheight",
# "mai", "mar", "mex", "mfcol", "mfrow", "mfg",
# "new",
# "oma", "omd", "omi",
# "pin", "plt", "ps", "pty",
# "usr",
# "xlog", "ylog"
 
# Argumentos de uso común:
# col (.axis, .lab, .main, .sub) // colores
# lwd // line width // ancho de la línea
# pch // point character // tipo de punto
# type // tipo...
# lty // line type // tipo de línea
# xlab // x axis label // grosor del eje x
# ylab // y axis label // grosor del eje x
# main // main title // título principal
# sub // sub label
# cex (.axis, .lab, .main, .sub) // magnificación
# mar=c(bottom, left, top, right) // margin // margenes
# oma=c(bottom, left, top, right) // outer margin // orden de aparición de los
                                                   # margenes
# mfcol, mfrow // "matrix figure" // varios gráficos en una sola ventana
# log // escala logarítmica ?
# xlog // escala log en eje x?
# ylog // escala log en eje y?

# Usando el argumento "mfcol" o "mfrow", dentro de "par" podemos hacer varios
# plots juntos:
op <- par(mfrow=c(2, 2))
# Esto inicia una ventana gráfica con 4 lugares, 2 filas y 2 columnas
# Al usar mfrow los gráficos van llenando la ventana por fila
boxplot(Sepal.Width ~ Species, data=iris)
boxplot(Sepal.Length ~ Species, data=iris)
boxplot(Petal.Width ~ Species, data=iris)
boxplot(Petal.Length ~ Species, data=iris)
par(op)

##############################
# High level y Low level plots:
# HL hacen plots nuevos.
# LL agregan cosas a plots existentes: líneas, leyendas, texto, polígonos...
 
# Primero genero un vector que va a ser utilizado para establecer los colores de
iris$Species -> spp
tabulate(spp) -> tab
paleta <- rep(2:4, tab)
# Alternativamente se pude hacer:
paleta <- unclass(iris$Species) + 1
 
# plot es HL (nuevo gráfico)
# col, pch son argumentos, opciones que "plot" pasa a "par"
plot(Sepal.Length ~ Sepal.Width, data=iris, col=paleta, pch=19)
lm1 <- lm(Sepal.Length ~ Sepal.Width, data=iris, subset=Species == 'setosa')
lm2 <- lm(Sepal.Length ~ Sepal.Width, data=iris, subset=Species == 'versicolor')
lm3 <- lm(Sepal.Length ~ Sepal.Width, data=iris, subset=Species == 'virginica')
# abline es LL (agrega una recta)
abline(lm1, col=2, lwd=2)
abline(lm2, col=3, lwd=2)
abline(lm3, col=4, lwd=2)
# legend es LL
legend('topleft', bty='n', legend=levels(spp), col=2:4, pch=19)
 
# La función curve sirve para graficar funciones.
# El primer argumento usa una función de x.
?curve
curve(x ^ 2, from=-5, to=5) # from y to son los límites de evaluación
curve(sin(x), from=-5, to=5)
curve(sin(x) / x, from=-5, to=5, n=1000) # n es el número de puntos evaluados
# Usando la opción add=TRUE curve actúa como una low level
curve(cos(x), from=-5, to=5, add=TRUE, col=2, n=6)


# Hay varios tipos de funciones de plot especializadas:
coplot(Sepal.Length ~ Sepal.Width | Species, data=iris)
 

matplot(iris[,-5], type='l', lwd=2, lty=1)

############################## 
# BONUS


# RStudio viene con la función manipulate, que sirve para hacer gráficos
# más interactivos. Es necesario cargar el paquete homónimo primero...
library(manipulate)
?manipulate
 
# Trabaja con tres funciones llamadas "slider", "picker" y "checkbox"
# que sirven para variables continuas, listas de opciones y cajas de chequeo
manipulate(
  curve(sin(a * x) * x, from=-5, to=5),
   a = slider(1, 15)
)
 
# Para ver como funcionan:
?slider
?picker
?checkbox
 
# Si me interesa puedo agregar otro parámetro para manipular,
# se agrega con comas.
manipulate(
  curve(sin(a * x) * x, from=-5, to=5, n=b), # Atención a las comas y
   a = slider(1, 30),                         # paréntesis
   b = slider(101, 3001) # Acá no va coma...
)
 
# Ejemplo con picker
manipulate(
  curve(dnorm(x, sd=a), from=-20, to=20, col=b),
   a = slider(1, 10),
   b = picker(2, 3, 'blue')
)
 
# Ejemplo con checkbox
x <- rnorm(1e4)
manipulate(
  hist(x, breaks=a, freq=b),
   a = slider(10, 100),
   b = checkbox(FALSE)
)

# Otras herramientas gráficas existen y se crean todo el tiempo en la
# comunidad R. Existen muchos gráficos muy populares que son bastante más
# sofisticados que los gráficos por defecto de R, uno de ellos es "ggplot2",
# sobre el cual no vamos a profundizar en este curso.
 

# Para terminar la lección les mostramos un ejemplo de las cosas que pueden
# encontrarse hoy en día y que cualquiera puede empezar a usar con un poco de
# maña y cabeza:
 
# Se trata de un paquete creado por google (sí, google además de usar muchísimo
# R para analizar las ingentes cantidades de información que obtiene de nosotros
# los usuarios, también genera paquetes de R muy interesantes):
 
# (fuente original)
browseURL('http://r-ecology.blogspot.com/2011/01/r-and-google-visualization-api-
fish.html')
 
# Bajar la "Tabla de pesquerías" dispuesta en el EVA, guardarla en el directorio
# de trabajo actual de R.
 
# Cargar estos paquetes (si no están instalados usar RStudio o install.packages
# ("paquete") para instalarlos).

# Hay varios tipos de funciones de plot especializadas:
coplot(Sepal.Length ~ Sepal.Width | Species, data=iris)
 
matplot(iris[,-5], type='l', lwd=2, lty=1)
 
# Usando el argumento "mfcol" o "mfrow", dentro de "par" podemos hacer varios plots juntos:
op <- par(mfrow=c(2, 2))
# Esto inicia una ventana gráfica con 4 lugares, 2 filas y 2 columnas
# Al usar mfrow los gráficos van llenando la ventana por fila
boxplot(Sepal.Width ~ Species, data=iris)
boxplot(Sepal.Length ~ Species, data=iris)
boxplot(Petal.Width ~ Species, data=iris)
boxplot(Petal.Length ~ Species, data=iris)
par(op)
 
# Visualización de la normalidad de un conjunto de datos:
x <- rnorm(100)
qqnorm(x) # Cuantiles teóricamente esperados vs. cuantiles observados
qqline(x) # Línea 1:1
 
# dotchart
countries <- c("South Africa", "Egypt", "Nigeria", "Algeria",
"Morocco", "Angola", "Libya", "Tunisia", "Kenya", "Ethiopia",
"Ghana", "Cameroon")
gdp <- c(285.4, 188.4, 173, 140.6, 91.4, 75.5, 62.3,
39.6, 29.4, 28.5, 26.2, 22.2)
dotchart(rev(gdp), rev(countries),
    xlab="GDP in billions of US dollars",
    main="African Countries by GDP",
    xlim=max(gdp)*c(.038,1.02), pch=20)
 
 
# Otras herramientas gráficas existen y se crean todo el tiempo en la comunidad R. Existen muchos
# muy populares que son bastante más sofisticados que los gráficos por defecto de R, uno de ellos
# es "ggplot2", sobre el cual no vamos a profundizar en este curso.
 
# Para terminar la lección les mostramos un ejemplo de las cosas que pueden encontrarse hoy en día
# y que cualquiera puede empezar a usar con un poco de maña y cabeza:
 
# Se trata de un paquete creado por google (sí, google además de usar muchísimo R para analizar las
# ingentes cantidades de información que otiene de nosotros, los usuarios, también genera paquetes
# de R muy interesantes):
 
# (fuente original)
browseURL('http://r-ecology.blogspot.com/2011/01/r-and-google-visualization-api-fish.html')
 
# Bajar la "Tabla de pesquerías" dispuesta en el EVA, guardarla en el directorio de trabajo actual de R
 
# Cargar estos paquetes (si no están instalados usar RStudio o install.packages("paquete") para
# instalarlos).

library(ggplot2)
library(googleVis)
library(Hmisc)
 
fish  <- read.csv("fishharvest.csv") # leer los datos (suponiendo que están en
                                     # el directorio correcto)
fish2 <- melt(fish, id=1:3, measure=4:24) # melt table
year  <- rep(1985:2005, each = 117)
fish2 <- data.frame(fish2, year) # reemplaza year con valores reales
 
# Google visusalization API
fishdata <- data.frame(subset(fish2, fish2$var == "quantity_1000lbs", -4),
                       value_1000dollars=subset(fish2, fish2$var ==
                       "value_1000dollars", -4)[,4])
names(fishdata)[4] <- "quantity_1000lbs"
fishharvest <- gvisMotionChart(fishdata, idvar="species", timevar="year")
plot(fishharvest) # El plot se abre en un navegador web automáticamente
