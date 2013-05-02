## Listas y data.frames
 
# Hasta ahora hemos visto vectores y matrices como las estructuras más sencillas
# para organizar la información dentro de R. Una restricción importante es que
# dichos objetos requieren que todos los elementos que los componen deben ser
# de la misma clase/tipo. En R la clase 'list' (o lista para nosotros) tiene
# una estructura que supera esta limitación. Por otro lado, la clase denominada
# 'data.frame' es un tipo particular de lista, pensada para trabajar con tablas
# de datos, de forma que son muy similares a las matrices, aunque con diferen-
# cias que merecen ser recordadas.


## Listas

# Una lista puede pensarse como un vector que contiene varios objetos, donde 
# cada objeto puede ser de un tipo/clase diferente. Además los componentes de la
# lista no tienen por qué tener la misma cantidad de elementos. Con la función 
# list podemos crear una lista de cero; por ejemplo:
x <- list(rep('pepe', 3), 1:20)
# En este caso, x contiene a un vector "character" y otro "numeric"; el primero 
# tiene 3 elementos, mientas que el segundo tiene 20:
x

# Para acceder al contenido de cada elemento de una lista se utilizan los 
# índices entre corchetes dobles. Así, vamos a explorar qué tiene nuestra lista
# 'x' en su primer elemento:
x[[1]]
# [1] "pepe" "pepe" "pepe"
class(x[[1]])  # "character"
length(x[[1]]) # 3

# y en el segundo: 
x[[2]]
# [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
class(x[[2]])  # "integer"
length(x[[2]]) # 20

# Nótese que para llamar a varios elementos dentro de una lista hay que usar 
# corchetes simples, como en el siguiente ejemplo:
x[1:2]
# En este caso tiene poca gracia hacerlo, pero si se tratara de listas más 
# grandes puede ser de utilidad este conocimiento.

# Esta misma información la podemos obtener usando la función str, aunque
# presentada en una forma diferente (más compacta):
str(x)

# La función str trata de dar la información resumida, de forma que no imprime
# una cantidad excesiva de información en la consola.

# Debido a que las listas tienen una estructura sumamente flexible, pueden 
# crearse objetos de esta clase con una complejidad arbitraria, unificando 
# diversos tipos de información. No es raro encontrar listas adentro de otras 
# listas, formando árboles de objetos. En este aspecto las listas no son 
# demasiado diferentes a un sistema de archivos de un disco duro.

# Un caso ejemplar de lista con enorme cantidad de información es el objeto 
# que devuelve la función lm, la cual sirve para hacer regresiones lineales. 
# Estos objetos (de clase "lm", pero con propiedades de listas) contienen los 
# datos originales, la fórmula de la regresión, los residuos, coeficientes 
# obtenidos y mucho más. Veremos más sobre esto en las próximas unidades. 

# Volamos entonces a las listas y a los distintos métodos para crearlas. Ya 
# vimos la función "list", ahora veamos la función "vector", con la que 
# podemos crear una lista vacía y luego modificarla, de la siguiente manera:
x <- vector('list', 2) # Lista vacía, con 2 elementos.
x # Los dos elementos de 'x' están vacíos, son nulos.
x[[1]] <- rep('pepe', 3)
x[[2]] <- 1:20
x # Ahora tenemos la misma lista que habíamos creado anteriormente.


## Listas nombradas

# Hasta ahora los ejemplos creados en esta sesión han sido de listas sumamente 
# simples y carentes de nombres. Pero para facilitar la interacción con el 
# usuario, las listas pueden tener nombres para sus objetos. En el caso de x 
# aún no hemos puesto nombres, lo cual lo podemos corroborar con la función 
# names:
names(x)

# Es fácil asignar nombres antes y después de crear una lista. En el primer 
# caso, al usar la función list podemos cambiar ligeramente la sintaxis para 
# asignarle los nombres 'jose' y 'carlos' a los elementos de x, de la 
# siguiente manera:
(x <- list(jose = rep('pepe', 3), carlos = 1:20))

# Con el segundo método podemos hacer los siguientes pasos para darle nombres 
# a la lista, empezando por un objeto nulo:
x <- NULL
# Lo siguiente es simplemente agregar los nuevos objetos usando el operador $:
x$jose <- rep('pepe', 3)
x$carlos <- 1:20

# Ahora que los elementos de x están nombrados, podemos usar el operador $ 
# para referirnos a ellos usando dichos nombres. Veamos:
x$jose
x$carlos

# Nótese que estos dos componentes de la lista son objetos en sí mismos y se 
# pueden usar como tal (en este caso, como vectores) en cualquier comando de 
# R. Por ejemplo, si queremos el 7mo. elemento de x$carlos, podemos usar:
x$carlos[7]

# Por último, si queremos modificar estos nombres, la función names nos sirve 
# de vuelta. Si queremos cambiar sólo uno, el primero por ejemplo, usamos los
# corchetes:
names(x)[1] <- 'jorge'

