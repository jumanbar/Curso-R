
## Distribuciones

# A modo general, una Distribución es una herramienta matemática que generaliza la noción de una función.

# En R podemos ver la lista de todas las distribuciones que se encuentran incluidas en el paquete 'stats', utilizando el siguiente comando:
?Distributions

# Cuatro grandes grupos de funciones de distribución de probabilidad se encuentran disponibles en dicho paquete: función de densidad (Density), función de distribución acumulativa (cumulative distribution function), función cuantil (quantile function) y generadores de núneros al azar (random variate generation).
# Cada función se denomina e identifica con la primer letra seguido del nombre de la variable (discreta o continua).
# dxxx
# pxxx
# qxxx
# rxxx

# Ejemplo: Distibución Normal o Gaussiana

# dnorm : Función de Densidad de Probabilidad (PDF en inglés).
# pnorm : Función de Distribución de Probabilidad (CDF en inglés; probabilidad acumulada).
# qnorm : Función de Cuantiles.
# rnorm : Generador aleatorio de números con distribución normal.
# En la ayuda de R se pueden ver las cuatro funciones incluidas para la
# distribución normal:
?Normal
?dnorm
?pnorm
?qnorm
?rnorm

# Las cuatro funciones tienen argumentos que especifican los parámetros
# de la distribución: mean y sd (mu y sigma), tienen los valores por
# defecto 0 y 1 (lo que se denota por la presencia de los "=").
# Otros parámetros varían ya que son específicos de cada función.


## Sobre las funciones:

# dnorm 
# Es la función con forma de campana que la mayoría conocemos.
# Calcula para cada punto observado el valor de la función de densidad.

# Para la función de densidad con una distribución normal el valor cero vale:
dnorm(0) # cuánto vale la media y el desvio de esta distribución?
# 0.3989423

# Para la función de densidad con una distribución normal y media = 6, el valor cero vale:
dnorm(0, mean=6)
# 6.075883e-09

# Para la función de densidad con una distribución normal con media = 4 y desvio = 10, el valor cero vale:
dnorm(0, mean=6, sd=10)
# 0.03332246

# Si quiero averigual el valor para tres números diferentes, los debo concatenar con la función c:
dc <- dnorm(c(1, 3, 7))
# 2.419707e-01 4.431848e-03 9.134720e-12

# Si quiero conocer para un determinada secuencia de valores como se comporta la función de distribución de densidad, primero debo generar la secuencia:
dx <- seq(-20, 20, by=0.1)
# dx es un vector con valores entre -20 y 20 tomados de a 0,1.
dy <- dnorm(dx)
# dy usa los valores generados en dx y calcula los valores para la función de densidad con distribución normal
plot(dx, dy)

# ahora le cambiamos la media y el desvio
dz <- dnorm(dx, mean=2.5, sd=0.1) 
plot(dx, dz)

# pnorm 
# Es la función que describe P(Y <= X) (probabilidad de que Y sea
# menor o igual a X, siendo X un cuantil e Y una variable aleatoria
# tomada de una distribución normal.
# Naturalmente Y está entre 0 y 1

pnorm(0)
# 0.5

pnorm(0, mean=2)
# 0.02275013

pnorm(0, mean=2, sd=3)
# 0.2524925

pc <- pnorm(c(1, 3, 7))
# 0.8413447 0.9986501 1.0000000

px <- seq(-20, 20, by=0.1)
py <- pnorm(px)
plot(px, py)

pz <- pnorm(px, mean=2, sd=3) 
plot(px, pz)

# qnorm
# Matemáticamente es la función inversa a pnorm (f^-1(x), no 1/f(x)).
# Ejemplo: para una variable al azar con distribución normal, de media 0 y desvio 1, la función de probabilidad que devuelve es el Z-score.

qnorm(0.5)
# 0
qnorm(0.5, mean=1)
# 1
qnorm(0.5, mean=1, sd=2)
# 1
qnorm(0.5, mean=2, sd=2)
# 2
qnorm(0.5, mean=2, sd=4)
# 2
qnorm(0.25, mean=2, sd=2)
# 0.6510205
qnorm(0.758)
# 0.6998836
qnorm(0.758, mean=5, sd=2)
# 6.399767
qnorm(0.265)
# -0.628006
qnorm(0.265, sd=3)
# -1.884018

qc <- c(0.2,0.4,0.65)
qnorm(qc)
# -0.8416212 -0.2533471  0.3853205

