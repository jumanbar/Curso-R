#### Listas y data.frame

# Hasta ahora hemos visto vectores y matrices como las estructuras más 
# sencillas para organizar la información dentro de R. Una restricción
# importante es que dichos objetos requieren que todos los elementos que los 
# componen deben ser de la misma clase/tipo. En R la clase "list" (o lista 
# para nosotros) tiene una estructura que supera esta limitación. Por otro 
# lado, la clase data.frame es un tipo particular de lista, pensada para 
# trabajar con tablas de datos, de forma que son muy similares a las matrices, 
# aunque con diferencias que merecen ser recordadas.

## Listas

# Una lista puede pensarse como un vector que contiene a otros vectores, donde 
# cada vector puede ser de un tipo/clase diferente. Además los componentes de la
# lista no tienen porqué tener la misma cantidad de elementos.

x <- list(rep('pepe', 3), 1:20)
# En este caso, x contiene a un vector "character" y otro "numeric"; el primero 
# tiene 3 elementos, mientas que el segundo tiene 20:

x[[1]]
# [1] "pepe" "pepe" "pepe"
class(x[[1]]) # "character"
length(x[[2]]) # 3

x[[2]]
# [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
class(x[[2]]) # "integer"
length(x[[2]]) # 20

# Esta misma información la podemos obtener usando la función str:
str(x)

# La misma lista se puede crear a partir de una lista vacía:
x <- vector('list', 2) # Lista vacía, con 2 elementos.
x[[1]] <- rep('pepe', 3)
x[[2]] <- 1:20

# Las listas son útiles para agrupar varios tipos de datos en un sólo objeto, ya
# que no es tan restrictivo como las matrices o los vectores normales.

# Ejemplo: como vimos antes, eigen devuelve un objeto lista
x  <- matrix(1:25, 5, 5)
vv <- eigen(x)
 
# Los elementos de la lista se obtienen o modifican con doble corchete [[ ]]
vv[[1]]
 
# En el caso de las listas, si los elementos están nombrados, se puede usar el $
# para llamarlos:
vv$values
 
# Si queremos llamar al primer elemento de 'values', hay que usar el criterio
# que corresponda para el tipo de objeto que es, por ejemplo:
vv$values    # todos los elementos
vv$values[1] # sólo el primer elemento
vv[[1]][1]   # ídem
 
# Pero con los vectores propios (que están en forma de matriz), hay que
# considerar que tienen dos dimensiones:
vv$vectors[1,4] # fila 1, columna 4
vv[[2]][1,4]    # ídem


## data.frame
# La clase "data.frame" es un tipo particular de lista. Es básicamente una tabla
# de datos, con filas como casos y columnas como variables. De hecho vamos a
# llamar "columnas" o "variables" indistintamente para referirnos a las columnas
# de una data.frame.

# "cars" e "iris" son dos tablas de datos que vienen incluídas con los paquetes
# básicos de R y que ya están en la sesión por defecto:
class(cars)
head(cars)  # "head" devuelve las primeras filas de una matriz o data.frame
head(iris)
dim(iris)   # Funciona igual que en matrices
mean(iris)  # Otra vez, comportamiento diferente

# Al igual que con las listas comunes, el operador $ sirve para llamar las
# variables por sus nombres:
cars$speed
iris$Petal.Length

# Aunque también se pueden usar los números:
cars[[1]]
iris[[3]]

# Un resultado similar se puede obtener usando corchetes simples:
cars[1] # Es la primer columna

# La diferencia entre [ ] y [[ ]] en este caso es la clase a la que pertenecen
# los resultados:
class(cars[1])
# [1] "data.frame"
class(cars[[1]])
# [1] "numeric"
# En el último caso la clase del objeto es la misma que el de la variable
# correspondiente:
class(cars$speed) # "numeric"

# En muchos sentidos es igual a un objeto matrix
iris[1,]
iris[2, 5]
(x <- cbind(iris, nuevaCol=1:150))
head(x) # Nótese cómo se nombro la nueva columna en el momento de agregarla.

# Aunque no todo está permitido ...
rbind(cars, matrix(0, 4, 2)) # El problema está en la diferencia de nombres.

# Sin embargo tiene la ventaja de que las columnas pueden ser de distintas
# clases:
class(iris$Species)      # "factor"
class(iris$Sepal.Length) # "numeric"

# ¿Cómo crear data.frames?
# Una forma de crear un data.frame es transformar algo en este tipo de objeto:
# "as.data.frame" sirve para convertir un objeto de otra clase (vector, matriz)
# como data.frame:
(y <- as.data.frame(x))
# Nótese que las columnas/variables de y tienen nombres (en lugar de [,1],
# [,2], etc...), ya que es una de las características de la clase data.frame.
class(y) # "data.frame"
# x sin embargo no ha cambiado:
class(x)

# Otra forma de crear un data.frame
dataf <- data.frame(enteros=1:10, decimales=seq(.1, 1, by=.1))
# El resultado, "dataf", es una tabla con dos columnas llamadas "enteros" y
# "decimales")
head(dataf)
 
# El data.frame está pensado especialmente para trabajar con datos y la
# muchos métodos gráficos o estadísticos están definidos para trabajar
# sólamente con este tipo de objetos. Vamos a profundizar en estos aspectos en
# el segundo módulo del curso. Por ahora nos vamos a limitar a un par de
# ejemplos gráficos:
plot(iris)
plot(Petal.Length ~ Petal.Width, data=iris, col=rep(1:3, each=50))
# En verdad este ejemplo se puede hacer con matrices, siempre y cuando tengan
# columnas nombradas.
plot(Petl.Length ~ Species, data=iris)
# Ploteo de cajas: este no se puede hacer con matrices, ya que requiere una
# variable categórica, "Species".

# Debido a que son muy parecidas, uno tiende a usar las mismas funciones para
# matrix y data.frames, pero a veces nos puede dar error por usar la clase
# equivocada... hay que estar atentos.
x <- matrix(1:30, 6, 5)
plot(x)
# Esto grafica las dos primeras columnas de x en los ejes x e y del gráfico
plot(as.data.frame(x))
# Al graficar a x como data.frame se grafica cada par de variables, o sea todas
# contra todas las columnas

# Resumen:
# Las listas y las data.frames son dos estructuras muy convenientes para
# trabajar con datos. Su complejidad no es significativamente mayor al de las
# matrices, y sin embargo tienen diferencias que van a probar ser cruciales para
# facilitar un diálogo fluído en análisis estadísticos y el trabajo con datos.
