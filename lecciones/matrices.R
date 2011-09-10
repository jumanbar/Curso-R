#### Matrices
 
## Habiendo visto vectores, que son arreglos de objetos en una dimensión, en esta sección
## veremos un tipo de vectores, las matrices, que son arreglos en dos dimensiones.
## Como tales, estos vectores tienen una altura (cantidad de filas) y un ancho (cantidad de columnas)(en ese orden).
 
## La manera más elemental de crear una matriz, es utilizando la función matrix
a <- matrix(0, nrow = 3, ncol = 3) # El primer argumento es el o los valores con los que "llenaremos" la matriz.
# El segundo y tercer argumentos de la función son respectivamente la cantidad de filas y columnas que tendrá.
a # Si invocamos a la matriz creada, R nos devuelve lo siguiente
#     [,1] [,2] [,3]
#[1,]    0    0    0
#[2,]    0    0    0
#[3,]    0    0    0
 
a <- matrix(0, 3, 3) # Un detalle: si mantenemos el orden de los argumentos, no es necesario especificar cuál es cada uno.
 
a <- matrix(1:9, nrow=3) # En este caso, llenaremos la matriz con una secuencia de 1 a 9.
## Al no especificar un número de columnas, se van a completar las que sean necesarias hasta terminar la secuencia
 
a # Devuelve:
#     [,1] [,2] [,3]
#[1,]    1    4    7
#[2,]    2    5    8
#[3,]    3    6    9
 
a <- matrix(1:9, nrow=3, byrow=TRUE) # El argumento "byrow" (del tipo "lógico") sirve para especificar si la matriz debe llenarse
# por filas. Por defecto su valor es FALSE, llenándose por columnas, como en el caso anterior. En este caso especificamos que lo haga por filas.
a
#     [,1] [,2] [,3]
#[1,]    1    2    3
#[2,]    4    5    6
#[3,]    7    8    9
## Nota: los dos valores lógicos posibles son TRUE y FALSE. Si un argumento es del tipo "logic", entonces hay que usar uno de los dos. 
## Es posible también usar T y F en lugar de las palabras completas, pero hay que tener precaución, ya que si tenemos un objeto con alguno de estos nombres va a causar un conflicto.
 
## La matriz es un vector, pero arreglado en 2 dimensiones. Sabiendo esto podemos tomar un vector y convertirlo en matriz.
x <- 1:20 # Creamos un vector con una secuencia de 1 a 20
dim(x) <- c(4, 5) # Al vector creado le adjudicamos dimensiones (alto y ancho) correspondientes a una matriz.
x # Al llamar a x:
#     [,1] [,2] [,3] [,4] [,5]
#[1,]    1    5    9   13   17
#[2,]    2    6   10   14   18
#[3,]    3    7   11   15   19
#[4,]    4    8   12   16   20
 
dim(x) # la función "dim" también sirve para obtener información sobre las dimensiones de la matriz x
#[1] 4 5 
 
 
#### Índices de las matrices
## Al tener dos dimensiones, tenemos que dar 2 índices, primero filas, luego columnas. Las reglas son las mismas que en los vectores.
 
x[2,3]
#[1] 10
 
x[2:4,3:5]
#     [,1] [,2] [,3]
#[1,]   10   14   18
#[2,]   11   15   19
#[3,]   12   16   20
 
## También se pueden hacer asignaciones usando el esquema:
x[2, 2:4] <- -1
x
#     [,1] [,2] [,3] [,4] [,5]
#[1,]    1    5    9   13   17
#[2,]    2   -1   -1   -1   18
#[3,]    3    7   11   15   19
#[4,]    4    8   12   16   20
 
x[2, 2:4] <- c(-10, -20, -30)
x
#     [,1] [,2] [,3] [,4] [,5]
#[1,]    1    5    9   13   17
#[2,]    2  -10  -20  -30   18
#[3,]    3    7   11   15   19
#[4,]    4    8   12   16   20
 
## Si dejo un lugar vacío, por defecto toma todos los valores posibles, devolviendo las filas o columnas correspondientes.
x[1,]
x[,1]
x[,]
 
## Para transponer una matriz utilizaremos la función "t"
t(x)
 
## Para hacer el producto matricial (multiplicar matriz por matriz, en vez de elemento por elemento) no se usa *, hay que usar un operador especial %*%:
x <- matrix(1:25, 5, 5)
x * x
x %*% x
 
## Los valores y vectores propios se pueden obtener con eigen()
y <- eigen(x) # La salida es un objeto de clase "lista", con dos elementos: $values (valores propios) y $vectors (vectores propios.)
y$values      # Usando el operador $ se accede a dichos elementos (más de esto en la sección "Listas y data.frame")
y$vectors
 
mean(x) # Promedio de toda la matriz
sum(x)  # Sumatoria de la matriz
sd(x) # El desvío estándar de la misma
## El resultado de sd(x) no se basa en toda la matriz: calcula por columnas.
## Este comportamiento muestra cómo la clase a la que pertenece el objeto "x" (en este caso "matrix") afecta el resultado de las operaciones.
## A lo largo del curso vamos a ver varios ejemplos que muestran cómo funciona esto.
 
## Hay algunas funciones hechas para trabajar con matrices (o data.frames) específicamente:
colMeans(x) # Promedios de las columnas
rowMeans(x) # y de las filas
colSums(x)  # Sumatoria de las columnas
rowSums(x)  # y de las filas
 
## Con cbind y rbind podemos unir vectores como columnas o filas de una matriz respectivamente, a condición que tengan la misma longitud.
x <- 0:5
y <- 10:15
z <- cbind(x, y)
z
#     x  y
#[1,] 0 10
#[2,] 1 11
#[3,] 2 12
#[4,] 3 13
#[5,] 4 14
#[6,] 5 15
 
u <- rbind(x, y)
u
#  [,1] [,2] [,3] [,4] [,5] [,6]
#x    0    1    2    3    4    5
#y   10   11   12   13   14   15
 
## También se puede utilizar para unir matrices con matrices, vectores con matrices...
x <- matrix(1:30, 6, 5)
y <- cbind(x, 31:36)
z <- rbind(y, y)
