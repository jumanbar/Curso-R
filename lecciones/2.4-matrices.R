## Matrices

# Habiendo visto vectores, que son arreglos de objetos en una dimensión, en
# esta sección veremos un tipo de objeto, las matrices, que son arreglos en dos
# dimensiones. Como tales, estos objetos tienen una altura (cantidad de filas) y
# un ancho (cantidad de columnas)(y en general siempre se listan en ese orden).

# Una manera bastante elemental de crear una matriz, es utilizando la función
# matrix, como en el siguiente ejemplo:
m <- matrix(0, nrow = 3, ncol = 3)

# El primer argumento es el o los valores con los que "llenaremos" la matriz.
# El segundo y tercer argumentos de la función son respectivamente la cantidad
# de filas y columnas que tendrá. En este caso es una matriz cuadrada de
# ceros, la cual se muestra en R con este formato, del cual vamos a comentar
# más adelante:
m
#      [,1] [,2] [,3]
# [1,]    0    0    0
# [2,]    0    0    0
# [3,]    0    0    0

# En este caso el "relleno" de la matriz es un número único, pero a veces
# podemos usar vectores, es decir una cantidad de n elementos que van a ocupar
# las posiciones de la matriz. Por ejemplo:
m <- matrix(1:9, nrow = 3)
# En este caso, llenaremos la matriz con una secuencia de 1 a 9 (el número de
# columnas lo "deduce" R a partir del número total de elementos y de filas).
# No es trivial considerar el órden en que se van llenando las posiciones de
# la música. Por defecto este orden es por columnas; se empieza por la primer
# columna y se sigue por la segunda y así sucesivamente.
m
#      [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9

# Si se desea se puede cambiar esta forma de rellenado con el argumento byrow,
# de la forma en que sigue:
m <- matrix(1:9, nrow = 3, byrow = TRUE)

# El argumento "byrow" (del tipo "lógico") sirve para especificar si la matriz
# debe llenarse por filas. Por defecto su valor es FALSE, llenándose por
# columnas, como en el caso anterior.
m
#      [,1] [,2] [,3]
# [1,]    1    2    3
# [2,]    4    5    6
# [3,]    7    8    9

# Otra forma común de crear o modificar matrices es utilizando las funciones
# rbind y cbind. Estas funciones sirven para "pegar" vectores o matrices. Con
# cbind se "pegan columnas", como en el siguiente ejemplo:
u <- 1:5
v <- 6:10
cbind(u, v)

# Este es el caso mínimo, ya que se pueden pegar n vectores del mismo largo
# usando la misma sintaxis. En cambio la función rbind sirve para "pegar filas":
rbind(u, v)

# En caso de que u y v sean matrices también pueden usarse estas funciones,
# pero hay que tener en cuenta el tamaño de las mismas. Es decir, si usamos
# cbind para pegar dos (o más) matrices, entonces estas tienen que tener la
# misma cantidad de filas. A la inversa rbind funciona cuando las matrices
# tienen la misma cantidad de columnas. Veamos un ejemplo de cada caso:
m0 <- matrix(0, 3, 3)
m1 <- matrix(1, 3, 3)
cbind(m0, m1)
rbind(m0, m1)


## Índices de las matrices

# Al tener dos dimensiones, tenemos que dar 2 índices, primero filas, luego
# columnas. Las reglas son las mismas que en los vectores, veamos ejemplos:
x <- matrix(1:20, 4, 5) # Creamos una matriz...

# Para obtener el elemento de x ubicado en la fila 2 y columna 3:
x[2, 3] # [1] 10

# Ahora, para tomar varios elementos de x, abarcando varias filas y columnas:
x[2:4, 3:5]
#      [,1] [,2] [,3]
# [1,]   10   14   18
# [2,]   11   15   19
# [3,]   12   16   20

# Al igual que con vectores, la flecha de asignación sirve para modificar
# valores de las matrices:
x[2, 2:4] <- -1 # Los elementos de la fila 2 y las columnas 2, 3 y 4 ahora
                # tienen valor -1
x
#      [,1] [,2] [,3] [,4] [,5]
# [1,]    1    5    9   13   17
# [2,]    2   -1   -1   -1   18
# [3,]    3    7   11   15   19
# [4,]    4    8   12   16   20

# En definitiva, se siguen los mismos criterios que ya vimos para vectores,
# con la diferencia de que hay que tener en cuenta las dos dimensiones (filas
# y columnas).

# Al dejar un lugar vacío, por defecto toma todos los valores posibles de
# filas o columnas según el caso. Por ejemplo, para ver la fila 1 completa, se
# debe dejar vacío el lugar de las columnas:
x[1,]    # La fila 1

# En cambio si se quiere ver una columna completa, se deja vacío el primer
# lugar, por ejemplo:
x[, 3:4] # Devuelve las columnas 3 y 4

# Nótese que este uso de los índices es el que se usa al momento de imprimir
# la matriz en la consola.


## Álgebra lineal

# Muchas veces es necesario saber las dimensiones (cantidad de filas y
# columnas) de las matrices. Para esto se pueden usar las funciones dim, nrow
# y ncol:
dim(x)
nrow(x)
ncol(x)

# Las operaciones más simples (suma, resta, mutiplicación) se realizan con los
# mismos criterios que con vectores. Esto diferencia a R de otros programas en
# los que la multiplicación de matrices implica realizar el producto
# matricial. Algunos ejemplos son:
x * 2
x + 1
x + x
exp(x)

# Para ejecutar el producto matricial no se usa el operador normal *, hay que
# usar un operador especial, %*%. De otra forma, en vez de hacer esta operación
# R simplemente realiza una multiplicación "elemento por elemento", como ocurre
# para los vectores. Por ejemplo:
x <- matrix(1:25, 5, 5)
# Veamos una comparación de resultados:
x * x
x %*% x

# La matriz transpuesta (intercambiar los x[i, j] por x[j, i]) se puede
# obtener con la función t:
t(x)

# Los valores y vectores propios de una matriz cuadrada se pueden obtener con
# "eigen":
x <- matrix(1:9, 3, 3)
y <- eigen(x)
# La salida es un objeto de clase "lista", con dos elementos: $values (valores
# propios) y $vectors (vectores propios).
y
y$values  # Que pueden ser llamados de a uno.
y$vectors
# Usando el operador $ se accede a dichos elementos (más de esto en la lección
# "Listas y data.frames").

# R cuenta también con una función nativa para calcular determinantes de
# matrices cuadradas, llamada "det" o "determinant":
det(x) # o
determinant(x)

# Hay algunas funciones hechas para trabajar con matrices (o data.frames)
# específicamente:
colMeans(x) # Promedios de las columnas
rowMeans(x) # y de las filas
colSums(x)  # Sumatoria de las columnas
rowSums(x)  # y de las filas

# Para buscar más utilidades para trabajar con matrices, se puede buscar en el
# paquete "base" de R (o en otros también), usando el comando:
help.search("matrix", package="base")


## Resumen:

# Las matrices son estructuras para guardar información que siguen a los
# vectores en complejidad al tener 2 dimensiones. Comparten muchas cosas con
# los vectores: todos los elementos deben ser del mismo tipo, las operaciones
# trabajan de manera similar, etc. Sin embargo no siempre son la clase de
# objeto ideal para trabajar con datos, especialmente si tenemos tablas de
# datos con información de tipos dispares, tales como nombres o números. Para
# esto existen los objetos "data.frame" y las listas, los que vamos a cubrir
# en la siguiente lección.
