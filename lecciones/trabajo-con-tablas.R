## TRABAJO CON TABLAS: UNA INTRODUCCIÓN

# En esta lección se van a mostrar algunos métodos básicos y muy útiles
# para resolver problemas comunes asociados al trabajo con tablas de datos.
# Se cubren aspectos sencillos, tal como obtener información, efectuar
# cálculos por filas o columnas, etc. Se deja afuera todo lo referente a
# manipulación de tablas, lo que será cubierto en otra de las lecciones.

# Debe notarse que en nuestras lecciones usamos de forma vaga los términos
# "matriz", "tabla" o "data.frame". En todos los casos, a menos que se
# especifique, estos términos referirán a objeto de la clase "data.frame".
# Nótese que tanto "matrix" como "table" también son clases de objetos en R y
# existe siempre la posibilidad que confundirlos lleve a algún tipo de error. 


# INFORMACIÓN BÁSICA
# Existen varias formas de extraer información básica de un objeto con datos,
# ya sean listas, matrices, data.frames o la cualquier otra clase. Algunos
# comandos funcionan con todas ellas, particularmente "str". Otros como
# colnames o rownames sólo sirven para objetos de dos dimensiones (como
# matrices).
 
# Nombres
# El uso de nombres para diferenciar los elementos de vectores, matrices,
# listas, etc., es una característica notable de R. Para ver o cambiar estos
# nombres tres comandos básicos: la función "names" devuelve los nombres de los
# elementos de una lista, incluyendo el caso especial de las data.frames.
names(USArrests)
colnames(USArrests)
# En este caso names y colnames devuelven lo mismo, por las características de
# las data.frames.

# Nota: en R y RStudio se pueden autocompletar los nombres de los elementos
# usando la tecla tab inmediatamente después del operador $, por ejemplo:
# iris$ + tab
# Esto nos sirve para ver el nombre de los componentes de la tabla o lista. 

# Los nombres de las filas se consiguen o modifican con:
rownames(USArrests)

# Estructura (str):
# La función "str" es sumamente práctica para obtener información básica y
# resumida de cualquier objeto, incluyendo tablas de datos. Por ejemplo:

str(USArrests)
# 'data.frame':	50 obs. of  4 variables:
#  $ Murder  : num  13.2 10 8.1 8.8 9 7.9 3.3 5.9 15.4 17.4 ...
#  $ Assault : int  236 263 294 190 276 204 110 238 335 211 ...
#  $ UrbanPop: int  58 48 80 50 91 78 77 72 80 60 ...
#  $ Rape    : num  21.2 44.5 31 19.5 40.6 38.7 11.1 15.8 31.9 25.8 ...

# Lo primero que indica es la clase del objeto, en este caso "data.frame".
# Además muestra las dimensiones del mismo (50 observaciones/filas, 4
# variables/columnas).

# Luego muestra las variables que componen al set de datos, usando el símbolo
# "$" para indicar el nombre de cada una. En cada caso muestra la clase del
# objeto en cuestión ("num" por "numeric", "int" por "integer", etc...).

# Por último aparecen los primeros valores, seguidos por puntos suspensivos.
 
# Este comando es importante recordar debido a que es sumamente flexible, de
# forma que sirve para casi cualquier objeto en R.

# Algunos objetos simples:
# 1.
x <- matrix(sample(20), 5, 4)
str(x)
# int [1:5, 1:4] 17 3 9 5 16 2 13 14 10 19 ...
# Aquí la clase del objeto es "matrix", pero sólo muestra "int", indicando que
# los valores del objeto son todos "integer". Las dimensiones de la matriz
# aparecen entre paréntesis recto (1:5 en filas y 1:4 en columnas, indicadas por
# la coma).

# 2.
# Un objeto de la clase "dist":
a <- matrix(rnorm(8), ncol=2)
b <- dist(a)
str(b)

