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

# Cuando se realiza un gráfico en la consola de R, este nos abre una nueva
# ventana con el gráfico resultante. Sin embargo, cuando realizamos un nuevo
# gráfico no se abre otra ventana: el nuevo sustituye al anterior. En este 
# sentido, para no perder el grafico previo es necesario abrir una nueva 
# ventana en la consola de R y así poder tener ambos gráficos para visualizarlos
# Para abrir una nueva ventana en la consola de R:
# X11()        para UNIX (y Windows)
# windows()    para Windows
# and quartz() para Mac OS X
# Esto sirve para poder visualizar más de un gráfico en R.
# En RStudio esto no es problema, dado que en la ventana 'Plot' es posible
# visualizar más de un gráfico. A medida que vamos realizando distintos
# gráficos, estos se van almacenando en dicha ventana sin la necesidad de
# tener que abrir una nueva ventana en la consola por cada uno. A su vez,
# tiene un conjunto de botones que nos permiten realizar distintas cosas...
# Empezando por arriba y a la izquierda se encuentran dos 'flechas celestes' que
# apuntan hacia la izquierda y la derecha. Esto nos permite ir viendo en la
# venta de plot los distintos gráficos creados. El siguiente botón es el del
# 'Zoom', este permite agrandar la imagen obtenida para una mejor visualización.
# El botón 'Export' nos permite guardar la imagen que estamos observando en
# formato imagen (.jpg) o en pdf. Sino la podemos copiar al clipboard y luego
# pegarla en algún programa de imagen para poder editarla como LibreOffice o
# PowerPoint. Los dos últimos botones sirven para borrar el gráfico que
# estamos observando o todos los gráfico obtenidos, respectivamente.  

# PARÁMETROS DE GRÁFICOS
# función par
# Es una función para acceder y manipular el conjunto de los parámetros gráficos
# que son utilizados en cada ventana. Los objetos generados en R con
# la función 'plot', le pasan sus argumentos a la función 'par', la mayoría a
# través del argumento especial "...", cuando se ejecutan.
# Para mayor información consulte en la ayuda de R:
?par

# De la página del curso se puede bajar un pdf con una referencia rápida de los
# parámetros de par más comúnmente usados (aunque esto depende de cada uno 
# claro). Para bajarla ejecutar:
browseURL('http://eva.universidad.edu.uy/file.php/1454/pdf/tabla-par.pdf')

# Un ejemplo introductorio... 
# Creo un vector para plotear
x <- sort(rnorm(100))
# Uso el argumento 'mar' para agrandar el margen izquierdo... 'mar' es un argumento que
# acepta como opción un vector numérico con 4 valores
# (por defecto mar=c(5, 4, 4, 2) + .1). Este vector define el tamaño de los 4
# márgenes de la ventana del gráfico.
op <- par(mar=c(5, 6, 4, 2))

# Acá estoy cambiando el tamaño de los márgenes del gráfico. En este caso
# solamente los dos primeros valores que equivalen al margen inferior y al
# margen izquierdo.
# Estos números están puestos en sentido horario, empezando por el margen
# inferior (inf, izq., arr, der).
# Es común guardar en un objeto (en este caso 'op') la salida para volver a usar
# los parámetros originales luego, utilizando el comando:
par(op)
# Pero volvamos a la configuración anterior:
op <- par(mar=c(5, 6, 4, 2))

# Veamos un ejemplo en el que se manipulan muchos parámetros...
plot(x, cex=1.5, cex.axis=1.2, cex.lab=2.1, col.lab='green', type='o', lwd=3,
     xlab="ejemplo", ylab="numeros", main="Un ejemplito")

# Jugando con los valores de cada uno se puede ver el significado de los mismos
# (en general los nombres buscan ser informativos).


# OPCIONES COMUNES

# Veremos tres formas comunes en que se suelen ajustar los gráficos: colores,
# superposición de líneas/puntos y gráficos múltiples.

# 1. Colores en los gráficos
# El argumento 'col', usado dentro de la función 'plot' (u otras funciones de
# gráficos) establece el color de lo graficado. Es un parámetro versátil, ya que
# acepta números, strings (palabras) o códigos RGB... veamos.

# Si se usan los enteros del 1 al 8 los colores ploteados son estos:
palette()
# Podemos visualizarlo con este comando:
plot(1:8, col=1:8, pch=19, cex=4)
# A su vez es posible manipular esta paleta de colores, agregando, quitando o 
# modificando distintos colores. Por ejemplo:
palette(c('green', 'red', 'skyblue'))
plot(1:8, col=1:8, pch=19, cex=4)

