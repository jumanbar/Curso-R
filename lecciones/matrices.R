#### Matrices
 
# Habiendo visto vectores, que son arreglos de objetos en una dimensión, en
# esta sección veremos un tipo de objeto, las matrices, que son arreglos en dos
# dimensiones. Como tales, estos objetos tienen una altura (cantidad de filas) y
# un ancho (cantidad de columnas)(en ese orden).

# La manera más elemental de crear una matriz, es utilizando la función matrix
a <- matrix(0, nrow = 3, ncol = 3)
# El primer argumento es el o los valores con los que "llenaremos" la matriz.
# El segundo y tercer argumentos de la función son respectivamente la cantidad
# de filas y columnas que tendrá.
a # Si invocamos a la matriz creada, R nos devuelve lo siguiente
#      [,1] [,2] [,3]
# [1,]    0    0    0
# [2,]    0    0    0
# [3,]    0    0    0

a <- matrix(0, 3, 3)
# Un detalle: si mantenemos el orden de los argumentos, no es necesario
# especificar cuál es cada uno.
 
a <- matrix(1:9, nrow=3)
# En este caso, llenaremos la matriz con una secuencia de 1 a 9.
# Al no especificar un número de columnas, se van a completar las que sean
# necesarias hasta terminar la secuencia.
 
a # Devuelve:
#      [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9
 
a <- matrix(1:9, nrow=3, byrow=TRUE)
# El argumento "byrow" (del tipo "lógico") sirve para especificar si la matriz
# debe llenarse por filas. Por defecto su valor es FALSE, llenándose por
# columnas, como en el caso anterior. En este caso especificamos que lo haga por
# filas.
a
#      [,1] [,2] [,3]
# [1,]    1    2    3
# [2,]    4    5    6
# [3,]    7    8    9
# Nota: los dos valores lógicos posibles son TRUE y FALSE. Si un argumento es
# del tipo "logic", entonces hay que usar uno de los dos.
# Es posible también usar T y F en lugar de las palabras completas, pero hay que
# tener precaución, ya que si tenemos un objeto con alguno de estos nombres va
# a causar un conflicto.

# La matriz es en muchos sentidos igual a un vector, pero en 2 dimensiones.
# Sabiendo esto podemos tomar un vector y convertirlo en matriz.
x <- 1:20         # Creamos un vector con una secuencia de 1 a 20
dim(x) <- c(4, 5) # Al vector creado le adjudicamos dimensiones (alto y ancho).
x # Al llamar a x:
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    1    5    9   13   17
# [2,]    2    6   10   14   18
# [3,]    3    7   11   15   19
# [4,]    4    8   12   16   20

# la función "dim" también sirve para obtener información sobre las dimensiones
# de la matriz x:
dim(x)
# [1] 4 5 

# Nota: a lo largo del curso van a notar que existen varias funciones que
# pueden trabajar generando una salida o recibiendo la salida de una expresión,
# como acabamos de mostrar con la función dim. Otro ejemplo es la función diag:
y <- matrix(1:25, 5)
diag(y)
(diag(y) <- 0)

## Operaciones con matrices
# Las matrices funcionan de la misma forma que un vector. Cuando se hace una
# operación matemática con una matriz el resultado es generalmente otra matriz
# de las mismas dimensiones. Por ejemplo, sumar, restar, multiplicar o dividir
# una matriz numérica por un número simplemente aplica la operación a todos
# los elementos:
x * 2
x + 1
exp(x)

# Cuando las operaciones son de matrices con vectores, corremos el riesgo de
# caer en errores causados por números de elementos incorrectos para las
# dimensiones de la matriz. En todo caso, lo que R hace es simplemente
# considerar a la matriz como un vector y hacer la operación elemento por
# elemento, reciclando los valores del vector original para parear todos los
# elementos de la matriz:
x * c(-1, 0, 1, 0, -1)
x + c(-100, 0)
# En general no es recomendable recurrir a este tipo de operaciones a menos
# que sea absolutamente necesario.

# Finalmente, si las operaciones son entre matrices, entonces se realizan
# elemento por elemento, de manera similar a las operaciones vector con vector.
# Ejemplos:
x + x   # = x * 2
x - x/3 # = x * 2 / 3

# Para el caso particular del producto matricial (multiplicar matriz por matriz,
#  en vez de elemento por elemento) no se usa *, hay que usar un operador
# especial %*%:
x <- matrix(1:25, 5, 5)
x * x
x %*% x


## Índices de las matrices
# Al tener dos dimensiones, tenemos que dar 2 índices, primero filas, luego
# columnas. Las reglas son las mismas que en los vectores, veamos ejemplos:

# Para obtener el elemento de x ubicado en la fila 2 y columna 3:
x[2, 3]
# [1] 10

