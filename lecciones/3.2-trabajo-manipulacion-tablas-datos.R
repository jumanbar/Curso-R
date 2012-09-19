
# Trabajo y Manipulación con Tablas: una Introducción

# En esta lección se van a mostrar algunos métodos básicos y muy útiles para resolver problemas comunes asociados al trabajo con tablas de datos y su manipulación.
# Se cubren aspectos sencillos, tal como obtener información, efectuar cálculos por filas o columnas, etc. 

# La mayoría de las veces es recomendable aprovechar los programas con los que uno se siente más cómodo para manipular nuestras tablas/bases de datos. 
# De todas formas, existen varias funciones en R para lograr nuestros objetivos, varias de las cuales pueden ser sumamente prácticas en muchos casos.

# Debe notarse que en nuestras lecciones usamos de forma vaga los términos "matriz", "tabla" o "data.frame". 
#En todos los casos, a menos que se especifique, estos términos referirán a objeto de la clase "data.frame".
# Nótese que tanto "matrix" como "table" también son clases de objetos en R y existe siempre la posibilidad que confundirlos lleve a algún tipo de error. 

NOTA: En esta unidad vamos a usar varias bases de datos que vienen incluidas en el paquéte "datasets", el cual está incluido en el R básico.
# Para ver la lista completa:
library(help='datasets')

# En otros paquetes también hay bases de datos, pero no están disponibles de forma automática, si no que generalmente hay que usar la función "data":
data(basededatos) # (no correr)

# Existen varias formas de extraer información básica de un objeto con datos, ya sean listas, matrices, data.frames o la cualquier otra clase. 
# Algunos comandos funcionan con todas ellas, particularmente la función 'str'. 
# Otros como 'colnames' o 'rownames' sólo sirven para objetos de dos dimensiones (como matrices).

# Nombres
# El uso de nombres para diferenciar los elementos de vectores, matrices, listas, etc., es una característica notable de R.
# Para ver o cambiar estos nombres existen cuatro comandos básicos:
?names
?colnames
?rownames
?dimnames

# La función 'names' devuelve los nombres de los elementos de una lista, incluyendo el caso especial de los data.frames.
# Para ver como funciona esta función utilizaremos un base de datos que tiene por defecto R, USArrests:
# Para más información sobre la misma:
?USArrests

names(USArrests)
# El resultado es un vector de caracteres con los nombres de las variables o columnas de la base de datos.

# La función 'colnames' devuelve los nombres de los elementos de un objeto tipo matriz, debe tener dos dimensiones.
# Para ver como funciona esta función utilizaremos un base de datos que tiene por defecto R, iris:
# Para más información sobre la misma:
?iris
colnames(iris)
# En este caso 'colnames' nos retorna el nombre de las variables (columnas) de la base de datos en forma de vector de caracteres.
# Muchas veces sucede que 'names' y 'colnames' devuelven los mismos objetos.

# Los nombres de las filas se consiguen o modifican con:
rownames(iris)
# Al igual que en los demás casos, obtenemos un vector de caractres.

# La función 'dimnames' nos devuelve una lista con los nombres de cada una de las dimensiones de una matriz, array o data.frame.
dimnames(USArrests)

dimnames(iris)

# NOTA: en R y RStudio se pueden autocompletar los nombres de los elementos usando la tecla tab inmediatamente después del operador $, por ejemplo:
# iris$ + tab
# Esto nos sirve para ver el nombre de los componentes de la tabla o lista.

# Estructura (str):
# La función 'str' es sumamente práctica para obtener información básica y resumida de cualquier objeto, incluyendo tablas de datos.
# Por ejemplo:
str(USArrests)
# 'data.frame':  50 obs. of  4 variables:
#  $ Murder  : num  13.2 10 8.1 8.8 9 7.9 3.3 5.9 15.4 17.4 ...
#  $ Assault : int  236 263 294 190 276 204 110 238 335 211 ...
#  $ UrbanPop: int  58 48 80 50 91 78 77 72 80 60 ...
#  $ Rape    : num  21.2 44.5 31 19.5 40.6 38.7 11.1 15.8 31.9 25.8 ...

# Lo primero que indica es la clase del objeto, en este caso "data.frame".
# Además muestra las dimensiones del mismo (50 observaciones/filas, 4 variables/columnas).
# Luego muestra las variables que componen al set de datos, usando el símbolo de '$' para indicar el nombre de cada una. 
# En cada caso muestra la clase del objeto en cuestión ('num' por 'numeric', 'int' por 'integer', etc...).
# Por último aparecen los primeros valores, seguidos por puntos suspensivos.

# Este comando es importante recordar debido a que es sumamente flexible, de forma que sirve para casi cualquier objeto en R.