# 3.
# Un objeto tipo "lista":
propios <- eigen(matrix(sample(20), 5, 5))
str(propios)
# List of 2
#  $ values : num [1:5] 5.20e+01 1.36e+01 8.83 5.18e-01 -1.61e-14
#  $ vectors: num [1:5, 1:5] -0.559 -0.223 -0.397 -0.456 -0.521 ...
# En este caso el objeto evaluado es una lista, cuyos elementos son "values" y
# "vectors" El primero es un vector numérico, de 5 valores (indicado por los [
# ]). El segundo es una matriz, de 5x5, también indicado por los [ ].

 
# Resumen (summary):
# Literalmente "summary" es un sumario o resumen de un objeto. Esta es una
# función también muy flexible y va a tener resultados distintos para
# distintas clases de objetos, sobre todo si lo usamos para variables
# numéricas o categóricas.
# Mirando la tabla "iris" podemos ver los dos tipos de salida: todas las
# variables son numéricas excepto "Species" que es categórica (factor).
summary(iris)
# Cuando trata con variables numéricas, como se puede ver en este ejemplo,
# calcula algunos estadísticos de diagnóstico, como el promedio o los
# cuartiles.
# Para el caso de la columna "Species" simplemente muestra los niveles y la
# cantidad de veces que ocurren en la tabla.

# A su vez se puede guardar la salida del summary en un nuevo objeto, el cual
# será de la clase "table":
x <- summary(iris)
str(x)
# Para la mayoría de los efectos prácticos, este salida es una matriz
# "character" de 6x5, por lo que podemos usar los paréntesis rectos para ver
# sus elementos:
x[1, 2] # "Min.   :4.300  "


# Clases
# Cuando se trabaja con estructuras de datos complejos es importante prestar
# atención a las clases a las que pertenecen los mismos. Esto se puede hacer
# de varias formas, siendo las funciones más básicas "class" y "str".
# Mientras que str muestra la clase de todas las variables/columnas en una
# tabla, la función class debe usarse de a una variable a la vez. Por ejemplo,
# para la base iris las clases de las columnas 1, 2 y 5 son:
class(iris[,1])         # "numeric"
class(iris$Sepal.Width) # "numeric"
class(iris$Species)     # "factor"
 
 
# Conteos
# Las funciones tabulate y table realizan conteos de cada observación,
# devolviendo objetos ligeramente diferentes:
tabulate(iris$Species)   # 50 50 50; clase "integer"
table(iris$Species) -> x # Tienen nombres; clase "table"
# tabulate: es simplemente un vector numérico con el conteo de ocurrencias (a
# veces llamado frecuencias) de cada categoría.
# table: devuelve un objeto "table", cuyos elementos están "nombrados":
x['setosa']
# setosa
#     50

# Nota: esto puede darse para confusiones si las categorías mismas son
# números enteros, 1, 2, 3, etc...

# Alternativa: paquete plyr
# La función "count" del paquete plyr sirve para hacer conteos por
# categorías, devolviendo el resultado en un formato diferente (requiere
# instalar el paquete plyr):
library(plyr)
count(iris$Sepal.Width)
count(as.vector(iris$Species))
  
 
# APLICAR FUNCIONES
# En R existen algunas funciones útiles que hacen cálculos por columna o fila
# en una tabla de datos. Un ejemplo sencillo es colMeans: calcula el promedio
# de todas las columnas, por ejemplo:
x <- colMeans(USArrests)

# En general hacer este tipo de tareas por fila o por columnas suele ser
# necesario. Utilizando lo visto en estructuras de control se puede ver que un
# loop sencillo puede servir para este propósito. Por ejemplo, para calcular
# promedios por columna puedo hacer:
x <- numeric(ncol(USArrests))
for (i in 1:ncol(USArrests)) {
  x[i] <- mean(USArrests[, i])
}

# Sin embargo estas soluciones en general es preferible evitarlas, por dos
# razones:
# 1. Los loops escritos en R son más lentos que los loops "internos" de otras
#    funciones, como el que existe dentro de "colMeans"
# 2. Existen herramientas más elegantes y eficientes para hacer estas tareas
#    simples: el grupo de funciones "apply"