qx <- seq(0, 1, by=0.05)
qy <- qnorm(qx)
plot(qx, qy)


## Números aleatorios en R

# Un número aleatorio surge a partir de una variable al azar que presenta una función de distribución determinada.

# Ejemplo: Para crear 1000 números aleatorios con promedio 0 y desvío estándar 1:
x <- rnorm(1000, mean=0, sd=4)
# Claro está que el promedio es de la población y no de cada número en sí...
# Para corroborar que el generador funciona bien:
mean(x)  # Debería ser cercano a 0
sd(x)    # y este cercano a 1

# De acuerdo a la ley de los grandes números, cuánto mayor es la cantidad de elementos de x, más cercanos a 0 y 1 son estos valores... invitamos al usuario a que explore lo que ocurre con rnorm.

# Podemos hacer un resumen de los números generados:
summary(x)

# O un histograma:
hist(x)

# O una curva de densidad:
densidad <- density(x)
plot(densidad)

# O ambos...
hist(x, freq=FALSE, add=TRUE)
# Nótese el uso de los argumentos "freq" y "add" para cambiar las
# opciones por defecto (así grafica densidades y no borra el gráfico
# anterior). En esta parte no se va a profundizar en lo que refiere
# a herramientas gráficas, pero se retomará el tema más adelante.

# Ejemplificando con las tres funciones que vimos anteriormente:

# dnorm
# otra forma de graficar una función de densidad:
curve(dnorm(x), from=-3.5, to=3.5) # recuerde quien era x...
# La función curve dibuja la curva de la función correspondiente dentro de los límites pautados por 'from' y 'to'.

# pnorm
curve(pnorm(x), from=-3.5, to=3.5)

# qnorm
curve(qnorm(x), from=-1, to=1)
# Se parece a:
plot(sort(rnorm(1e3)))

# Puedo combinar dnorm y rnorm para hacer un lindo gráfico:
x <- rnorm(1000)
hist(x, freq=FALSE)
curve(dnorm(x), add=TRUE, col='blue', lwd=2)
lines(density(x), col='red', lwd=2)
# la función line ajusta una línea al modelo propuesto.

# EXTRA

# La función qqnorm sirve para comparar los cuantiles de un vector
# cualquiera con la distribución de cuantiles esperada para una
# distribución normal:
?qqnorm

# Ejemplo:
qqx <- rnorm(100)
qqnorm(qqx)
# Usando qqline agregamos una recta que pasa por el primer y tercer
# cuartiles (correspondientes a los percentiles 25% y 75%). 
qqline(qqx, col='red', lwd=2)
# ¿Qué pasa si hago una prueba similar con un x generado con runif?
# Comparar con la curva de pnorm, ¿Se parecen?¿Tiene lógica?

####################################################

## Ejemplo: Distribución Uniforme
?Uniform
# O
?dunif

# Cómo dice el nombre, la distribución uniforme es equiprobable para
# todos los valores incluídos en un intervalo dado. Por lo tanto sólo
# necesita un mínimo y un máximo como parámetros.
# Al igual que todos los generadores de números de "stats", el primer
# argumento es el número de elementos, mientras que los otros dos son
# el mín. y máx. mencionados.

# Ejemplo: Para tomar mil valores aleatorios con distribución U(0,1):
x <- runif(1000, 0, 1)
hist(x)  # Bastante horizontal, ¿no?

####################################################

## Muestreos aleatorios
?sample

# La función sample hace muestreos de los elementos contenidos en el
# primer argumento. Por defecto muestrea sin reposición todos los
# elementos posibles:
sample(1:5)
# 1 4 5 2 3 # primera corrida
# 2 1 5 4 3 # segunda corrida
# 3 4 2 1 5 # tercera corrida
# como el lector puede observar, cada nueva corridadel comando, genera un muestreo aleatorio, por lo tanto es esperable que el orden de los números sea siempre distinto.
# intente probar con una mayor cantidad de números o correr varias veces el argumento de arriba...

# En la ayuda se pueden ver varios argumentos para modificar este
# comportamiento:
sample(1:5, replace=TRUE)  # con reposición
sample(1:5, 2)             # muestrea sólo dos valores, sin reposición
sample(1:5, size=2)        # ídem
sample(1:5, 2, replace=TRUE) # los anteriores combinados

