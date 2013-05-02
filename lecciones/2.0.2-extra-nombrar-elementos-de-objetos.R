## Nombres de índices en vectores, matrices y listas
 
# Es posible, y muchas veces necesario, adjudicar nombres a los distintos
# índices de vectores, matrices y listas (incluyendo data.frame).
 
## Nombres de los índices de un vector
 
# Dado un vector cualquiera
x <- 1:5
x
# [1] 1 2 3 4 5
 
# Es posible adjudicarle un nombre a los elementos en el mismo mediante la
# función "names".
names(x) <- c("a", "b", "c", "d", "e")
x
# a b c d e 
# 1 2 3 4 5 
 
# Al llamar un elemento de ese vector, va a indicar también el nombre de ese
# elemento:
x[2]
# b 
# 2
 
# A su vez, usando dicho nombre se puede obtener el valor correspondiente (debe
# estar entre comillas):
x['d']
 
# La función "names" también sirve para consultar cuáles son esos nombres
names(x)
# [1] "a" "b" "c" "d" "e"
 
## Nombres de los índices de una matriz
 
# Cuando trabajamos con matrices, estas presentan 2 dimensiones.
y <- matrix(1:20, 4, 5)
dim(y)
 
# Si recordamos, una matriz es básicamente un vector arreglado en dos dimen-
# siones. Probemos a nombrar los 5 primeros elementos:
names(y) <- c("a", "b", "c", "d", "e")
# La función "names" en este caso va a asignar nombres a los primeros índices de
# la matriz, no a las columnas ni las filas.
y
#     [,1] [,2] [,3] [,4] [,5]
#[1,]    1    5    9   13   17
#[2,]    2    6   10   14   18
#[3,]    3    7   11   15   19
#[4,]    4    8   12   16   20
#attr(,"names")
# [1] "a" "b" "c" "d" "e" NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA 
 
# Para asignar nombres a las filas de una matriz, vamos a utilizar la función
# "rownames"
rownames(y) <- c("fila1", "fila2", "fila3", "fila4")
 
# En forma similar, para nombrar las columnas vamos a usar "colnames"
colnames(y) <- c("col_A", "col_B", "col_C", "col_D", "col_E")

# La matriz resultante tiene entonces nombres en filas y columnas, además de los
# nombres de los índices que le asignamos anteriormente con la función "names"
y
#      col_A col_B col_C col_D col_E
# fila1     1     5     9    13    17
# fila2     2     6    10    14    18
# fila3     3     7    11    15    19
# fila4     4     8    12    16    20
# attr(,"names")
# [1] "a" "b" "c" "d" "e" NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA  NA 

# Estas funciones tienen la doble función de asignación y consulta de los
# nombres correspondientes
names(y)
rownames(y)
colnames(y)
 
## Nombres en listas y data.frames
 
# Las listas son, como habíamos visto anteriormente, una clase de objeto, algo
# así como vectores de vectores. Veamos, como ejemplo, la salida de vectores y
# valores propios de una matriz cuadrada, las primeras 4 columnas de nuestra
# matriz "y":
propios <- eigen(y[,1:4])
propios # Este objeto es una lista con dos elementos.
class(propios$values)
# El primer elemento de la lista, llamado "values", es un vector numérico, con
# los valores propios de la matriz indicada.
class(propios$vectors)
# El segundo elemento es una matriz donde cada columna es uno de los vectores
# propios correspondientes.
 
# Mediante el uso de "names" tengo varias opciones:
names(propios$values) <- 1:4
# Puedo nombrar los elementos del vector de valores propios, en este caso nume-
# rándolos. Debe recordarse: mediante la especificación del nombre o índice
# pasamos a trabajar dentro del elemento de la lista correspondiente.
names(propios$values) # La función de consulta se sigue aplicando...
 
names(propios) <- c("valores","vectores")
# También puedo nombrar los elementos de la lista
names(propios) # Consulta, etc...
 
colnames(propios$vectores) <- c("vector_1","vector_2","vector_3","vector_4")
# Y se pueden, bajo la misma lógica, nombrar las columnas de "vectores", etc.
# Veamos cómo quedó "propios" luego de asignarle estos nombres:
propios

# En los data.frames, al ser un tipo particular de lista, se aplican las mismas
# reglas:
z <- as.data.frame(y)
# Llamemos "z" a un data.frame construido a partir de la matriz "y"
 
# Recordemos: un data.frame es un objeto en el que cada columna es un vector de
# observaciones de una determinada variable. Los data.frames son un tipo parti-
# cular de listas, que además tienen algunas propiedades de las matrices. La
# primera son sus dimensiones, debido a lo cual podemos renombrar filas y
# columnas como si fueran matrices.
rownames(z) <- c("obs_1","obs_2","obs_3","obs_4")
colnames(z) <- c("var_A","var_B","var_C","var_D","var_E")
z # a ver cómo quedó.
rownames(z) # y su consulta
colnames(z)
 
# Un paréntesis: se puede también cambiar el nombre a uno o algunos de estos
# elementos por separado, no es necesario definir todo el vector de nombres
# cada vez. Ej:
rownames(z)[2] <- "OBS_25"
# Esto se aplica a las funciones "names" y "colnames" también
 
# Recordando además que un data.frame es una lista (i.e. un vector de vectores),
# podemos definir sus elementos (las variables, en las columnas) usando "names":
names(z) <- c("VAR_1","VAR_2","VAR_3","VAR_4","VAR_5")
# O incluso de a una, o algunas:
names(z)[3:5] <- c("Humedad","Temperatura","Salinidad")
# Y también se consulta...
names(z)
# Veamos el resultado final
z
 
# Resumen:
# Existe una gran flexibilidad para identificar y manipular los nombres de los
# elementos que componen un objeto. El uso de nombres muchas veces es deseable,
# ya que la numeración requiere de una gran memoria y no siempre se mantiene
# constante (por ejemplo, si elimininamos/agregamos elementos al objeto). Otras
# veces es estrictamente necesario, como probablemente vamos a ver más adelante
# en el curso.