# Función "apply":
# Es una función que "aplica" otra función a un conjunto de datos según un
# cierto criterio (por filas, columnas, etc...).
# Siguiendo el ejemplo anterior, podemos crear un substituto de colMeans de la
# siguiente forma:
x <- apply(USArrests, 2, mean)

# Veamos cómo funciona:
?apply
# X:
# El primer argumento es un "array" (lo que incluye matrices, data.frames, y
# otros tipos de objetos...).
# MARGIN:
# El segundo argumento refiere a los subíndices a los que se aplica la función.
# Por ejemplo, si vale 1 la función se aplica a todas las filas;
# si vale 2 se aplica a todas las columnas; si vale c(1, 2) se aplica a filas y
# columnas (esto en caso de que el objeto "X" tenga más de 2 dimensiones, en
# una matriz no tendría sentido).
# FUN:
# En el tercer argumento es la función en cuestión. En nuestro caso es la
# función "mean".
# ...:
# Este argumento especial indica que se pueden agregar más argumentos según
# lo que necesite FUN para correr, usando los nombres adecuados (ver más
# abajo).

# Más ejemplos:
apply(USArrests, 2, mean)   # El promedio de todas las columnas
apply(USArrests, 1, mean)   # El promedio de todas las filas
apply(USArrests, 1:2, mean) # El promedio de todas las filas y colmnas
# Este último es idéntico a la tabla original USArrests ...

# El caso del argumento especial "...":
apply(USArrests, 2, quantile, probs=c(0.25, 0.75))
# En este caso FUN es la función quantile y el argumento extra es "probs".
# Podemos ver que este es un argumento que usa quantile para hacer sus cálculos:
args(quantile)

# Variantes:
# lapply, sapply, vapply y replicate son variantes de la función apply. Estas
# trabajan de forma ligeramente diferente, pero el objetivo es similar siempre.

# Por ejemplo, lapply trabaja con listas, aplicando la función FUN a todos los
# elementos. Por lo tanto, se puede usar con data.frames (y siempre aplicará
# la función en cuestión a las columnas):
lapply(USArrests, mean)
# Aquí se obtiene el mismo resultado que con colMeans, pero con una salida del
# tipo lista.

# La función sapply hace exactamente lo mismo pero devuelve un vector común:
sapply(USArrests, mean)


# Funcies with y within
# Estas funciones sirven para ejecutar comandos "adentro" de una lista... Esto
# es útil ya que permite trabajar con los nombres de las variables
# directamente, en lugar de estar recordando los números de columnas y usando
# llaves todo el tiempo. 

# Los argumentos son:
# data: una lista que sirva para construir un "ambiente" en el cual ejecutar los comandos.
# En este ambiente los objetos existentes son los elementos de la lista
# expr: una expresión, un comando, o varios si se usan las llaves { }.
 
# Por ejemplo, creo una lista sencilla:
(lista <- list(x=5, y=rnorm(7), z=sample(7)))
# Dentro de esta lista, tengo los elementos x y z. Voy a usar estos valores
# para calcular x * y + z:
(u <- with(lista, x * y + z))

# Nótese que si no uso "with" tengo que escribir lo siguiente:
u <- lista[[1]] * lista[[2]] + lista[[3]]
# o
u <- lista$x * lista$y + lista$z
 
# Dado que las "data.frame" son listas también, se puede usar with de la misma
# forma. Por ejemplo, con la tabla "iris":
(u <- with(iris, Sepal.Length + Sepal.Width))
# Siempre se usan los nombres correspondientes. Este cálculo equivale a:
iris$Sepal.Length + iris$Sepal.Width

