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
# X11() under UNIX (y Windows)
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
op <- par(mar=c(5, 6, 4, 2))

# Aća estoy cambiando el tamaño de los margenes del gráfico. En este caso
# sólamente los dos primeros valores que equivalen al margen inferior y al
# margen izquierdo.
# Estos números están puestos en sentido horario, empezando por el margen
# inferior (inf, izq., arr, der).
# Es común guardar en un objeto (en este caso "op") la salida para volver a usar
# los parámetros originales luego.

# Un ejemplo en el que se manipulan muchos parámetros...
plot(x, cex=1.5, cex.axis=1.2, cex.lab=2.1, col.lab='green', type='o', lwd=3,
xlab="ejemplo", ylab="numeros", main="Ejem-plot")

# Jugando con los valores de cada uno se puede ver el significado de los mismos
# (en general los nombres buscan ser informativos).

# En caso de no entender el uso o las opciones posibles, en la ayuda de "par" o
# "plot" van a poder encontrar la documentación necesaria.

# Si guaramos la salida de par, podemos recuperar los parámetros originales:
par(op)

# Algunos parámetros se pueden sólo manejar con par directamente:
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
# lwd // line width // ancho de la línea (número)
# pch // point character // tipo de punto (números o caracteres entre comillas)
# type // tipo... ('p', 'l', 'b', 'o', 'n', 's' y otros)
# lty // line type // tipo de línea (1, 2, 3, ...)
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


# OPCIONES COMUNES

# Veremos tres formas comunes en que se suelen ajustar los gráficos: colores,
# superposición de líneas/puntos y gráficos múltiples.

# 1. Colores en los gráficos
# El parámetro "col", usado dentro de la función "plot" (u otras funciones de
# gráficos) establece el color de lo graficado. Es un parámetro versátil, ya que
# acepta números, strings (palabras) o códigos RGB... veamos.

# Si se usan los enteros del 1 al 8 los colores ploteados son estos:
palette()
# Podemos visualizarlo con este comando:
plot(1:8, col=1:8, pch=19, cex=4)
 
# Hay muchos nombres de colores posibles, los cuales se pueden conocer con la
# funcion "colors":
?colors
colors()
 
# Para visualizarlos:
length(colors()) # 657 =~ 26 ^ 2
mat <- matrix(1:(26 ^ 2), 26, 26)
image(mat, col=colors())
 
# También existen algunas funciones que generan gradientes de colores
# preestablecidos, por ejemplo "gray", "rainbow", "terrain.colors",
# "heat.colors":
image(mat, col=terrain.colors(26 ^ 2))
image(mat, col=terrain.colors(26 ^ 2))
image(mat, col=rainbow(26 ^ 2))
image(mat, col=gray(seq(0, 1, , 26 ^ 2))) # este necesita valores entre 0 y 1
image(mat, col=heat.colors(26 ^ 2))

# Es posible usar colores definidos por códigos de RGB. Estos se escriben con un
# "#" y 3 valores en hexagesimal (son 6 dígitos, 2 para Red, 2 para Green y 2
# para Blue).

# Ejemplo:
curve(sin(x) / x, from=-20, to=20, lwd=15, col='#5D5EB6')
# Existen programas y páginas web para elegir colores que devuelven el código
# RGB:
browseURL('http://www.colorpicker.com/')


# 2. Superposición de líneas/puntos

# Muchas veces queremos agregar varias series de datos a la misma gráfica. Los
# comandos para hacer esto son "points" y "lines". Por ejemplo:
x <- sort(rnorm(100, 0))
y <- sort(rnorm(100, 1))
plot(x, type='o')
points(y, col='green') # Agrega un nuevo conjunto de puntos.
lines(y, col='green', lwd=1.5) # Líena que une puntos.

# En este punto es necesario hacer una distinción importante: en R existen
# comandos gráficos de "alto nivel" y de "bajo nivel". En inglés los
# términos son "high level" y "low level" plots (HL y LL de aquí en más).

# Los HL son comandos capaces de hacer plots nuevos. Algunos ejemplos son
# "plot", "curve" o "hist".

# Los LL son comandos que sólo pueden agregar elementos a un plot existente.
# Algunos ejemplos son "points", "lines" o "legend".

