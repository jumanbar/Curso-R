# GRÁFICOS: parte II

# Como vimos en la lección 3.5 (gráficos simples para visualizar datos)
# existe una gran diversidad de funciones en R que nos permiten visualizar
# nuestros datos. No obstante, muchas veces nos interesa obtener gráficos de los
# modelos estadísticos evaluados como resultado visual de nuestros análisis. La
# función genérica 'plot' nos permite obtener dicho resultado:
?plot

# Comencemos con un ejemplo muy sencillo:
x <- rnorm(50)
y <- rnorm(50)
plot(x, y)

# En este caso estamos graficando y ~ x aunque el primer argumento sea la
# variable 'x' y el segundo la variable 'y'. Sin embargo, es posible utilizar
# otros argumentos para dicha función.

# Por ejemplo si deseamos visualizar gráficamente el primer modelo lineal simple
# utilizado en la lección 4.3 (regresión simple):

lm1 <- lm(dist ~ speed, data=cars)
plot(dist ~ speed, data=cars, col="red")
# Observe que dentro de la función 'plot' se escribe exactamente lo mismo que
# en la función 'lm'.

# Si bien en la ayuda de dicha función nos dice que el primer argumento es la
# variable 'x' y el segundo es la variable 'y', observe que nosotros en este
# caso le estamos dando como primer argumento la fórmula de nuestro modelo
# lineal y como segundo el data.frame en donde se encuentran nuestros datos.
# Esta es otra forma de obtener un gráfico x-y y en R aparece como la función
# 'plot.formula', aunque si ud. va a la ayuda observará que en realidad se
# utiliza la función 'plot'...
?plot.formula

plot(cars$dist ~ cars$speed, col="blue")
# Otra forma de obtener el mismo resultado. En este caso no es necesario
# utilizar el argumento 'data' porque con el signo '$' ya le estamos indicando a
# la función de donde debe obtener la información para realizar la acción.

plot(speed, dist, data=cars, col="green")
# Este gráfico tiene la misma sintaxis que el primer ejemplo, primero la
# variable 'x', luego la variable 'y', no hay un fórmula... y nos devuelve el
# mismo gráfico (los colores son para poder diferenciarlos y que no se vean todos
# iguales). Esto da cuenta de que ambas formas sirven y queda a elección de cada
# uno la manera más sencilla que le sirva para entender la sintaxis.

lm2 <- lm(dist ~ speed, data=cars, subset=dist > 20)
plot(dist ~ speed, data=cars, subset=dist > 20)
# Como puede observar el argumento 'subset' también sirve como un filtro para
# las variables a graficar. En este caso si ud. compara cualquiera de los tres
# gráficos anteriores con este nuevo gráfico podrá observar como cambian las
# escalas en los ejes y como disminuye la cantidad de puntos (datos) graficados.


# Usando la función gráfica llamada 'abline' podemos agregar la recta al
# gráfico cuya pendiente y corte en el eje 'y' se obtienen del modelo lineal
# 'lm1' en este caso:
abline(lm1) # observe que se escribe el modelo dentro de la función
# En este caso la función 'abline' está utilizando los argumentos 'a' y  'b',
# para mayor información consulte la ayuda:
?abline

# Es lo mismo que haber escrito:
abline(coef(lm1)[1], coef(lm1)[2])
# En este caso el primer argumento 'a' es el primer coeficiente del modelo
# 'lm1'es decir el corte en el eje 'y' y el segundo argumento 'b' es el valor de
# la pendiente. Utilizamos la función 'coef' porque esta nos brinda el valor de
# los parámetros arriba descritos. A su vez se utiliza la sangria con los
# '[]' porque dicha función devuelve los valores en un vector y cada parámetro
# presenta una posición. Para más información consulte en la ayuda de R:
?coef

# Recuerde que la función 'abline' también puede ser utilizada para otros
# casos que no sean modelos estadísticos explicados en la parte I.

# Esta función también acepta argumentos de la función 'par' para diagramar la
# o las líneas que deseemos sean graficadas.
# Por ejemplo:
lm_iris <- lm(Sepal.Length ~ Sepal.Width, data=iris) # modelo lineal
plot(Sepal.Length ~ Sepal.Width, data=iris) # gráfico que lo representa
abline(lm_iris, lwd=2, col=2, lty=3) # recta del modelo lineal

# Complejizando un poco...
# Si nos interesa tener una recta por cada especie, debemos filtrar a nuestro
# modelo lineal por la variable 'Species' y así obtendremos para cada modelo
# sus coeficientes correspondientes.
setosa <- lm(iris$Sepal.Length ~ iris$Sepal.Width, data=iris, subset=Species
=="setosa")
versicolor <- lm(iris$Sepal.Length ~ iris$Sepal.Width, data=iris,
subset=Species == "versicolor")
virginica <- lm(iris$Sepal.Length ~ iris$Sepal.Width, data=iris,
subset=Species == "virginica")

plot(Sepal.Length ~ Sepal.Width, data=iris, pch=as.numeric(iris$Species),
col=as.numeric(iris$Species))

