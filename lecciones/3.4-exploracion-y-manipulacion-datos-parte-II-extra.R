
## FUNCIONES EXTRA

# Pasamos ahora a ver algunas utilidades especiales, que si bien no se usan de
# forma demasiado regular, pueden simplificar mucho ciertas tareas.

## Función merge: fusiona data.frames

?merge
# La función merge() es una alternativa a cbind/rbind, ya que no tienen que 
# estar las filas en el orden correcto para poder ser usada
 
# Vamos a tomar el ejemplo que viene en la ayuda de "merge", un poco modificado:
# Primero se crean dos tablas ("authors" y "books"):

## INICIO
authors <- data.frame(
    surname = I(c("Tukey", "Venables", "Tierney", "Ripley", "McNeil")),
    nationality = c("US", "Australia", "US", "UK", "Australia"),
    deceased = c("yes", rep("no", 4)),
hobby = rep('surf', 5))
books <- data.frame(
    name = I(c("Tukey", "Venables", "Tierney",
             "Ripley", "Ripley", "McNeil", "R Core")),
    title = c("Exploratory Data Analysis",
              "Modern Applied Statistics ...",
              "LISP-STAT",
              "Spatial Statistics", "Stochastic Simulation",
              "Interactive Data Analysis",
              "An Introduction to R"),
    other.author = c(NA, "Ripley", NA, NA, NA, NA,
                     "Venables & Smith"),
hobby = rep('chess', 7))
## FIN

# Echamos un vistazo a ambas:
authors
books
 
# Las columnas surname y name refieren a los mismos tipos de datos.
# Para agregar nuevas columnas a la tabla authors, usando las columnas
# presentes en books, podemos usar merge, sin preocuparnos de que las
# filas estén en orden correcto:
(m1 <- merge(authors, books, by.x='surname', by.y='name'))
# En este ejemplo x (el primer argumento) es "authors", mientras que y
# (el segundo argumento) es "books". Para indicar las columnas que tienen
# en común se usan los argumentos by.x y by.y.
# ¿Qué pasa si no se especifícan estos dos argumentos? Veamos:
(m1 <- merge(authors, books))
# Nótese cómo aparecen las columnas hobby.x y hobby.y: debido a que ambas
# tablas tenían esta columna y mostraban diferencias para las filas en común
# (por ejemplo, el autor "Tukey" gusta del surf y del ajedrez).
 
# En caso de que haya filas cuyos nombres no aparezcan en una de las dos
# tablas, se pueden agregar al resultado final usando all.x=TRUE o
# all.y=TRUE (según corresponda), o usando all=TRUE para incluir todos los
# casos (ver ayuda de ?merge).
(m1 <- merge(authors, books, by.x='surname', by.y='name', all=TRUE))


## Función xtabs: tablas de contingencia.

# Esta función crea tablas de contingencia, usando una "fórumla". Veamos uno de
# los ejemplos que muestra la ayuda:
?xtabs

# UCBAdmissions ya es de por sí una tabla de contingencia...
DF <- as.data.frame(UCBAdmissions)

# Ahora DF es una data.frame, con los conteos en la variable "Freq"
head(DF)

# Hacemos una tabla de contingencia, mostrando admisiones y rechazos según el
# hombres o mujeres:
(contin <- xtabs(Freq ~ Gender + Admit, DF))

# Usamos la función summary, que realiza un test de chi cuadrado para este
# tipo de datos:
summary(contin)
# Call: xtabs(formula = Freq ~ Gender + Admit, data = DF)
# Number of cases in table: 4526 
# Number of factors: 2 
# Test for independence of all factors:
# Chisq = 92.21, df = 1, p-value = 7.814e-22


## Funciones with y within

# Estas funciones sirven para ejecutar comandos "adentro" de una lista... Esto
# es útil ya que permite trabajar con los nombres de las variables
# directamente, en lugar de estar recordando los números de columnas y usando
# llaves todo el tiempo. 

# Los argumentos son:
# data: una lista que sirva para construir un "ambiente" en el cual ejecutar los comandos.
# En este ambiente los objetos existentes son los elementos de la lista
# expr: una expresión, un comando, o varios si se usan las llaves { }.
 
# Por ejemplo, creo una lista sencilla:
(lista <- list(x=5, y=rnorm(7), z=sample(7)))
# Dentro de esta lista, tengo los elementos x y z. Voy a usar estos valores
# para calcular x * y + z:
(u <- with(lista, x * y + z))

# Nótese que si no uso "with" tengo que escribir lo siguiente:
u <- lista[[1]] * lista[[2]] + lista[[3]]
# o
u <- lista$x * lista$y + lista$z
 
# Dado que las "data.frame" son listas también, se puede usar with de la misma
# forma. Por ejemplo, con la tabla "iris":
(u <- with(iris, Sepal.Length + Sepal.Width))
# Siempre se usan los nombres correspondientes. Este cálculo equivale a:
iris$Sepal.Length + iris$Sepal.Width

# La ganancia de usar with parece poca en este caso, sin embargo para cálculos
# más complejos las diferencias se vuelven significativas. Una estrategia
# común es usar las llaves { } dentro del mismo paréntesis (en el segundo
# argumento, donde va la expresión). A modo de ejemplo:
u <- with(lista, {
            a <- rep(y, z)
            b <- matrix(a, 7, 7)
            y <- b ^ x
            y
          })
u

# La salida (guardada aquí como "u") es el último comando de los que están entre
# las { }, siguiendo el criterio aplicado para "bloques de código" (ver la
# lección "uso de llaves"). Nótese el uso de la indentación, siguiendo el
# criterio de agregar una tabulación luego de la llave de apertura...