# Comandos HL comunes:
# curve ---> para graficar funciones matemáticas de una variable.
# Ejemplos:
curve(sin(x), from=-4, to=4)                        # Función seno.
curve(x ^ 3 - 4 * x ^ 2 + 3 * x - 1, from=-8, to=8) # Polinomio de grado 3.
# En el primer argumento se escribe una función con x como variable.

# Nota: algunos comandos se pueden convertir en LL si se usa la opción
# add=TRUE. Por ejemplo, para agregar otra función al gráfico anterior:
curve(200 * cos(x), col='magenta')
# Función coseno.

# Comandos LL comunes:
# Ya vimos el uso de lines y points para agregar líneas/puntos a un gráfico
# existente. Existen muchas otras funciones para agregar elementos a un
# gráfico. Varias sirven para trabajar con objetos "geométricos" (líneas,
# puntos, segmentos, polígonos...), pero también existen funciones para
# agregar texto o leyendas. Vamos a mostrar algunos casos de cada uno.

# abline ---> agregar líneas rectas a un gráfico.
# Es un comando LL muy útil y ampliamente utilizado.
# Ejemplos:
plot(Sepal.Length ~ Sepal.Width, subset=Species == 'setosa', data=iris)
# Nótese el uso de los argumentos subset y data para especificar los datos que
# quiero graficar.
# Ahora, para agregar líneas horizontales:
abline(h=5) # Una línea recta horizontal cortando el eje y en el 5...
abline(v=4) # Una línea recta vertical cortando el eje x en el 4...
# Para graficar otros tipos de rectas se usan 2 parámetros: intercepto y
# pendiente:
abline(1.5, 1, col=3) # Intercepto: 1.5 / Pendiente: 1

# Finalmente, si hago una regresión lineal puedo agregar el resultado a un
# gráfico usando abline:
regresion <- lm(Sepal.Length ~ Sepal.Width, subset=Species == 'setosa', data=iris)
abline(regresion, col='seagreen', lwd=3)
# Nótese la similitud entre el comando usado para hacer la regresión y el
# usado para hacer el plot original... Veremos más sobre esto en la lección
# sobre estadística.

# legend ---> agregar una leyenda a un plot.
# Ejemplo:
plot(1:25, pch=1:25, cex=4, main='Distintos tipos de puntos')
legend('topleft', legend=1:13, pch=1:13, title='Código', bty='n', inset=0.01,
       cex=1.2)
legend('bottomright', legend=14:25, pch=14:25, title='Código', bty='n',
       inset=0.01, cex=1.2)
# Las palabras claves "top", "bottom", "left" y "right" (arriba, abajo,
# izquierda y derecha) se pueden usar y/o combinar para establecer el lugar de
# la leyenda (opcionalmente se pueden dar coordenadas).

legend(5, 15, legend='hola', pch=14)

# text ---> agregar texto a un gráfico
plot(1:25, pch=1:25, cex=4, main='Distintos tipos de puntos', ylim=c(0, 29))
text(1:25, 1:25 + 3, labels=1:25)
# Los 2 primeros argumentos son las coordenadas, mientras que labels es el texto
# que nos interesa agregar.
text(10.5, 27, labels='Los números indican el código correspondiente a cada punto',
     adj=.5)


# 3. Gráficos múltiples
# Usando el argumento "mfcol" o "mfrow", dentro de "par" podemos hacer varios
# plots juntos:
op <- par(mfrow=c(2, 2))

# Esto inicia una ventana gráfica con 4 lugares, 2 filas y 2 columnas
# Al usar mfrow los gráficos van llenando la ventana por fila:
boxplot(Sepal.Width ~ Species, data=iris)
boxplot(Sepal.Length ~ Species, data=iris)
boxplot(Petal.Width ~ Species, data=iris)
boxplot(Petal.Length ~ Species, data=iris)
par(op)


# OTRAS HERRAMIENTAS ÚTILES

# Visualización de la normalidad de un conjunto de datos:
x <- rnorm(100)
qqnorm(x) # Cuantiles teóricamente esperados vs. cuantiles observados
qqline(x) # Línea 1:1
 
# dotchart: el ejemplo es bastante ilustrativo:
countries <- c("South Africa", "Egypt", "Nigeria", "Algeria", "Morocco",
               "Angola", "Libya", "Tunisia", "Kenya", "Ethiopia", "Ghana",
               "Cameroon")
gdp <- c(285.4, 188.4, 173, 140.6, 91.4, 75.5, 62.3, 39.6, 29.4, 28.5, 26.2,
         22.2)
