## Funciones

# La creación de funciones es la principal utilidad de un lenguaje programado,
# aún en un lenguaje orientado a la estadística como R. Anteriormente nos
# ocupamos de distintos tipos de objeto que podemos encontrar en R. En la pre-
# sente unidad nos dedicaremos a la comprensión de la estructura y funcionamien-
# to de las funciones, así como a la creación y corrección de las mismas.

## ¿Para qué hacer funciones?

# El primer motivo que encontramos para escribir funciones es la practicidad.
# Esto es cierto en situaciones en las que se debe realizar un procedimiento
# que requiere la ejecución de comandos en un orden específico, o volver a eje-
# cutar una serie de comandos que nos quedó muy atrás en el historial y sabemos
# que los vamos a tener que utilizar nuevamente. En casos como estos, puede
# ahorrarnos tiempo y esfuerzo escribir una función que contenga estos pasos y
# que podamos utilizar una y otra vez. Un ejemplo claro de esto es la función
# 'sort', que ejecuta las instrucciones necesarias para ordenar un vector.

x <- sample(1:15)  # Si generamos un vector muestreando los valores de 1 a 15
sort (x)  # la ejecución de 'sort' nos devuelve este vector ordenado.

# Dentro de esta función están las instrucciones necesarias para realizar la
# tarea, y que se ejecutarán sin necesidad de hacerlo paso a paso.

sort

# Más adelante volveremos sobre la estructura de las funciones, su anatomía,
# para entender qué exactamente es cada uno de sus componentes.

# El segundo motivo, que se desprende del anterior, es la generalización.
# Muchas veces vamos a generar una función para atender a un caso particular,
# a un determinado set de datos o situación. Sin embargo, en la medida en que
# las funciones que escribimos nos resulten útiles, es importante poder pasar
# de su aplicabilidad a valores fijos a utilizar variables que podamos modificar
# en cada caso. Veamos un ejemplo, en la creación de una función que nos permita
# calcular el área de un triángulo.

# El problema planteado es el área de un triángulo que presenta 3 cm de base y
# 4 de altura. La forma más sencilla de estimar la misma es, directamente,

4 * 3 / 2

# Sin embargo, si necesitamos hallar el área de varios triángulos, podemos crear
# la función 'area', utilizando base y altura como variables.

area <- function(a, b) {
  a * b / 2
}

area (4, 3)    # Podemos usarla con las medidas de nuestro triángulo
area (12, 10)  # o de cualquier otro.

# En este caso, es muy sencillo entender que se pasó del caso particular de un
# par de valores de base y altura a una función que corre para cualquier par de
# valores. En este sentido, la abstracción es similar a lo que uno ve en las
# matemáticas, en el sentido de pasar de valores particulares a símbolos que
# pueden ser sustituidos en una ecuación por valores conocidos, logrando poder
# aplicar la función a cualquier situación similar.

# Otro ejemplo más ilustrativo puede ser el siguiente: teniendo un vector `x` de
# 15 elementos, podemos calcular su promedio de la siguiente manera:

x <- rpois(15, 4)
p <- sum(x) / 15
p

# Este código sólo sirve para `x` u otro vector con 15 elementos. Si queremos
# adaptar este código para calcular el promedio de cualquier vector, indepen-
# dientemente de su longitud, vamos a tener que sustituir este valor por la
# longitud de un vector genérico, empleando `length(x)`.

p <- sum(x) / length(x)

# En este caso, aún sin crear una función, hemos ganado en abstracción, ya que
# salimos del caso concreto en el que `x` tiene 15 elementos y ahora podemos
# utilizar esta línea de código para hacerlo para cualquier vector `x` posible.
# Pero aún dependemos de esta línea de comando, que podemos haber olvidado o
# puede haber quedado muy atrás en el historial y volver a encontrarla para
# ejecutarla puede ser un derroche de tiempo y esfuerzo. Sin mencionar que el
# vector tiene necesariamente que llamarse `x` para que funcione. En este caso
# puede ser más sencillo crear una función que haga la operación deseada.

f <- function(v) {
  p <- sum(v) / length(v)
  p
}

f(rpois(19, 23))  # Y sabemos que devuelve un resultado para cualquier vector

# Si bien puede parecer un derroche crear una función para una operación tan
# sencilla. Esto es cierto, pero también debe tenerse en cuenta que se pueden agregar nuevas
# capacidades y detalles a la función, consideremos la situación en que nuestro vector 
# presenta NAs:

x <- rpois(20, 10)
x[c(3, 6, 7)] <- NA
f(x)

# En tal caso, deberemos agregar un comando para descartar dichos valores en la
# propia función, por ejemplo creando un objeto 'v' dentro de la misma que sea
# nuestro vector sin los NAs.

f <- function(v) {
  v <- v[!is.na(v)]
  p <- sum(v) / length(v)
  p
}

f(x)

# Como último detalle, no es necesario que las funciones representen una
# abstracción o generalización de una operación a partir de un caso concreto.
# Es posible crear funciones sin argumentos, cosas tan simples como:

g <- function() print("Hola mundo")
g()

# En la próxima lección exploraremos los componentes que hacen a las funciones,
# en una suerte de lección de anatomía de las mismas.
