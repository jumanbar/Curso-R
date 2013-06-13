# Contenidos extra para la lección "Distribuciones y números aleatorios"

## Función qqnorm

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
# Comparar con la curva de pnorm, ¿Se parecen? ¿Tiene lógica?


## Distribución Uniforme
?Uniform
# O
?dunif

# Ejemplo: Para tomar mil valores aleatorios con distribución U(0,1):
x <- runif(1000, 0, 1)
hist(x)  # Es bastante horizontal el patrón, como indica la teoría.

# Los únicos parámetros que necesita esta distribución son un mínimo y un 
# máximo. Al igual que todos los generadores de números de "stats", el primer
# argumento es el número de elementos, mientras que los otros dos son
# el mín. y máx. mencionados.

# Cómo dice el nombre, la distribución uniforme es equiprobable para
# todos los valores incluidos en un intervalo dado, buscando representar el 
# espectro completo de los números reales contenidos en el mismo. Por lo tanto, 
# a diferencia de sample, no se restringe a un conjunto discreto y finito de 
# números, si no que muestrea de un conjunto (en teoría) infinito de valores. 
# Claro que una computadora no puede en sentido estricto hacer esto, pero es 
# una aproximación útil para la mayoría de los fines prácticos.


## Semillas y generadores de números aleatorios.

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