# Algunos objetos simples:
# 1.
x <- matrix(sample(20), 5, 4)
str(x)
# int [1:5, 1:4] 17 3 9 5 16 2 13 14 10 19 ...
# Aquí la clase del objeto es 'matrix', pero sólo muestra 'int', indicando que los valores del objeto son todos 'integer'.
# Las dimensiones de la matriz aparecen entre paréntesis recto (1:5 en filas y 1:4 en columnas, indicadas por la coma).

# 2.
# Un objeto tipo "lista":
propios <- eigen(matrix(sample(20), 5, 5))
str(propios)
# List of 2
#  $ values : num [1:5] 5.20e+01 1.36e+01 8.83 5.18e-01 -1.61e-14
#  $ vectors: num [1:5, 1:5] -0.559 -0.223 -0.397 -0.456 -0.521 ...
# En este caso el objeto evaluado es una lista, cuyos elementos son 'values' y 'vectors'.
# El primero es un vector numérico, de 5 valores (indicado por los [ ]). 
# El segundo es una matriz, de 5x5, también indicado por los [ ].

# Resumen (summary):
# Literalmente 'summary' es un sumario o resumen de un objeto.
# Esta es una función también muy flexible y va a tener resultados distintos para distintas clases de objetos, sobre todo si lo usamos para variables numéricas o categóricas.
# Mirando la tabla 'iris' podemos ver los dos tipos de salida: todas las variables son numéricas excepto 'Species' que es categórica (factor).
summary(iris)

# Cuando se trata con variables numéricas, como se puede ver en este ejemplo, se calculan algunos estadísticos de diagnóstico, como el promedio o los cuartiles.
# Para el caso de la columna 'Species' simplemente muestra los niveles y la cantidad de veces que ocurren en la tabla.

# A su vez se puede guardar la salida del summary en un nuevo objeto, el cual será de la clase 'table':
x <- summary(iris)
str(x)
# Para la mayoría de los efectos prácticos, este salida es una matriz tipo 'character' de 6x5, por lo que podemos usar los paréntesis rectos para ver sus elementos:
x[1, 2]
# En este caso nos esta devolviendo el elemento de la primer fila y segunda columna de summary(iris)

# Clases
# Cuando se trabaja con estructuras de datos complejos es importante prestar atención a las clases a las que pertenecen los mismos.
# Esto se puede hacer de varias formas, siendo las funciones más básicas 'class' y 'str'.
# Mientras que 'str' muestra la clase de todas las variables/columnas en una tabla, la función 'class' debe usarse de a una variable a la vez.
#  Por ejemplo, para la base 'iris', las clases de las columnas 1, 2 y 5 son:
class(iris[,1])         # "numeric"
class(iris$Sepal.Width) # "numeric"
class(iris$Species)     # "factor"

# Conteos
# Las funciones 'tabulate' y 'table' realizan conteos de cada observación, devolviendo objetos ligeramente diferentes:
tabulate(iris$Species)   # 50 50 50; clase 'integer'
table(iris$Species) # Tienen los nombres de los grupos; clase 'table'
# La función 'tabulate' es simplemente un vector numérico con el conteo de ocurrencias (a veces llamado frecuencias) de cada categoría.
# La función 'table' devuelve un objeto 'table', cuyos elementos están "nombrados":
x['setosa']
# setosa
#     50

# NOTA: esto puede darse para confusiones si las categorías mismas son números enteros, 1, 2, 3, etc...

# Selección de Observaciones

# Muchas veces nos interesan, dentro de una tabla, sólo ciertas observaciones basadas con ciertos criterios.
# Generalmente existe la forma de expresar estos criterios utilizando operadores lógicos.

# Una de las formas más sencillas es usar la función 'which' para seleccionar las filas o columnas que nos interesan.
x <- which(cars$dist > 20)
# 'x' tiene los números de fila de las observaciones que cumplen la premisa.
y <- cars[x,]
# 'y' es un vector que selecciona los casos del data set 'cars', que cumple con la condición dist > 20.

# También es posible escribir:
y <- cars[cars$dist > 20,]
# Este método es de alguna forma más directo, aunque tiene la contra que suele amontonar palabras y caracteres, resultando en cosas difíciles de leer.

# Si queremos buscar en todos los elementos de una matriz o data.frame, se puede usar el argumento "arr.ind":
which(cars > 70, arr.ind=TRUE)

# Como se puede ver, el resultado son las filas y columnas de los elementos que cumplen con la condición dada.

# Usando operadores lógicos se pueden hacer filtros más elaborados:
x <- which(cars$dist > 20 & cars$speed <= 15)
y <- cars[x,]
# Selecciona los casos que cumplen dist > 20 y speed <= 15