# O podemos cambiar los dos al mismo tiempo:
names(x) <- c('nicolas', 'ezequiel')

# Como dijimos, las listas son útiles para agrupar varios tipos de datos en un
# sólo objeto, ya que es una clase de objeto no tan restrictiva como las matri-
# ces o los vectores normales. Por lo tanto, muchas funciones con salidas 
# complejas utilizan estas estructuras para organizar la información (como 
# eigen o lm).


## La clase data.frame

# La clase "data.frame" es un tipo particular de lista, en la que todos los 
# objetos tienen la misma cantidad de elementos, pero mantienen la libertad de 
# pertenecer a distintas clases. Es básicamente una tabla de datos, en donde 
# las filas son casos y las columnas variables. De hecho, vamos a llamar 
# "columnas" o "variables" indistintamente para referirnos a las columnas de un
# data.frame.

## ¿Cómo crear data.frame?

# Para crear data.frames de cero la función data.frame es una opción de uso 
# frecuente, la cual funciona de forma muy similar a list. Veamos un ejemplo:
d <- data.frame(enteros=1:10, decimales=seq(.1, 1, by=.1))
# El resultado es una tabla con dos columnas llamadas "enteros" y "decimales". 
# Nótese que estos son dos vectores de clases diferentes:
head(d) # La función head devuelve los primeros elementos; ver también ?tail
class(d)
class(d$enteros)
class(d$decimales)

# Nótese también que el uso del operador $ es idéntico al caso de las 
# listas. Una característica de las data.frame que las diferencia de las 
# matrices es que necesariamente deben tener las columnas nombradas. Nótese 
# que tanto en matrices como en data.frames las columnas se pueden nombrar 
# usando colnames (equivalente a names si se trata de un data.frame) y que las 
# filas también se pueden nombrar, usando rownames.

# Las funciones genéricas str y summary son opciones muy útiles para ver la 
# data.frame de forma resumida:
str(d)
summary(d)

# Adicionalmente, es bastante común transformar matrices (objetos de la clase 
# "matrix") en data.frames, utilizando el coercionador as.data.frame de la 
# siguiente manera:
m <- matrix(1:25, 5, 5)
as.data.frame(m)

# Otros objetos pueden convertirse en data.frame también con esta función. Se 
# mencionará más sobre este tipo de funciones en la lección relacionada.

# De todas maneras, tal vez la forma más común de incorporar una data.frame a 
# una sesión de R es importando una tabla de datos, ya que al hacerlo 
# (usualmente con las funciones read.table o read.csv) R devuelve objetos de 
# esta clase.

# Para mostrar los ejemplos de esta lección nos basaremos en algunas tablas de 
# datos que ya vienen incluidas en el R básico (específicamente en el paquete 
# 'datasets'). Las data.frames "cars" e "iris" son las que usaremos aquí 
# particularmente.

summary(cars)
str(iris)


## Índices y data.frames
 
# En muchos sentidos un data.frame se comporta en forma similar a un objeto de
# clase "matrix". En particular, la forma de usar los índices es 
# prácticamente idéntica: hay que especificar filas y columnas (y en ese orden).
# Por ejemplo:
iris[1,]
iris[2, 5]

# También sirven las funciones cbind y rbind, para pegar nuevos elementos, por 
# columnas o filas respectivamente. Por ejemplo, sabiendo que iris tiene 150 
# filas (lo que se puede averiguar con nrow o dim), puedo agregarle una nueva 
# variable llamada "nuevaCol" con cbind de la manera siguiente:
(x <- cbind(iris, nuevaCol=1:150))
head(x)

# Nótese cómo se nombró la nueva columna en el momento de agregarla.


## Otras observaciones

# El data.frame está pensado especialmente para trabajar con datos y muchos
# métodos gráficos o estadísticos están definidos para trabajar sólamente con
# este tipo de objetos. Vamos a profundizar en estos aspectos más adelante en el
# curso. Por ahora nos vamos a limitar a un par de ejemplos gráficos:
plot(iris)
plot(Petal.Length ~ Petal.Width, data=iris, col=rep(1:3, each=50))
# Nota: este ejemplo se puede hacer con matrices, siempre y cuando tengan
# los nombres correctos asignados a las columnas. Sin embargo el siguiente 
# ejemplo no puede hacerse con una matriz con estas características:
plot(Petal.Length ~ Species, data=iris)
# Se trata de un ploteo de cajas: este no se puede hacer con matrices, ya que
# requiere una variable categórica, "Species", de clase "factor" y por lo 
# tanto debería tener objetos de distintas clases, lo cual, como recordará, no 
# es posible con matrices. 

# Es entonces importante recordar que más allá de similitudes, matrices y 
# data.frames *no* son la misma cosa.

# Resumen:
# Las listas y los data.frames son dos estructuras muy convenientes para
# trabajar con datos. Su complejidad no es significativamente mayor al de las
# matrices y sin embargo tienen diferencias que van a probar ser cruciales para
# facilitar un diálogo fluido en análisis estadísticos y el trabajo con datos.
