# Al igual que con las listas comunes, el operador $ sirve para llamar las
# variables por sus nombres, en el caso de que los tengan:
cars$speed
iris$Petal.Length

# Y al igual que en las listas también se puede usar los números entre corche-
# tes dobles:
cars[[1]]
iris[[3]]



# Un resultado similar, aunque no igual, se puede obtener usando corchetes
# simples:
cars[1] 

# La diferencia entre [ ] y [[ ]] en este caso es la clase a la que pertenecen
# los resultados:
class(cars[1])
# [1] "data.frame"
class(cars[[1]])
# [1] "numeric"
# En el último caso la clase del objeto es la misma que la de la variable
# correspondiente, o sea un vector numérico:
class(cars$speed) # "numeric"

# Aunque no todo está permitido ...
rbind(cars, matrix(0, 4, 2)) # El problema está en la diferencia de nombres.


# Los atributos y las clases de los objetos son frecuentes causantes de errores
# y confusiones. Existen objetos que tienen atributos de varias clases, ya que
# hay clases que heredan y/o comparten atributos con otras.
# Un caso clarísimo es la clase "data.frame", la cual tiene varias facilidades
# para trabajar con datos que la hacen superior a la clase "matrix" para dichas
# tareas, a pesar de que tienen muchas cosas en común.
# Una consecuencia de esta similitud es que muchas operaciones con matrices son
# iguales con data.frames:
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
 