# Los mismos resultados se pueden obtener si usamos vectores "character":
sample(c('Homero', 'Marge', 'Bart', 'Lisa', 'Maguie'), 3, replace=TRUE) # nombres
sample(letters, 5) # letras

# Algo que puede confundir: si le damos solamente un número como entrada,
# puede tener comportamientos inesperados:
sample(10)     # idéntico a pedir "sample(1:10)"
sample(10.3)   # redondea 10.3 --> 10, así que es igual que el anterior
# es idéntico a pedir: sample(floor(10.3)), función floor es para redondear
sample(-10.3)  # el comportamiento es distinto ahora, por ser negativo

#############################################################################

# EXTRA

# Otra opción útil puede ser usar el argumento "prob" de la función sample.
# Este argumento permite asignar distintos valores de peso a cada
# uno de los elementos del vector a muestrear.
# Por ejemplo, si queremos muestrear los valores 5, 10 y 15 pero de tal
# forma que el valor 5 sea 3 veces más frecuente que el 15, y que el
# el 10 sea 2 veces más frecuente que el 15, entonces podemos ingresar:
muestreo <- sample(c(5, 10, 15), size=6000, prob=c(3, 2, 1), replace=T)
x <- table(muestreo)
x  # x tiene por nombres los valores 5, 10 y 15
x['5'] / x['15']  # ¿Es el valor que esperábamos?
x['5'] / x['10']  # ¿Es el valor que esperábamos?
# las comillas indican el nombre del elemento
# en el resultado el 5 indica el nombre del elemento, de forma similar
# a cuando pedimos que muestre x.

# Nótese que:
# prob es un sólo argumento, pero eso no equivale a un sólo número, si no
# a un sólo objeto (en este caso un vector, con tres elementos).
# prob puede aceptar valores decimales, incluso pueden asignarse
# probabilidades, aunque da error si alguno es negativo.
# Internamente los valores son siempre convertidos a un valor
# de probabilidad (entre 0 y 1); si el usuario ingresa lo siguigente:
# prob=c(A, B, C)
# Entonces transforma los valores así:
# a = A / (A + B + C)
# b = B / (A + B + C)
# c = C / (A + B + C)
# Y utiliza a, b y c como las probabilidades de que sean muestreados
# los elementos correspondiente del vector a muestrear.


####################################################
## Semillas

# Los números aleatorios generados por computadora, no son verdaderamente
# aleatorios. Los algoritmos internos necesarios son determinísticos
# en último término, pero producen secuencias de valores que aproximan
# propiedades estadísticas aceptablemente similares a las esperadas
# por la distribución uniforme.
# Ver:
# http://www.random.org/;
# http://en.wikipedia.org/wiki/Pseudorandom_number_generator).
?Random
?RNG/
  # También existe un paquete llamado "random", para la generación de
  # números verdaderamente aleatorios (aunque en muchos casos no son
  # necesarios).
  
  # Las simulaciones que usan métodos Monte Carlo pueden ser sensibles a
  # los problemas. Para el uso de R existe al menos un libro relacionado:
  # http://books.google.com/books/about/Introducing_Monte_Carlo_Methods_with_R.html?id=WIjMyiEiHCsC
  
# Las secuencias generadas por estos algoritmos dependen del valor
# inicial llamado "semilla". Si ingresamos una semilla manualmente
# podemos repetir el resultado de cualquiera de las funciones basadas
# en generadores de números aleatorios (como rnorm, runif y sample):
set.seed(1)  # se puede usar cualquier otro número
sample(10)
# 3  4  5  7  2  8  9  6 10  1
# si ejecutamos de vuelta el comando, va a ser distinto
sample(10)
#  3  2  6 10  5  7  8  4  1  9
# a menos que volvamos a "plantar" la misma "semilla":
set.seed(1)
sample(10)
# 3  4  5  7  2  8  9  6 10  1

# Se obtendrán resultados análogos si usamos rnorm, runif u otros
# generadores de números aleatorios.

# Esto puede ser útil si queremos que nuestros resultados sean
# reproducibles *exactamente* en otro momento o lugar.

# si plantamos otra semilla, el orden aleatorio que quede guardado en dicha semilla será otro:
set.seed(2)
sample(10)
# 2  7  5 10  6  8  1  3  4  9

sample(10)
# 6  3  7  2  9  5  4  1 10  8

set.seed(2)
sample(10)
# 2  7  5 10  6  8  1  3  4  9