# GDP: Gross Domestic Product == PBI: Producto Bruto Interno

dotchart(rev(gdp), rev(countries),
         xlab="GDP in billions of US dollars",
         main="African Countries by GDP",
         xlim=max(gdp)*c(.038,1.02), pch=20)

# coplot:
coplot(Sepal.Length ~ Sepal.Width | Species, data=iris)

# matplot:
matplot(iris[,-5], type='l', lwd=2, lty=1,
        main='Ancho & Largo / Sépalo & Pétalo',
        xlab='Número de Observación',
        ylim=c(0, 9))
abline(v=c(50, 100) + 0.5, lty=2)
abline(h=8.7, col=8)
text(c(25, 75, 125), 9, labels=levels(iris$Species), font=2)
legend(-5, 8.6, legend=names(iris)[-5], col=1:4, lty=1, lwd=4,
       bty='n', inset=0.01)


# ¡Bonus!

# Otras herramientas gráficas existen y se crean todo el tiempo en la
# comunidad R. Existen muchos paquétes de gráficos muy populares que son
# bastante más sofisticados que los gráficos por defecto de R, uno de ellos es
# "ggplot2", sobre el cual no vamos a profundizar en este curso.

# Por otro lado, RStudio viene con la función manipulate, que sirve para hacer
# gráficos interactivos. Es necesario cargar el paquete homónimo primero...
library(manipulate)
?manipulate
 
# Trabaja con tres funciones llamadas "slider", "picker" y "checkbox"
# que sirven para variables continuas, listas de opciones y cajas de chequeo
manipulate(
  curve(sin(a * x) * x, from=-5, to=5),
  a = slider(1, 15)
)
# Para modificar el gráfico alcanza con cliquear el ícono con forma de tuerca 
# que aparece en la esquina superior izquierda y mover el control.
 
# Para ver como funcionan:
?slider
?picker
?checkbox
 
# Si me interesa puedo agregar otro parámetro para manipular,
# se agrega con comas.
manipulate(
  curve(sin(a * x) * x, from=-5, to=5, n=presicion), # Atención a las comas y
  a = slider(1, 30),                        # paréntesis
  presicion = slider(51, 3001) # Acá no va coma...
)
 
# Ejemplo con picker
manipulate(
  curve(dnorm(x, sd=desvio), from=-20, to=20, col=color),
  desvio = slider(1, 10),
  color = picker(2, 3, 'blue')
)
 
# Ejemplo con checkbox
x <- rnorm(1e4)
manipulate(
  hist(x, breaks=breaks.number, freq=freq.check),
  breaks.number = slider(10, 100),
  freq.check = checkbox(FALSE)
)


# Para terminar la lección les mostramos un ejemplo de las cosas que pueden
# encontrarse hoy en día y que cualquiera puede empezar a usar con un poco de
# maña y cabeza:

# Se trata de un paquete creado por google (google además de usar muchísimo R
# para analizar las ingentes cantidades de información que obtiene de nosotros
# los usuarios, también genera paquetes de R muy interesantes):
 
# (fuente original)
browseURL('http://r-ecology.blogspot.com/2011/01/r-and-google-visualization-api-fish.html')
 
# Bajar la "Tabla de pesquerías" dispuesta en el EVA, guardarla en el directorio
# de trabajo actual de R (ver con getwd()).

# Para instalar los paquetes necesarios:
install.packages('ggplot2')
install.packages('googleVis')
install.packages('Hmisc')

# Para cargar dichos paquetes:
library(ggplot2)
library(googleVis)
library(Hmisc)

# leer los datos, suponiendo que están en el directorio de trabajo actual:
fish  <- read.csv("fishharvest.csv")
fish2 <- melt(fish, id=1:3, measure=4:24)
year  <- rep(1985:2005, each = 117)
fish2 <- data.frame(fish2, year) # reemplaza year con valores reales
 
# Google visusalization API
fishdata <- data.frame(subset(fish2, fish2$var == "quantity_1000lbs", -4),
                       value_1000dollars=subset(fish2, fish2$var ==
                       "value_1000dollars", -4)[,4])
names(fishdata)[4] <- "quantity_1000lbs"
fishharvest <- gvisMotionChart(fishdata, idvar="species", timevar="year")
plot(fishharvest) # El plot se abre en un navegador web automáticamente