# Función within
# La función within devuelve una versión modifiada de la lista de entrada:
iris2 <- within(iris, Sepal.Ratio <- Sepal.Length / Sepal.Width)
head(iris2)
# Se puede ver que existe una nueva columna llamada "Sepal.Ratio". Este tipo
# de operaciones requiere que la nueva variable creada tenga el mismo número
# de observaciones que el resto de la tabla. En lo que refiere a las demás
# reglas de uso, "within" es idéntica a "with".


## FUNCIONES "tapply" y "by"

# Ya vimos que apply y sus variantes sirven para hacer cálculos en tablas
# aplicados a filas o columnas, o a elementos de una lista. Las funciones
# tapply y by dan un paso más en sofisticación: no sólo hacen cálculos por
# columna, si no que también por las categorías que defina el usuario, dentro
# del grupo de las observaciones.

# Por ejemplo, supongamos que nos interesa tomar la base de datos iris y
# calcular los promedios, no sólamente para cada variable (Sepal.Length,
# Sepal.Width, etc...), si no que además queremos separar por especie (setosa,
# versicolor y virginica).

# Para lograr esto debemos definir primero que nada las variables para las que
# queremos aplicar la función "mean": serían todas las variables menos
# "Species":
variables <- iris[, -5]

# Ahora debemos definir las categorías, que obviamente son las contenidas en
# la columna "Species" de iris:
categorias <- iris$Species

# Ya que vamos a usar la función mean y no necesitamos argumentos secundarios,
# podemos pasar a hacer los cálculos directamente, utilizando la función "by":
u <- by(variables, categorias, mean)
# (alguien ha criticado ya el mal ordenamiento de los argumentos de by...)
u
# El objeto generado muestra exactamente lo que estábamos buscando. Es un
# objeto tipo lista, de clase "by". Para trabajar con los valores contenidos
# se pueden utilizar los operadores de listas, [[]] y $, aunque es un poco
# engorroso. Tal vez más sencillo sea convertir esta salida en matriz, usando
# la función "unlist" (as.matrix no da un resultado muy bueno en este caso):
x <- unlist(u)
x <- matrix(x, nrow=nlevels(categorias))

# La función tapply hace exactamente lo mismo, pero de forma más limitada:
# sólo puede ir de a una variable a la vez. Por ejemplo usando sólamente
# Sepal.Width podemos hacer de vuelta los cálculos anteriores:

variable <- iris$Sepal.Width
# La variable es nueva, las categorías son las mismas, así que se puede pasar
# directamente al comando:
v <- tapply(variable, categorias, mean)
# El resultado es mucho más simple, un vector numérico:
v
#     setosa versicolor  virginica 
#      3.428      2.770      2.974

# Nótese que en los dos ejemplos expuestos los objetos generados tienen
# similitudes y diferencias, y pertenecen a clases diferentes:
class(u)
class(v)


## Paquete reshape2

# Según la descripción en la página de reshape2 (http://had.co.nz/reshape/):

# Reshape hace (o intenta hacer) más fácil lo que usted ha luchado por lograr con 
# tapply, by, aggregate, xtabs y summarise. También es útil para ajustar sus datos 
# a la estructura correcta para usar en gráficos de ggplot o lattice.

# Primero cargue el paquete:
# install.packages("reshape2") # Si no lo tiene instalado
library(reshape2)

# Función melt:
# "Mueve valores de varias columnas a una sola", usando una o más columnas como
# "identidad". Veamos un ejemplo, con la base de datos "airquality" que ya viene
# con R:

# Primero vamos a cear un ejemplo de juguete, una data.frame con datos organizados
# de una forma mixta: por filas y por columnas

medidas <- matrix(rpois(5 * 4, 30), 4, 5)
colnames(medidas) <- paste("estacion", 1:5, sep = ".")
datos <- data.frame(dia.noche = gl(2, 2, labels = c("dia", "noche")),
                    trat = rep(c("A", "B"), 2))
datos <- cbind(datos, medidas)

# Un vistazo a los datos de juguete:
datos

# Ahora haremos melt para esta data.frame, tomando como variables de identidad
# las columnas dia.noche y trat:
mdatos <- melt(datos, id=c("dia.noche", "trat"))
mdatos

# Como se puede ver, todas las variables que están por fuera del argumento
# id quedaron en una misma columna: "variable", una variable de clase factor
# y sus niveles son los nombres de las columnas fuera de id.

# A su vez, los valores originales de aquellas columnas se ponen todos juntos 
# la nueva variable "value".

# Como resultado, el número de filas de mdatos es igual a 20; es el número de
# filas de datos * el número de columnas que no son "id" (= 2 en este caso):
nrow(datos) * (ncol(datos) - 2)

# Una consecuencia secundaria, y nada despreciable, es que ahora es más sencillo
# graficar los valores según tratamientos:

plot(value ~ trat, mdatos)
plot(value ~ dia.noche, mdatos)
plot(value ~ variable, mdatos)

# Con ggplot2 se pueden hacer unos gráficos muy interesantes con facilidad:
# install.packages("ggplot2") # Si no está instalado
library(ggplot2)
p <- ggplot(mdatos, aes(y = value))
p + geom_point(aes(x = variable, color = dia.noche), size = 4)
p + geom_point(aes(x = variable, color = dia.noche, shape = trat), size = 4)

# Ejemplo con boxplot:
p + geom_boxplot(aes(x = variable, color = dia.noche))
p + geom_boxplot(aes(x = variable, color = trat))

# (el paquete ggplot2 no lo veremos en el curso)

