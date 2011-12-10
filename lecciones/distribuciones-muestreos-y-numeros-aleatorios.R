## Números aleatorios en R
 
# Podemos ver la lista de distribuciones incluidas en el paquete stats:
?Distributions
 
## Distibución Normal o Gaussiana
?Normal # o
?dnorm  # o
?rnorm  # etc...
# En la ayuda de R se pueden ver las cuatro funciones incluidas para la
# distribución normal:
# dnorm : Función de Densidad de Probabilidad (PDF en inglés).
# pnorm : Función de Distribución de Probabilidad (CDF en inglés; probabilidad acumulada).
# qnorm : Función de Cuantiles.
# rnorm : Generador aleatorio de números con distribución normal.
 
# Las cuatro funciones tienen argumentos que especifican los parámetros
# de la distribución: mean y sd (mu y sigma). Tienen los valores por
# defecto 0 y 1 (lo que se denota por la presencia de los "=").
# Otros parámetros varían ya que son específicos de cada función.
 
# Para crear 1000 números aleatorios con promedio 0 y desvío estándar 1:
x <- rnorm(1000, mean=0, sd=4)
# Claro está que el promedio es de la población y no de cada número en sí...
# Para corroborar que el generador funciona bien:
mean(x)  # Debería ser cercano a 0
sd(x)    # y este cercano a 1
 
# De acuerdo a la ley fuerte de los grandes números (?), cuánto mayor
# es la cantidad de elementos de x, más cercanos a 0 y 1 son estos
# valores... invitamos al usuario a que explore lo que ocurre con rnorm.
 
# Podemos hacer un resumen de los números generados:
summary(x)
# O un histograma:
hist(x)
# O una curva de densidad:
dens <- density(x)
plot(dens)
# O ambos...
hist(x, freq=FALSE, add=TRUE)
# Nótese el uso de los argumentos "freq" y "add" para cambiar las
# opciones por defecto (así grafica densidades y no borra el gráfico
# anterior). En esta parte no voy a profundizar en lo que refiere
# a herramientas gráficas, pero se retomará el tema más adelante.
 
## Sobre las otras tres funciones:
# dnorm es la función con forma de campana que la mayoría conocemos:
curve(dnorm(x), from=-3.5, to=3.5)
 
# pnorm es la función que describe P(Y <= X) (probabilidad de que Y sea
# menor o igual a X, siendo X un cuantil e Y una variable aleatoria
# tomada de una distribución normal:
curve(pnorm(x), from=-3.5, to=3.5)
# Naturalmente Y está entre 0 y 1
 
# qnorm matemáticamente es la función inversa a pnorm (f^-1(x), no 1/f(x)).
curve(qnorm(x), from=-1, to=1)
# Se paree a:
plot(sort(rnorm(1e3)))
 
# Puedo combinar dnorm y rnorm para hacer un lindo gráfico:
x <- rnorm(1000)
hist(x, freq=FALSE)
curve(dnorm(x), add=TRUE, col='blue', lwd=2)
lines(density(x), col='red', lwd=2)
 
# La función qqnorm sirve para comparar los cuantiles de un vector
# cualquiera con la distribución de cuantiles esperada para una
# distribución normal:
?qqnorm
 
# Ejemplo:
x <- rnorm(100)
qqnorm(x)
# Usando qqline agregamos una recta que pasa por el primer y tercer
# cuartiles (correspondientes a los percentiles 25% y 75%). 
qqline(x, col='red', lwd=2)
# ¿Qué pasa si hago una prueba similar con un x generado con runif?
# Comparar con la curva de pnorm, ¿Se parecen?¿Tiene lógica?
 
 
 
####################################################
## Distribución Uniforme
?Uniform  # o
?dunif
 
# Cómo dice el nombre, la distribución uniforme es equiprobable para
# todos los valores incluídos en un intervalo dado. Por lo tanto sólo
# necesita un mínimo y un máximo como parámetros.
# Al igual que todos los generadores de números de "stats", el primer
# argumento es el número de elementos, mientras que los otros dos son
# el mín. y máx. mencionados. Para tomar mil valores aleatorios con
# distribución U(0,1):
x <- runif(1000, 0, 1)
hist(x)  # Bastante horizontal, ¿no?
 
 
 
####################################################
## Muestreos aleatorios
?sample
 
# La función sample hace muestreos de los elementos contenidos en el
# primer argumento. Por defecto muestrea sin reposición todos los
# elementos posibles:
sample(1:5)
 
# En la ayuda se pueden ver varios argumentos para modificar este
# comportamiento:
sample(1:5, replace=TRUE)  # con reposición
sample(1:5, 2)             # muestrea sólo dos valores, sin reposición
sample(1:5, size=2)        # ídem
sample(1:5, 2, replace=TRUE) # los anteriores combinados
 
# Los mismos resultados se pueden obtener si usamos vectores "character":
sample(c('Juan', 'Mauro', 'Arnold', 'Bill Dance'), 3, replace=TRUE)
sample(letters, 4)
 
# Algo que puede confundir: si le damos solamente un número como entrada,
# puede tener comportamientos inesperados:
sample(10)     # idéntico a pedir "sample(1:10)"
sample(10.3)   # redondea 10.3 --> 10, así que es igual que el anterior
               # es idéntico a pedir: sample(floor(10.3))
sample(-10.3)  # el comportamiento es distinto ahora, por ser negativo
 
# Otra opción útil puede ser usar el argumento "prob" de la función.
# Este argumento permite asignar distintos valores de peso a cada
# uno de los elementos del vector a muestrear.
# Por ejemplo, si queremos muestrear los valores 5 10 y 15 pero de tal
# forma que el valor 5 sea 3 veces más frecuente que el 15, y que el
# el 10 sea 2 veces más frecuente que el 15, entonces podemos ingresar
muestreo <- sample(c(5, 10, 15), size=6000, prob=c(3, 2, 1), replace=FALSE)
x <- table(muestreo)
x  # x tiene por nombres los valores 5 10 y 15
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
# a menos que volvamos a "plantar" la misma "semilla":
set.seed(1)
sample(10)
 
# Se obtendrán resultados análogos si usamos rnorm, runif u otros
# generadores de números aleatorios.
 
# Esto puede ser útil si queremos que nuestros resultados sean
# reproducibles *exactamente* en otro momento o lugar.