abline(setosa, col=1, lty=1, lwd=1.5) # recta para el modelo setosa
abline(versicolor, col=2, lty=2, lwd=1.5) # recta para el modelo versicolor
abline(virginica, col=3, lty=3, lwd=1.5) # recta para el modelo virginica

legend("topleft", title = "Species", 
       legend=c("setosa","versicolor", "virginica"),
       bty ='n', lty = c(1:3), pch=1:3, col=1:3, lwd = 1.5, cex=0.8)


# Muchas veces nos interesa ver como se distribuyen las frecuencias de
# nuestros datos, si estos presentan algún tipo de distribución teórica
# conocida o simplemente presentan una distribución azarosa. Para este tipo de
# casos existe una buena forma de visualizar lo planteado anteriormente y es a
# través de la función 'hist':
?hist

# Por ejemplo queremos observar la distribución de los siguientes datos:
hist(iris$Sepal.Width)

# Esta función tiene algunos argumentos por defecto que pueden ser de nuestro
# interés modificarlos.
# El argumento 'breaks' es el que marca cuantos cortes (rangos de valores)
# tendrá el histograma:
hist(iris$Sepal.Width, breaks=20)

# Observe que en el eje 'y' se grafican las frecuencias para cada rango de
# valores presente en el eje 'x'. Ahora si preferimos conocer cuál es la densidad
# de dichos valores debemos cambiar el argumento lógico 'freq' que por defecto
# es TRUE: 
hist(iris$Sepal.Width, breaks=20, freq=F)

# Al igual que en la función 'plot', la función 'hist' también acepta
# argumentos como 'col', 'xlab', 'ylab', 'cex', 'font'...
# A modo de ejemplo:
hist(iris$Sepal.Width, col=2, main="Histograma", xlab="Ancho del Sepalo",
     ylab="Frecuencia", xlim=c(1.5, 4.5), font=2)

# Cuando nos interesa visualizar distintos estadísticos descriptivos para
# nuestras variables categóricas, existe una función llamada 'boxplot':
?boxplot

# La fórmula que requiere esta función es del tipo y ~ grp, donde 'y' es la
# variable de respuesta, esta debe ser continua y 'grp' son los distintos grupos
# que queremos comparar o visualizar en relación a 'y'. Por ejemplo:
boxplot(Temp ~ Month, data=airquality)

# Aquí se está graficando la variable continua Temperatura en función de cada
# uno de los 5 Meses de estudio (grupos).
# La interpretación...
# Los límites de la caja dan cuenta del primer y tercer cuartil (ver lección
# correspondiente para complementar). Es decir, la caja limita entre el 25% y
# 75% de los datos. La mediana es la línea que se observa (segundo cuartil),
# en donde se encuentran el 50% de los datos. Los bigotes que salen
# de la caja hacen referencia la valor mínimo y al valor máximo. Por último,
# los puntos que se encuentran más allá de los bigotes son posibles valores
# extremos que aparecen separados porque su valor excede una vez y media el
# rango de la caja (recorrido intercuartílico).

# Como veníamos viendo hasta ahora también es posible diagramar un boxplot
# con los argumentos 'prestados' por la función 'par':

boxplot(Temp ~ Month, data=airquality, col=2:6, main="Boxplot", xlab="Meses",
        ylab="Temperatura") # ... y todos los que hemos visto

# En la función 'boxplot' también funciona el argumento 'subset':
boxplot(Temp ~ Month, data=airquality, col=2:6, main="Boxplot", xlab="Meses",
        ylab="Temperatura", subset=Month < 7)


# La función curve sirve para graficar funciones.
# El primer argumento usa una función de x.
?curve
curve(x ^ 2, from=-5, to=5) # from y to son los límites de la evaluación
curve(sin(x), from=-5, to=5)
curve(sin(x) / x, from=-5, to=5, n=1000) # n es el número de puntos evaluados
# Usando la opción add=TRUE curve actúa como una low level
curve(cos(x), from=-5, to=5, add=TRUE, col=2, n=6)

# Dos alternativas para guardar los gráficos con comandos:

png(file="mi_boxplot.png") # Función que prepara el dispositivo gráfico para
# ser guardado.
boxplot(Temp ~ Month, data=airquality)
dev.off() # Es necesario ejecutar este comando para desconectar el device png
# y así volver a visualizar los gráficos en la pantalla. 

x11()
# Abre una nueva venta de gráfico, necesario para poder ejecutar la función 
# 'savePlot'. 
boxplot <- boxplot(Temp ~ Month, data=airquality, col=2:6)
savePlot(file="mi_segundo_boxplot.png")
# Ojo, debe estar la extensión del archivo incluida, en este caso es .png. 

# Tenga en cuenta que la figura será guardada en el directorio de trabajo
# actual (usar la función 'getwd' para verlo).

 
# Otras herramientas gráficas existen y se crean todo el tiempo en la
# comunidad R. Existen muchos gráficos muy populares que son bastante más
# sofisticados que los gráficos por defecto de R, uno de ellos es "ggplot2",
# sobre el cual no vamos a profundizar en este curso.
# También hay dos grandes paquetes 'lattice' y 'MASS' especializados para
# realizar un sin fin de gráficos en R desde gráficos de tortas hasta gráficos
# en 3D.