# Nótese que se repiten los colores porque la paleta ahora tiene sólo 3... De 
# todas formas es fácil volver a los valores por defecto:
p <- palette('default')
# Nótese también que opté por guardar estos valores en un vector p, el cual no
# vamos a usar en esta lección, pero que puede ser de mucha utilidad.
 
# Hay muchos nombres de colores posibles, los cuales se pueden conocer con la
# función 'colors':
?colors
colors()
 
# Para visualizarlos:
length(colors()) # 657 es aprox. 26 ^ 2
mat <- matrix(1:(26 ^ 2), 26, 26)
image(mat, col=colors())
 
# También existen algunas funciones que generan gradientes de colores
# preestablecidos, por ejemplo 'gray' , 'rainbow', 'terrain.colors',
# 'heat.colors':
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
# comandos para hacer esto son 'points'  y 'lines'. Por ejemplo:
x <- sort(rnorm(100, 0))
y <- sort(rnorm(100, 1))
plot(x, type='o')
points(y, col='green') # Agrega un nuevo conjunto de puntos de color verde.
lines(y, col='green', lwd=1.5) # Línea que une los puntos verdes.

# En este punto es necesario hacer una distinción importante: en R existen
# comandos gráficos de "alto nivel" y de "bajo nivel". En inglés los
# términos son "high level" y "low level" plots (HL y LL de aquí en más).

# Los HL son comandos capaces de hacer plots nuevos. Algunos ejemplos son
# 'plot', 'curve' o 'hist'.

# Los LL son comandos que sólo pueden agregar elementos a un plot existente.
# Algunos ejemplos son 'points', 'lines', 'legend' o 'text'.

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
points(Sepal.Length ~ Sepal.Width, subset=Species == 'versicolor', data=iris, col = 3, pch = 19)
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
# usado para hacer el plot original... 

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

legend(5, 15, legend='hola', pch=14) # Nótese que 'legend' es una función y
# un argumento de su propia función

# text ---> agregar texto a un gráfico
plot(1:25, pch=1:25, cex=4, main='Distintos tipos de puntos', ylim=c(0, 29))
text(1:25, 1:25 + 3, labels=1:25)
# Los 2 primeros argumentos son las coordenadas, mientras que labels es el texto
# que nos interesa agregar.
text(10.5, 27, labels='Los números indican el código correspondiente a cada punto',
     adj=.5) # Observe que cuando son letras éstas deben estar entre comillas

# Otra función para agregar texto, levemente diferente...
plot(Sepal.Length ~ Sepal.Width, subset=Species == 'setosa', data=iris)
mtext("estoy en el lado 3", side=3, line=2)
# Escribe texto en uno (algunos o todos) los márgenes del gráfico, puede ser
# dentro o fuera de la figura
# El segundo argumento, 'side', marca el margen (1=bottom, 2=left, 3=top,
# 4=right)
# El argumento 'line' mueve a partir de la línea del gráfico (contorno) el 
# texto escrito hacia afuera del gráfico (valores positivos) y hacia adentro 
# (valores negativos)


# 3. Gráficos múltiples
# Usando el argumento "mfcol" o "mfrow", dentro de 'par' podemos hacer varios
# plots juntos:
op <- par(mfrow=c(2, 2))

# Esto inicia una ventana gráfica con 4 lugares, 2 filas y 2 columnas
# Al usar mfrow los gráficos van llenando la ventana por fila:
boxplot(Sepal.Width ~ Species, data=iris)
boxplot(Sepal.Length ~ Species, data=iris)
boxplot(Petal.Width ~ Species, data=iris)
boxplot(Petal.Length ~ Species, data=iris)

# Si guaramos la salida de par, podemos recuperar los parámetros originales:
par(op)


# Para finalizar con esta parte les queremos dar a conocer la función 'locator'...

# la función 'locator' nos brinda la posición exacta de cualquier punto dentro
# del gráfico. Para esto debemos hacer click con el mouse y nos devuelve las 
# coordenadas x e y

locator(n=1) 
# n es la cantidad de puntos que queremos tener como coordenadas
# en este caso una sola

# Otra utilidad...
plot(Sepal.Length ~ Sepal.Width, subset=Species == 'setosa', data=iris)
legend(locator(n=1), legend=c("el texto aparece en donde se hace clik con el mouse"))
# En este caso el argumento 'locator' permite poner el texto que deseamos en el lugar
# exacto con solo hacer un click sobre el gráfico...
# It's Awesome!

