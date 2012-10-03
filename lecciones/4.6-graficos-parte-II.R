
# Como vimos en la lección 3.5 (gráficos simples para visualizar datos)
# existen una gran diversidad de funciones en R que nos permiten visualizar
# nuestros datos. No obstante, muchas veces nos interesa obtener gráficos de los
# modelos estadísticos evaluados como resultado visual de nuestros análsis. La
# función genérica 'plot' nos permite obtener dicho resultado:
?plot

# Comencemos con un ejemplo muy sencillo:
x <- rnorm(50)
y <- rnorm(50)
plot(x, y)

# En este caso estamos graficando y ~ x aunque el primer argumento sea la
# variable 'x' y el segundo la variable 'y'. Sin embargo, es posible utilizar
# otros argumentos para dicha función.

# Por ejemplo si deseamos visualizar graficamente el primer modelo lineal simple
# utilizado en la lección 4.3 (regresión simple):

# lm1 <- lm(dist ~ speed, data=cars)
plot(dist ~ speed, data=cars, col="red")
# Observe que dentro de la función 'plot' se escribe exactamente lo mismo que
# en la función 'lm'.

# Si bien en la ayuda de dicha función nos dice que el primer argumento es la
# variable 'x' y el segundo es la variable 'y', observe que nosotros en este
# caso le estamos dando como primer argumeto la fórmula de nuestro modelo
# lineal y como segundo el data.frame en donde se encuetran nuestros datos.
# Esta es otra forma de obtener un gráfico x-y y en R aparce como la función
# 'plot.formula', aunque si ud. va  la ayuda observará que en realidad se
# utiliza la función 'plot'...
?plot.formula

plot(cars$dist ~ cars$speed, col="blue")
# Otra forma de obtener el mismo resultado. En esta caso no es necesrio
# utilizar el argumento 'data' porque con el signo '$' ya le estamos indicando a
# la función de donde debe obtener la información para realizar la acción.

plot(speed, dist, data=cars, col="green")
# Este gráfico tiene la misma sintaxis que el primer ejemplo, primero la
# variable 'x', luego la variable 'y', no hay un fórmula... y nos deveulve el
# mismo gráfico (los colores son para poder diferenciarlos y que no se vean todos
# iguales). Esto da cuenta de que ambas formas sirven y queda a elección de cada
# uno la manera más sencilla que le sirva para entender la sintaxis.

# lm2 <- lm(dist ~ speed, data=cars, subset=dist > 20)
plot(dist ~ speed, data=cars, subset=dist > 20)
# Como puede observar el argumento 'subset' también sirve como un filtro para
# las variables a graficar. En este caso si ud. compara cualquiera de los tres
# gráficos anteriores con este nuevo gráfico podrá observar como cambian las
# escalas en los ejes y como disminuyen la cantidad de puntos (datos) graficados.


hist

boxplot

# La función curve sirve para graficar funciones.
# El primer argumento usa una función de x.
?curve
curve(x ^ 2, from=-5, to=5) # from y to son los límites de la evaluación
curve(sin(x), from=-5, to=5)
curve(sin(x) / x, from=-5, to=5, n=1000) # n es el número de puntos evaluados
# Usando la opción add=TRUE curve actúa como una low level
curve(cos(x), from=-5, to=5, add=TRUE, col=2, n=6)


# Visualización de la normalidad de un conjunto de datos:
x <- rnorm(100)
qqnorm(x) # Cuantiles teóricamente esperados vs. cuantiles observados
qqline(x) # Línea 1:1
 


# Otras herramientas gráficas existen y se crean todo el tiempo en la
# comunidad R. Existen muchos gráficos muy populares que son bastante más
# sofisticados que los gráficos por defecto de R, uno de ellos es "ggplot2",
# sobre el cual no vamos a profundizar en este curso.
 lattice y MASS