# La ganancia de usar with parece poca en este caso, sin embargo para cálculos
# más complejos las diferencias se vuelven significativas. Una estrategia
# común es usar las llaves { } dentro del mismo paréntesis (en el segundo
# argumento, donde va la expresión). A modo de ejemplo:
u <- with(lista, {
            a <- rep(y, z)
            b <- matrix(a, 7, 7)
            y <- b ^ x
            y
          })
u

# La salida (guardada aquí como "u") es el último comando de los que están entre
# las { }, siguiendo el criterio aplicado para "bloques de código" (ver la
# lección "uso de llaves"). Nótese el uso de la indentación, siguiendo el
# criterio de agregar una tabulación luego de la llave de apertura...

# Función within
# La función within devuelve una versión modifiada de la lista de entrada:
iris2 <- within(iris, Sepal.Ratio <- Sepal.Length / Sepal.Width)
head(iris2)
# Se puede ver que existe una nueva columna llamada "Sepal.Ratio". Este tipo
# de operaciones requiere que la nueva variable creada tenga el mismo número
# de observaciones que el resto de la tabla. En lo que refiere a las demás
# reglas de uso, "within" es idéntica a "with".


## FUNCIONES "tapply" y "by"

# Ya vimos que apply y sus variantes sirven para hacer cálculos en tablas
# aplicados a filas o columnas, o a elementos de una lista. Las funciones
# tapply y by dan un paso más en sofisticación: no sólo hacen cálculos por
# columna, si no que también por las categorías que defina el usuario, dentro
# del grupo de las observaciones.

# Por ejemplo, supongamos que nos interesa tomar la base de datos iris y
# calcular los promedios, no sólamente para cada variable (Sepal.Length,
# Sepal.Width, etc...), si no que además queremos separar por especie (setosa,
# versicolor y virginica).

# Para lograr esto debemos definir primero que nada las variables para las que
# queremos aplicar la función "mean": serían todas las variables menos
# "Species":
variables <- iris[, -5]

# Ahora debemos definir las categorías, que obviamente son las contenidas en
# la columna "Species" de iris:
categorias <- iris$Species

# Ya que vamos a usar la función mean y no necesitamos argumentos secundarios,
# podemos pasar a hacer los cálculos directamente, utilizando la función "by":
u <- by(variables, categorias, mean)
# (alguien ha criticado ya el mal ordenamiento de los argumentos de by...)
u
# El objeto generado muestra exactamente lo que estábamos buscando. Es un
# objeto tipo lista, de clase "by". Para trabajar con los valores contenidos
# se pueden utilizar los operadores de listas, [[]] y $, aunque es un poco
# engorroso. Tal vez más sencillo sea convertir esta salida en matriz, usando
# la función "unlist" (as.matrix no da un resultado muy bueno en este caso):
x <- unlist(u)
x <- matrix(x, nrow=nlevels(categorias))

# La función tapply hace exactamente lo mismo, pero de forma más limitada:
# sólo puede ir de a una variable a la vez. Por ejemplo usando sólamente
# Sepal.Width podemos hacer de vuelta los cálculos anteriores:

variable <- iris$Sepal.Width
# La variable es nueva, las categorías son las mismas, así que se puede pasar
# directamente al comando:
v <- tapply(variable, categorias, mean)
# El resultado es mucho más simple, un vector numérico:
v
#     setosa versicolor  virginica 
#      3.428      2.770      2.974

# Nótese que en los dos ejemplos expuestos los objetos generados tienen
# similitudes y diferencias, y pertenecen a clases diferentes:
class(u)
class(v)


# REDONDEANDO
# Como hemos visto en esta lección, en R existen varios comandos convenientes
# para trabajar con tablas de datos. Como probablemente sospeche el lector
# atento, las facilidades para este tipo de tareas no están cubiertas por
# completo en esta lección y, si le interesa, seguramente encontrará más
# utilidades prácticas. De todas formas, no dudemos de que las funciones aquí
# cubiertas responden a la gran mayoría de tareas ha realizar en el día a día.
# El complemento de esta lección es la referente a las herramientas para
# manipular tablas.