# Para el caso de data.frames, el R tiene una función para hacer esto, la cual es más recomendable en general: 'subset'
?subset

# Para hacer exactamente lo mismo que antes, pero con subset:
y <- subset(cars, subset=dist > 20 & speed <= 15)

# El argumento 'subset' (sí, el argumento se llama igual que la función, espero no sea demasiado confuso) acepta un vector lógico.
# Se puede hacer en dos pasos:
x <- dist > 20 & speed <= 15
y <- subset(cars, subset=x)

# Para los factores hay que usar comillas:
class(iris$Species)  # 'factor'
levels(iris$Species) # 'setosa' 'versicolor' 'virginica'
(y <- subset(iris, Species == 'setosa' & Sepal.Length >= 4.96))

# NOTA: muchas funciones aceptan un argumento 'subset' para seleccionar las observaciones que nos interesan.
# Ejemplos: plot, lm, xtabs, ...

# A su vez el argumetno 'select' sirve para elegir las columnas de interés:
(y <- subset(iris, subset=Sepal.Width > 3.8, select=Species))
# sólo la columna 'Species'
(y <- subset(iris, subset=Sepal.Width > 3.8, select= -Species))
# sin la columna 'Species'
(y <- subset(iris, subset=Sepal.Width > 3.8, select= -5))
# ídem

# En resumen, subset busca ser más intuitivo y directo que usar which() en combinación con los operadores [ ].

# Partiendo Tablas (split):
# A veces es necesario partir una tabla según ciertos criterios.
# La función 'split' debe considerarse como una opción, ya que en una corta línea puede expresar un montón de pasos.
# Por ejemplo, si quiero partir la tabla 'iris' en 3 tablas, una por cada especie, puedo hacer:
irisxspp <- split(iris, iris$Species)

# En el primer argumento se coloca el objeto de R que contiene los valores que deseo separar.
# En el segundo argumento se especifica el grupo (debe ser clase factor) que se desea utilizar para separar la tabla.

str(irisxspp)
# El resultado es una lista con tres data.frames adentro, una por cada especie.

# Calculos en Tablas:
# En R existen algunas funciones útiles que hacen cálculos por columna o fila en una tabla de datos.
# Un ejemplo sencillo es con la función 'colMeans'.
# Esta calcula el promedio de todas las columnas.
# Por ejemplo:
x <- colMeans(USArrests)

# Existe una función similar pero que realiza el calculo para las filas
y <- rowMeans(USArrests)

# También existen las funciones 'colSums' y 'rowSums', para mayor información consulte la ayuda de R.

# Visualización de Tablas:
# Muchas veces nos interesa saber si nuestras tablas quedaron bien importadas o si realizar un visualización rápida de como son las variables y sus valores.
# Para esto existen dos funciones muy útilies que nos dan a conocer las 6 primeras o últimas filas de nuestra tabla.
# Estas son la función 'head' y 'tail' respectivamentte.
head(cars) 
tail(cars) 
head(iris)
tail(iris)

# Esto es muy util si no queremos desplegar la tabla completa en la consola, muchas veces es tan grande que no se alcanza a ver la 'cabeza' de la misma por su tamaño.

# La función 'View' es similiar a la función 'head' solo que tanto en R como en RStudio, nos abre otra ventana o petaña respectivamente, y nos muestra la tabla con un formato tipo planilla de cálculo y en una mayor cantidad de filas.
View(iris)

# En RStudio si ud 'clickea' sobre un Data que se encuentre en el workspace, es equivalente a realizar este comando.
# Lo puede corroborar porque en la consola de R le aparece el comando equivalente a haber realizado dicha acción.

# Por último la función 'quantile' retorna un vector con los valores de los cuantiles basado en sus probabilidades. 
# 0% el valor menos observado y 100% el valor más observado.
quantile(iris$Sepal.Length)

# Observe que la función sólo acepta vectores.

# Redondeo
# Si bien R no es un ambiente para trabajar manipulando tablas por excelencia, es cierto que tiene muchas facilidades que pueden ser muy útiles y prácticas si las sabemos aprovechar.
# En esta lección no hemos hecho más que rascar la superficie de lo que se puede hacer con funciones pre-armadas.
# Para el lector y el usuario ávido, recomendamos adentrarse en el uso de los paquetes reshape2, gdata, bigtabulate y plyr.

# Alternativa: paquete plyr
# La función 'count' del paquete 'plyr' sirve para hacer conteos por categorías, devolviendo el resultado en un formato diferente (requiere instalar el paquete plyr):
library(plyr)
count(iris$Sepal.Width)
count(as.vector(iris$Species))
