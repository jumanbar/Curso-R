## Clases de objetos
 
# R es un lenguaje orientado a objetos. Variables, tablas, vectores, números,
# funciones, etc., todos son objetos, y cada clase de objeto tiene diferentes
# atributos que determinan la forma en que trabajan dentro de R. Algunas de las
# clases más comunes de objetos son: 'integer', 'numeric', 'character',
# 'logical', 'matrix', 'data.frame', 'list' y 'function'.

# Para el caso de números, ya sea un valor único o un vector con varios 
# elementos, existen dos clases principales:
x <- 1:5
class(x) # "integer", es decir, números enteros

x <- x + 0.1
class(x) # "numeric", ya que ahora contiene decimales

# La diferencia más importante entre ambos es que los primeros ocupan menos 
# memoria (puede consultarlo con la función 'object.size')

# Para el caso de "palabras" o más comúnmente llamadas "strings", la clase 
# "character" es la que utiliza R para manejar este tipo de objetos. Al igual 
# que en la mayoría de los lenguajes de programación, R utiliza las comillas 
# dobles " o simples ' para delimitar un string. Veamos un ejemplo rápido:
y <- letters[1:5]
y # [1] "a" "b" "c" "d" "e"
class(y) # "character"
# Nota: "letters" es un vector con el abecedario, que viene con R, al igual que
# "LETTERS".

# Nota: el objeto "y" es un vector también, más allá de que no tiene 
# números.

# Palabras completas pueden usarse también de forma similar:
mp <- c("Graham Chapman", "John Cleese", "Eric Idle", "Michael Palin")
mp

# Nótese que al usar las comillas se puede incluir cualquier caracter dentro, 
# sin tener que preocuparse de que R lo interprete como un comando. Es decir, 
# se toma lo que está entre comillas de forma literal, razón por la cual 
# estos tipos de objetos son llamados "strings literals" muchas veces.

# Los objetos del tipo "logical" son resultado de operaciones lógicas, como 
# comparaciones (¿a es mayor que b?, ¿h es distinto de 3.1415?, etc). Por 
# ejemplo:
u <- 5 > 2:8
u # [1]  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE
class(u) # "logical", es un vector con valores booleanos (ver lección relativa
         # a operadores lógicos).
# Como verán la comparación aquí se hizo entre 5 y todos los elementos de 2:8

# La clase de un objeto afecta cómo las funciones trabajan con el mismo. Por 
# ejemplo, la función mean puede generar salidas coherentes con objetos 
# numéricos o lógicos, pero no con caracteres. Lo mismo con la multiplicación:

mean(x) # [1] 3.1
2 * x # [1]  2.2  4.2  6.2  8.2 10.2

mean(y)
#[1] NA
# Warning message:
# In mean.defaul( y) : argument is not numeric or logical: returning NA
2 * y
# Error in 2 * y : non-numeric argument to binary operator
# Como y es "character", la función mean no pudo hacer un promedio, ni se
# pudo multiplicar por 2.
 
# Con los objetos lógicos sin embargo sí se pueden hacer operaciones
# matemáticas, ya que "TRUE" se considera igual a 1 y "FALSE" igual a 0:
2 * u
# [1] 2 2 2 0 0 0 0
sum(u)
# [1] 3
mean(u)
# [1] 0.4285714

# La cantidad de clases de objetos es muy grande y crece permanentemente,
# acompañando la creación de nuevos paquetes de R. Casi en cada paquete existen
# funciones que devuelven objetos de clases únicas que sólo esa función puede
# generar y cuya interpretación y funcionalidad es específica del paquete en
# cuestión o de otros creados posteriormente y que dependen del mismo. Por 
# ejemplo las clases "igraph" o "Spatial" de los paquetes igraph y sp definen 
# objetos asociados a trabajo con grafos y datos espaciales respectivamente.

# En general estas clases nuevas suelen ser sofisticadas y son creadas para 
# manejar cantidades considerables de información.

# Un ejemplo del R básico es la función dist. Esta toma un set de coordenadas 
# de puntos y calcula la distancia (por defecto euclidiana) entre todos los 
# pares de puntos posibles. El resultado en lugar de ser una matriz de 
# distancias, es un objeto de clase "dist", el cual tiene características 
# particulares, a fin de ahorrar espacio de memoria:
xy  <- cbind(rnorm(5), rnorm(5)) # Las coordenadas
out <- dist(xy)                  # cálculo de distancias
class(out)                       # [1] "dist"
out
# Estos objetos pueden ser entrada para funciones que necesitan este formato de
# datos para producir una salida particular. Por ejemplo para hacer un cluster
# con estas distancias:
plot(hclust(out))

# Nota: no es importane por ahora entender la función "hclust", si no tener en 
# cuenta que necesita un objeto "dist" como entrada.


## Funciones genéricas

# No todas las funciones de R pueden trabajar con varios tipos de objeto (es 
# decir, varias clases de objeto). Las que pueden con estas tareas son las 
# llamadas "funciones genéricas". Algunos ejemplos son plot, print, summary, 
# y mean. Cada una de estas funciones tiene variantes asociadas a cada clase 
# posible. Es decir, hay una versión de mean para trabajar con matrices, otra 
# para data.frames, etc... Todas estas variantes se pueden ver de la siguiente 
# manera:
methods(mean)

# Como se puede ver, hay 6 métodos posibles para la función mean. Estos 
# métodos se asocian a 6 clases de objetos distintas y podemos ver los nombres 
# de esas clases luego del punto (ej: mean.data.frame es la versión de mean 
# específica para trabajar con data.frames).

# Entonces, cuando el usuario ejecuta la función mean, R primero verifica 
# el nombre de la clase del objeto de entrada y luego usa la versión de mean 
# adecuada para dicha clase. Veamos dos ejemplos, una matriz y un data.frame:
nums <- rnorm(20)         # 20 valores aleatorios
(m <- matrix(nums, 4, 5)) # Matriz de 4 x 5, hecha con esos números
(d <- as.data.frame(m))   # Una data.frame hecha a partir de m

# Una vez creadas, veamos cómo funciona mean para ambas:
mean(m)
mean(d)

# Nótese que, al menos para R 2.15, esto da un mensaje de advertencia. Sin 
# embargo esto es secundario, ya que lo importante es que hay una importante 
# diferencia en los resultados: para la matriz se hizo el promedio de todos 
# los números, mientras que para la data.frame se hicieron los promedios por 
# columna (lo que se puede hacer con colMeans o sapply también).

# Es bueno mencionar también que ciertos objetos de R sofisticados suelen 
# tener varias clases, anotadas de forma ordenada, de forma que si no se 
# encuentra el método adecuado para la primera, entonces busca utilizar la 
# segunda clase y así sucesivamente.

# A lo largo del curso nos vamos a ir enfrentando a distintos ejemplos de
# clases y cómo interactúan con los objetos y funciones de R. Es
# importante estar atento a los tipos de objetos con los que estamos
# trabajando, ya que de esto depende si el resultado de un comando da el
# valor correcto y esperado, un error o, peor aún, da un resultado
# incorrecto sin avisarnos con un mensaje de error apropiado.
