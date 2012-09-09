## Matrices extra

# Mostramos aquí algunos detalles extra respecto al trabajo con matrices.

# La matriz es en muchos sentidos igual a un vector, pero en 2 dimensiones. 
# Por esto es común transformar vectores en matrices y viceversa, además de 
# aplicar muchos métodos de forma similar (i.e., operaciones matemáticas 
# básicas, sumatorias, promedios, etc.). Por ejemplo, se pueden utilizar los 
# índices sin dos valores... es decir, en lugar de escribir m[i, j] se puede 
# escribir m[i], en cuyo caso toma el iésimo valor de la matriz empezando por 
# m[1, 1] y recorriendo la matriz por sus columnas. Veamos un ejemplo para 
# aclarar:
set.seed(0)
m <- matrix(sample(12), 4)

# Aquí el m[2, 1] es equivalente al m[2]; m[3, 1] equivale al m[3]; m[1, 2] es 
# el m[5] y así sucesivamente...

# El segundo valor de la primer columna:
m[2, 1]
m[2]

# La primer columna:
m[, 1]
m[1:4]

# El primer valor de la segunda columna:
m[1, 2]
m[5]

# Esta forma de utilizar los índices es un arma de doble filo: si nos falta
# una coma en el código el R no nos va a mostrar un mensaje de error, sin
# embargo podemos estar cometiendo errores importantes para nuestros propósitos.

# Nótese además que este criterio es coherente con la forma en que 
# "rellenábamos" matrices al crearlas con la función matrix.

# A propósito, un método parecido de crear matrices es tomando un vector y 
# modificar su atributo de dimensiones, de la siguiente manera:
x <- 1:20         # Crea un vector con una secuencia de 1 a 20
dim(x) <- c(4, 5) # Al vector creado le adjudicamos dimensiones: número de 
                  # filas y columnas.
x


## Operaciones con vectores

# Cuando se multiplican vectores por matrices, utilizando el operador normal 
# *, hay que tener precauciones respecto los tamaños de los objetos, ya que si 
# no corremos el iesgo de caer en errores. En todo caso, lo que R hace es 
# simplemente considerar a la matriz como un vector y hacer la operación 
# elemento por elemento (yendo por las columnas), reciclando los valores del 
# vector original para parear todos los elementos de la matriz:
x <- matrix(1:20, 4, 5)
x * c(-1, 0, 1, 0, -1)
x + c(-100, 0)
# En general no es recomendable recurrir a este tipo de operaciones a menos
# que sea absolutamente necesario.


## Diagonal de una matriz

# La función diag sirve para obtener o modificar la diagonal de una matriz, 
# definida como todos los valores m[i, i] de la misma. Veamos con un ejemplo:
(m <- matrix(1:25, 5))
diag(m)
diag(m) <- 0 # Ahora los valores en la diagonal de 'y' son todos 0.
m

# Aquí primero llamamos a diag(m) para ver los valores de la diagonal en forma 
# de un vector. Luego sustituimos estos valores por 0 (aunque podríamos 
# hacerlo con 5 valores diferentes si quisieramos). Nótese que aquí se usa la 
# asignación "al revés de lo normal". Esto no es raro en R y vamos a ver 
# varios casos así.


## Arreglos

# La matriz puede pensarse como un caso particular de arreglo o "array", 
# limitado a 2 dimensiones (filas & columnas). Los arreglos en R son objetos
# con n dimensiones; por ejemplo, un arreglo de 3 dimensiones puede ser:
(x <- array(1:12, c(2, 2, 3)))
# Nótese que los valores van "llenando" el arreglo siguiendo el órden de las
# dimensiones del mismo, al igual que ocurría con las matrices...
 
# El número de dimensiones determina la forma en que se usan los índices, 
# entonces si son 3 dimensiones, hay que utilizar 3 índices:
x[2, 1, 3]
# [1] 10

## FIN
