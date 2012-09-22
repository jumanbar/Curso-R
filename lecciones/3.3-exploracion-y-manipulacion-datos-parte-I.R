## Trabajo con tablas: una introducción (parte I)

# Debe notarse que en nuestras lecciones usamos de forma vaga y poco rigurosa los
# términos "matriz", "tabla" o "data.frame". En todos los casos, a menos que se 
# especifique, estos términos referirán a objeto de la clase "data.frame".
# Nótese que tanto "matrix" como "table" también son clases de objetos en R
# y existe siempre la posibilidad que confundirlos lleve a algún tipo de error.

# NOTA: En esta lección vamos a usar varias bases de datos que vienen incluidas
# en el paquéte "datasets", el cual está incluido en el R básico. Para ver
# la lista completa: library(help='datasets')

# En otros paquetes también hay bases de datos, pero no están disponibles de
# forma automática, si no que generalmente hay que usar la función "data" (no 
# correr):
data(basededatos)


### Exploración inicial

# Cuando recién empezamos a trabajar con un conjunto de datos, es necesario 
# hacer un poco de exploración para ver a qué nos enfrentamos.
# Existen varias formas de extraer información básica de un objeto con
# datos, ya sean listas, matrices, data.frames o la cualquier otra clase.
# Algunos comandos funcionan con todas ellas, particularmente la función 'str'.
# Otros como 'colnames' o 'rownames' sólo sirven para objetos de dos dimensiones
# (como matrices).

# Muchas veces nos interesa saber si nuestras tablas
# quedaron bien importadas o si realizar un visualización rápida de como son
# las variables y sus valores.  Para esto existen dos funciones muy útilies
# que nos dan a conocer las 6 primeras o últimas filas de nuestra tabla.
# Estas son las funciones 'head' y 'tail' respectivamentte. Ejemplos:
head(cars)
head(cars, 3)
tail(cars)

# Esto es muy util si no queremos desplegar la tabla completa en la consola,
# ya muchas veces es tan grande que no se alcanza a ver la 'cabeza' de la misma
# por su tamaño.

# La función 'View' es similiar a la función 'head' solo que tanto en R como
# en RStudio, nos abre otra ventana o petaña respectivamente, y nos muestra
# la tabla con un formato tipo planilla de cálculo y en una mayor cantidad
# de filas.
View(iris)

# En RStudio si ud 'cliquea' sobre un objeto en el panel de workspace, R 
# ejecutará este mismo comando. Lo puede corroborar porque en la consola de 
# aparece el mismo al momento de cliquear

# Adicionalmente, si se trabaja por fuera de RStudio es posible utilizar la 
# función fix para cambiar data.frames usando una ventana interactiva. Por 
# ejemplo, es posible cambiar la matriz "quakes" de la siguiete manera:
fix(quakes)


## Nombres

# El uso de nombres para diferenciar los elementos de vectores, matrices,
# listas, etc., es una característica notable de R.  Para ver o cambiar estos
# nombres existen cuatro comandos básicos:
?names
?colnames
?rownames
?dimnames

# La función 'names' devuelve los nombres de los elementos de una lista,
# incluyendo el caso especial de los data.frames. Para ver como funciona esta
# función utilizaremos un base de datos que tiene por defecto R, USArrests:
# Para más información sobre la misma:
?USArrests

names(USArrests)
# El resultado es un vector de caracteres con los nombres de
# las variables o columnas de la base de datos.

# La función 'colnames' devuelve los nombres de los elementos de un objeto
# tipo matriz, debe tener dos dimensiones.  Para ver como funciona esta
# función utilizaremos un base de datos que tiene por defecto R, iris:
# Para más información sobre la misma:
?iris
colnames(iris)
# En este caso 'colnames' nos retorna el nombre de las variables (columnas) de 
# la base de datos en forma de vector de caracteres.
# Muchas veces sucede que 'names' y 'colnames' devuelven los mismos objetos.
# Los nombres de las filas se consiguen o modifican con: rownames(iris) Al
# igual que en los demás casos, obtenemos un vector de caractres.

