### Listas y data.frame
 
## Una lista es un vector que contiene a otros vectores, donde cada vector puede ser de un tipo/clase diferente.
x <- list(rep('pepe', 3), 1:20)
 
## Además los componentes de la lista no tienen porqué tener la misma cantidad de elementos. En este caso, "x" contiene a un vector "character" y otro "numeric"; el primero tiene 3 elementos, mientas que el segundo tiene 20.
x <- list(rep('pepe', 3), 1:20)
x[[1]]
#[1] "pepe" "pepe" "pepe"
x[[2]]
#[1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
class(x[[1]]) # "character"
class(x[[2]]) # "integer"
length(x[[2]]) # 3
length(x[[2]]) # 20
 
## Las listas son útiles para agrupar varios tipos de datos en un sólo objeto, ya que no es tan restrictivo como las matrices o los vectores normales.
 
## Ejemplo: como vimos antes, eigen() devuelve una lista
x  <- matrix(1:25, 5, 5)
vv <- eigen(x)
 
## Los elementos de la lista se obtienen o modifican con doble corchete [[ ]]
vv[[1]]
 
## En el caso de las listas, si los elementos están nombrados, se puede usar el $ para llamarlos
vv$values
 
## Si queremos llamar al primer elemento de 'values', hay que usar el criterio que corresponda para el tipo de objeto que es, por ejemplo:
vv$values    # todos los elementos
vv$values[1] # sólo el primer elemento
vv[[1]][1]   # ídem
 
## Pero con los vectores propios (que están en forma de matriz), hay que considerar que tienen dos dimensiones:
vv$vectors[1,4] # fila 1, columna 4
vv[[2]][1,4]    # ídem
 
#### data.frame
## La clase "data.frame" es un tipo particular de lista. Es básicamente una tabla de datos, con filas como casos y columnas como variables.
 
## "cars" e "iris" son dos tablas de datos que vienen incluídas con los paquetes básicos de R y que ya están en la sesión por defecto:
class(cars)
head(cars) # "head" devuelve las primeras filas de una matriz o data.frame
head(iris)
dim(iris) # Funciona igual que en matrices
mean(iris) # Otra vez, comportamiento diferente
 
## En muchos sentidos es igual a un objeto matrix
iris[1,]
iris[2, 5]
 
## ¿Cómo crear data.frames?
## Una forma de crear un data.frame es transformar algo en este tipo de objeto:
as.data.frame(x) # "as.data.frame" sirve para tratar un objeto de otra clase (vector, matriz) como data.frame
## NOTA: si no adjudicamos nuevamente a x va a seguir siendo lo que era antes.
class(x)
 
x <- as.data.frame(x) # Ahora sustituímos a x por una versión data.frame de x
class(x) # Ahora sí, es un data.frame.
 
## Otra forma de crear un data.frame
dataf <- data.frame(enteros=1:10, decimales=seq(.1, 1, by=.1))
## El resultado, "dataf", es una tabla con dos columnas llamadas "enteros" y "decimales")
head(dataf)
 
## ¿Porque es una lista? Para tener columnas de distinto tipo, cosa que no se puede con los objetos del tipo matrix
 
## En iris se puede ver que la columna "Species" es distinta a las otras
class(iris$Petal.Width) # Al ser del tipo lista, se puede usar el operador $
class(iris$Species)
 
## El data.frame está pensado especialmente para trabajar con datos
plot(iris)
plot(Petal.Length ~ Petal.Width, data=iris)
 
## Debido a que son muy parecidas, uno tiende a usar las mismas funciones para matrix y data.frames,
## pero a veces nos puede dar error por usar la clase equivocada... hay que estar atentos
x <- matrix(1:30, 6, 5)
plot(x) # Esto grafica las dos primeras columnas de x en los ejes x e y del gráfico
plot(as.data.frame(x)) # Al graficar a x como data.frame se grafica cada par de variables, o sea todas contra todas las columnas
