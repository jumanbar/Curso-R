## Clases de objetos

# R trabaja con objetos y es un lenguaje orientado a objetos. Variables,
# tablas, vectores, números, todos son objetos, y cada objeto tiene
# atributos. Muchos objetos, la mayoría de los que vamos a usar, tienen un
# atributo de clase.

# El tipo de clase del objeto es muy importante, ya que determina la forma
# en que va a trabajar dentro de R...

# Algunas de las clases más comunes son:
# "integer", "numeric", "character", "logical", "matrix", "data.frame" y
# "list".


# Algunos ejemplos:
x <- 1:5
class(x) # "integer", es decir, enteros
 
x <- x + 0.1
class(x) # "numeric"... ahora tiene decimales
 
y <- letters[1:5]
y
# [1] "a" "b" "c" "d" "e"
 
class(y) # "character"
 
u <- 5 > 2:8
u
# [1]  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE
class(u) # "logical"
 
# La clase de un objeto afecta cómo las funciones trabajan con el mismo:
mean(x)
# [1] 3
2 * x
# [1]  2  4  6  8 10
 
mean(y)
#[1] NA
# Warning message:
# In mean.defaul(y) : argument is not numeric or logical: returning NA
2 * y
# Error in 2 * y : non-numeric argument to binary operator
# Como y es "character", la función mean no pudo hacer un promedio, ni se
# pudo multiplicar por 2.
 
# Con los objetos lógicos sin embargo sí se pueden hacer operaciones
# matemáticas:
2 * u
# [1] 2 2 2 0 0 0 0
sum(u)
# [1] 3
mean(u)
# [1] 0.4285714
# Cada elemento TRUE es considerado como un 1, mientras que los FALSE
# equivalen a un 0.
 
# La cantidad de clases de objetos es muy grande y crece permanentemente,
# sobre todo al crearse nuevos paquetes de R casi a diario. Muchas
# funciones devuelven objetos de clases únicas que sólo esa función puede
# generar.

# Un ejemplo es la función dist:
xy  <- cbind(rnorm(5), rnorm(5))
out <- dist(xy)
class(out)
# [1] "dist"

# Los atributos y las clases de los objetos son frecuentes causantes de
# errores y confusiones. Existen objetos que tienen atributos de varias
# clases, ya que hay clases que heredan y/o comparten atributos con otras.

# Un caso clarísimo es la clase "data.frame", la cual tiene varias
# facilidades para trabajar con datos que la hacen superior a la clase
# "matrix" para dichas tareas, a pesar de que tienen muchas cosas en común.
# Una consecuencia de esta similitud es que muchas operaciones con matrices
# son iguales con data.frames:
datos  <- data.frame(x=rnorm(6), y=rnorm(6, mean=3))
matriz <- as.matrix(datos) 
datos[1,2] == matriz[1,2]        # Usan el mismo sistema de índices
cbind(datos, rnorm(6, mean=10))  # Funcionan igual con cbind y rbind
cbind(matriz, rnorm(6, mean=10))

# Sin embargo en ciertas ocasiones no son lo mismo:
x <- dist(datos)
x <- as.matrix(x)
image(x)                # No hay problema
image(as.data.frame(x)) # Sí hay problema...

# La clase data.frame comparte muchas características con objetos tipo
# "list", por lo que se pueden aplicar muchas funciones a estos objetos que
# no es posible en el caso de matrices. Por ejemplo:
sapply(datos,  mean) # Promedios de cada columna
sapply(matriz, mean) # Un resultado que no nos sirve de mucho...
# Más correcto sería:
apply(matriz, 2, mean)


# A lo largo de el curso nos vamos a ir enfrentando a distintos ejemplos de
# clases y cómo interactúan con los objetos y funciones de R. Es
# importante estar atento a los tipos de objetos con los que estamos
# trabajando, ya que de esto depende si el resultado de un comando da el
# valor correcto y esperado, un error o, peor aún, da un resultado
# incorrecto sin avisarnos con un mensaje de error.