# Ahora, para tomar varios elementos de x, abarcando varias filas y columnas:
x[2:4, 3:5]
#      [,1] [,2] [,3]
# [1,]   10   14   18
# [2,]   11   15   19
# [3,]   12   16   20
 
# También se pueden hacer asignaciones usando el esquema:
x[2, 2:4] <- -1
x
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    1    5    9   13   17
# [2,]    2   -1   -1   -1   18
# [3,]    3    7   11   15   19
# [4,]    4    8   12   16   20

# Debe tenerse en cuenta que el sustituto debe tener la cantidad correcta de
# elementos:
(x[2, 2:4] <- c(-10, -20, -30)) # OK
(x[2, 2:4] <- c(-10, -20))      # No OK

# Si dejo un lugar vacío, por defecto toma todos los valores posibles,
# devolviendo las filas o columnas correspondientes:
x[1,]
x[3:4,]
x[,1]
x[, 3:4]
x[,]

# Es posible también usar índices unidimensionales con las matrices (es
# decir, un sólo número/vector en lugar de dos:
set.seed(0)
x <- matrix(sample(12), 4)
x[5]    # El quinto elemento contando por columnas, 8 en este caso
x[4:7]  # Los elementos 4 al 7 de x, contando por columnas también...
# [1] 6 8 2 9
x[1:12] # Los elementos de la matriz, pero en un vector
# El hecho de poder usar estos formatos es un arma de doble filo: si nos falta
# una coma en el código el R no nos va a mostrar un mensaje de error, sin
# embargo podemos estar cometiendo errores importantes para nuestros propósitos.

# Para transponer una matriz utilizaremos la función "t" (intercambia los
# x[i, j] por x[j, i]):
t(x)

# Los valores y vectores propios de una matriz cuadrada se pueden obtener con
# "eigen":
y <- eigen(x)
# La salida es un objeto de clase "lista", con dos elementos: $values (valores
# propios) y $vectors (vectores propios).
y$values
y$vectors
# Usando el operador $ se accede a dichos elementos (más de esto en la sección
# "Listas y data.frame")

mean(x) # Promedio de toda la matriz
sum(x)  # Sumatoria de la matriz
sd(x)   # El desvío estándar de la misma
# El resultado de sd(x) no se basa en toda la matriz: calcula por columnas.
# Este comportamiento muestra cómo la clase a la que pertenece el objeto "x" (en
# este caso "matrix") afecta el resultado de las operaciones.
# A lo largo del curso vamos a ver varios ejemplos que muestran cómo funciona
# esto.
 
# Hay algunas funciones hechas para trabajar con matrices (o data.frames)
# específicamente:
colMeans(x) # Promedios de las columnas
rowMeans(x) # y de las filas
colSums(x)  # Sumatoria de las columnas
rowSums(x)  # y de las filas

# Para buscar más utilidades para trabajar con matrices, se puede buscar en el
# paquete "base" de R (o en otros también), usando el comando:
help.search("matrix", package="base")

# Con cbind y rbind podemos unir vectores como columnas o filas de una matriz
# respectivamente, a condición que tengan la misma longitud.
x <- 0:5
y <- 10:15
z <- cbind(x, y)
z
#      x  y
# [1,] 0 10
# [2,] 1 11
# [3,] 2 12
# [4,] 3 13
# [5,] 4 14
# [6,] 5 15
 
u <- rbind(x, y)
u
#  [,1] [,2] [,3] [,4] [,5] [,6]
#x    0    1    2    3    4    5
#y   10   11   12   13   14   15
 
# También se puede utilizar para unir matrices con matrices o vectores con
# matrices, siempre y cuando los tamaños de los objetos involucrados sean los
# adecuados:
x <- matrix(1:30, 6, 5)
y <- cbind(x, 31:36)
z <- rbind(y, y)
w <- cbind(z, y) # Error!

# Por último hacemos una muy pequeña mención a la función "array", la cual
# sirve para crar arreglos de una cantidad de dimensiones arbitraria. Por
# ejemplo, un arreglo de 3 dimensiones puede ser:
(x <- array(1:12, c(2, 2, 3)))
# Nótese que los valrores van "llenando" el arreglo siguiendo el órden de las
# dimensiones del mismo.

# El número de dimensiones determina la forma en que se usan los índices, de
# la misma forma que ocurre con las matrices.
x[2, 1, 3]
# [1] 10

# Resumen:
# Las matrices son estructuras para guardar información que siguen a los
# vectores en complejidad al tener 2 dimensiones. Comparten muchas cosas con
# los vectores: todos los elementos deben ser del mismo tipo, las operaciones
# trabajan de manera similar, etc. Sin embargo no siempre son la clase de
# objeto ideal para trabajar con datos, especialmente si tenemos tablas de
# datos con información de tipos dispares, tales como nombres o números. Para
# esto existen los objetos "data.frame" y las listas, los que vamos a cubrir
# en la siguiente lección.