# Para ver cómo modificar los nombres de un obtejo, bien sirve un ejemplo:
m <- head(iris, 5) # m es una data.frame con las primeras 5 filas de iris
# Usando la siguiente sintaxis, puedo cambiar el nombre de la tercer columna:
colnames(m)[3] <- 'Largo.de.Petalo'
# O se pueden cambiar todos juntos:
colnames(m) <- c('Largo.de.Sepalo', 'Ancho.de.Sepalo', 'Largo.de.Petalo',
                 'Ancho.de.Petalo', 'Especie')

# En este caso usar la función names es equivalente, ya que se trata de un 
# data.frame (que es un caso particular de lista). La función rownames trabaja 
# de manera similar con las filas de una matriz o data.frame.

# En general los nombres de los elementos se pueden usar en combinación con 
# los corchetes, como en el siguiente ejemplo:
m[,"Especie"]
# Nótese el uso de las comillas!. Esta sintaxis sirve para cualquier tipo de 
# vector/matriz/data.frame/lista que usemos en R.

# A su vez, como vimos antes, para listas y data.frames existe el operador $, 
# en caso de que los elementos tengan nombres asignados. El caso anterior se 
# podría haber hecho así entonces:
m$Especie

# NOTA: en R y RStudio se pueden autocompletar los nombres de los elementos
# usando la tecla tab inmediatamente después del operador $, por ejemplo: iris$
# + tab Esto nos sirve para ver el nombre de los componentes de la tabla o lista.


## Función str (estructura)

# La función genérica 'str' es sumamente práctica para obtener información 
# básica y resumida de cualquier objeto, incluyendo tablas de datos.
# Por ejemplo:
str(USArrests)

# Lo primero que indica es la clase del objeto, en este caso "data.frame".
# Además muestra las dimensiones del mismo (50 observaciones/filas,
# 4 variables/columnas).  Luego muestra las variables que componen al set
# de datos, usando el símbolo de '$' para indicar el nombre de cada una.
# En cada caso muestra la clase del objeto en cuestión ('num' por 'numeric',
# 'int' por 'integer', etc...). Por último aparecen los primeros valores,
# seguidos por puntos suspensivos.

# Este comando es importante recordar debido a que es sumamente flexible,
# de forma que sirve para casi cualquier objeto en R.

# Algunos objetos simples ...

# 1. Una matriz corriente:
x <- matrix(sample(20), 5, 4)
str(x)
# Aquí la clase del objeto es 'matrix', pero sólo muestra 'int', indicando que 
# los valores del objeto son todos 'integer'. Las dimensiones de la matriz 
# aparecen entre paréntesis rectos (1:5 en filas y 1:4 en columnas, separadas
# por la coma).

# 2.  Un objeto tipo lista:
propios <- eigen(matrix(sample(20), 5, 5))
str(propios)
# En este caso el objeto evaluado es una lista, cuyos elementos son 'values' y
# 'vectors'.  El primero es un vector numérico, de 5 valores (indicado por los
# [ ]).  El segundo es una matriz, de 5x5, también indicado por los [ ].

# La lista completa de clases con las que str puede trabajar:
methods(str)


## Función summary (resumen):

# Literalmente 'summary' es un sumario o resumen de un objeto. Esta es una 
# función genérica muy flexible, abarcando métodos para la mayoría de las 
# clases de objetos, como puede verse con el comando:
methods(summary)
# Mirando la tabla 'iris' podemos encontrar dos tipos de salida, una para 
# variables numérica y otra categórica (factor).
summary(iris)

# Cuando se trata con variables numéricas, como se puede ver en este ejemplo,
# se calculan algunos estadísticos de diagnóstico, como el promedio o los
# cuartiles. Para el caso del factor 'iris$Species' simplemente muestra los
# niveles y la cantidad de veces que ocurren en la tabla.

# A su vez se puede guardar la salida del summary en un nuevo objeto, el cual
# será de la clase 'table':
x <- summary(iris)
str(x)

# summary suele ser muy útil también para ver salidas de funciones complejas
# como regresiones lineales u otros objetos elaborados.


## Resumen

# Como hemos visto en esta lección, en R existen varios comandos convenientes
# para trabajar con tablas de datos. Como probablemente sospeche el lector
# atento, las facilidades para este tipo de tareas no están cubiertas por
# completo en esta lección y, si le interesa, seguramente encontrará más
# utilidades prácticas. De todas formas, no dudemos de que las funciones aquí
# cubiertas responden a gran parte de las tareas ha realizar en el día a día.

