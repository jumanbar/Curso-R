## MANIPULACIÓN DE TABLAS DENTRO DE R
 
# La mayoría de las veces es recomendable aprovechar los programas con los que uno se
# siente más cómodo para manipular nuestras tablas/bases de datos. De todas formas, existen
# varias funciones en R para lograr nuestros objetivos. En esta lección nos vamos enfocar
# en algunas de las funciones que existen, en particular con algunas funciones para seleccionar
# observaciones y para fusionar matrices. De todas formas hay muchos paquetes se enfocan
# en agregar funcionalidades para trabajar con datos, algunos ejemplos son: reshape2,
# gdata, bigtabulate y plyr.
 
# Estas herramientas pueden ser cruciales si necesitamos aplicar una misma rutina a una
# vasta cantidad de tablas y queremos hacerlo de forma automatizada (para esas tareas hay
# que complementar los temas de esta unidad con los de "Estructuras de control").
 
# En esta unidad vamos a usar varias bases de datos que vienen incluidas en el paquéte
# "datasets", el cual está incluido en el R básico. Para ver la lista completa:
library(help='datasets')
# Cualquiera de las bases de la lista está disponible, por ejemplo "cars"
head(cars) # "head" sirve para ver los primeros elementos del objeto.
tail(cars) # "tail" es para los últimos.
head(iris)
tail(iris)
# Nota: es recomendable que recuerden los nombres de las columnas de estas tablas, ya que
# las vamos a usar repetidament en el curso.
# Nota: en otros paquetes también hay bases de datos, pero no están disponibles así nomás,
# generalmente hay que usar la función "data", así:
data(basededatos) # Sólo un ejemplo
 
# En R la clase "data.frame" es el tipo de tabla pensado para trabajar con datos, que
# comparte propiedades con la clase "list" y con la clase "matrix".
 
# Las filas de una data.frame son las observaciones, las columnas son las variables. Cada
# columna es un vector o un factor, y las distintas columnas pueden ser de clases diferentes.
names(iris)
# [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"     
class(iris[,5])
# [1] "factor"
class(iris$Species) # es equivalente al comando anterior
# [1] "factor"
class(iris[,4])
# [1] "numeric"
class(iris$Petal.Width) # equivalente al comando anterior
# [1] "numeric"

# Nota: en RStudio se pueden autocompletar los nombres de los elementos usando la tecla
# tab a medida que vamos escribiendo, ej: iris$ + tab (muestra un pequeño menú con las opciones)
 
# A diferencia de una lista común, todas las columnas deben tener la misma longitud (o
# cantidad de elementos).
 
# Muchas funciones que trabajan con matrices también sirven para data.frames:
nrow(iris)
ncol(iris)
colnames(iris)
rownames(iris)
colMeans(iris[,-5]) # La última columna es factor, así que no se puede hacer el promedio
rowMeans(iris[,-5])
colSums(iris[,-5])
rowSums(iris[,-5])
 
 
# AGREGAR/QUITAR FILAS Y COLUMNAS

# Las funciones cbind y rbind funcionan igual que con las matrices:
iris2 <- cbind(iris, rep('hola', nuevaCol=nrow(iris)))
head(iris2)
 
# En R, por defecto, los vectores de la clase "character" son interpretados
# como "factor" al ser agregados a una "data.frame":
class(iris2$nuevaCol) # "factor"
 
# Para cambiar la clase de esta columna se pueden usar cohercionadores. Esto es suponiendo
# que existen métodos para pasar de una clase a la otra:
iris2$nuevaCol <- as.character(iris2$nuevaCol) # ahora es "character"
iris2$nuevaCol <- as.vector(iris2$nuevaCol) # ahora tambien es "character"
 
# Para el caso de los objetos "factor", puede ser útil saber los niveles en los que se
# encuentra (los valores posibles):
levels(iris$Species)
# [1] "setosa"     "versicolor" "virginica"
# Nota: la salida de levels es "character" (más sobre factores en la lección homónima).
 
# Para el caso de las columnas, se pueden agregar nuevas con el operador "$":
iris2$otraCol <- rep('chau', nuevaCol=nrow(iris))
# El nuevo vector debe tener la misma cantidad de elementos
head(iris2)
 
# Para quitar filas o columnas se pueden restar índices, al igual que en una matriz:
head(iris2[,-5])
head(iris2[,-c(2, 5)])
head(iris2[-(3:150),])
 
# Más adelante se va a mencionar el uso de whithin para crear columnas nuevas.
 
 
# SELECCIÓN DE OBSERVACIONES
# Usando which se pueden seleccionar las filas o columnas que nos interesan.
x <- which(cars$dist > 20) # "x" tiene los números de fila que cumplen la premisa
y <- cars[x,]
# Selecciona los casos que cumplen dist > 20
# También es posible:
x <- cars$dist > 20
y <- cars[x,]
# o
y <- cars[cars$dist > 20, ]
 
# Si queremos buscar en todos los elementos de una matriz o data.frame, se puede usar
# el argumento "arr.ind":
which(cars > 70, arr.ind=TRUE) # cars tiene sólo elementos "numeric", con iris da una advertencia
#      row col
# [1,]  23   2
# [2,]  34   2
# [3,]  35   2
# [4,]  47   2
# [5,]  48   2
# [6,]  49   2
# [7,]  50   2
 
# Usando operadores lógicos se pueden hacer filtros más elaborados:
x <- which(cars$dist > 20 & cars$speed <= 15)
y <- cars[x,]
# Selecciona los casos que cumplen dist > 20 y speed <= 15
 
# Para el caso de data.frames, el R tiene una función para hacer esto, la cual es más
# recomendable en general: "subset"
?subset
# Para hacer exactamente lo mismo que antes, pero con subset:
y <- subset(cars, subset=dist > 20 & speed <= 15)
# El argumento "subset" (sí, el argumento se llama igual que la función, espero no sea
# demasiado confuso) acepta un vector lógico. Se puede hacer en dos pasos:
x <- dist > 20 & speed <= 15
y <- subset(cars, subset=x)
 
# Para los factores hay que usar comillas:
class(iris$Species)  # "factor"
levels(iris$Species) # 'setosa' 'versicolor' 'virginica'
(y <- subset(iris, Species == 'setosa' & Sepal.Length >= 4.96))
 
# A su vez el argumetno "select" sirve para elegir las columnas de interés:
(y <- subset(iris, subset=Sepal.Width > 3.8, select=Species))   # sólo la columna "Species"
(y <- subset(iris, subset=Sepal.Width > 3.8, select= -Species)) # sin la columna "Species"
(y <- subset(iris, subset=Sepal.Width > 3.8, select= -5))       # ídem
 
# En resumen, subset busca ser más intuitivo y directo que usar which() en
# combinación con los operadores [ ]
 
# Nota final: muchas funciones aceptan un argumento "subset" para seleccionar las
# observaciones que nos interesan. Ejemplos: plot, lm, xtabs, ...
 
 
## FUNCIÓN merge: FUSIONA DATA.FRAMES

?merge
# La función merge() es una alternativa a cbind/rbind, ya que no tienen que 
# estar las filas en el orden correcto para poder ser usada
 
# Vamos a tomar el ejemplo que viene en la ayuda de "merge", un poco modificado:
# Primero se crean dos tablas ("authors" y "books"):
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
# ¿Qué pasa si no se especifícan estos dos argumentos?
# Nótese cómo aparecen las columnas hobby.x y hobby.y: debido a que ambas
# tablas tenían esta columna y mostraban diferencias para las filas en común
# (por ejemplo, el autor "Tukey" gusta del surf y del ajedrez).
 
# En caso de que haya filas cuyos nombres no aparezcan en una de las dos
# tablas, se pueden agregar al resultado final usando all.x=TRUE o
# all.y=TRUE (según corresponda), o usando all=TRUE para incluir todos los
# casos (ver ayuda de ?merge).
(m1 <- merge(authors, books, by.x='surname', by.y='name', all=TRUE))
 
 
 
## FUNCIÓN xtabs

# Esta función crea tablas de contingencia, usando una "fórumla". Veamos uno de los
# ejemplos que muestra la ayuda:
?xtabs
# UCBAdmissions ya es de por sí una tabla de contingencia...
DF <- as.data.frame(UCBAdmissions)
# Ahora DF es una data.frame, con los conteos en la variable "Freq"
head(DF)
# Hacemos una tabla de contingencia, mostrando admisiones y rechazos según el género:
(contin <- xtabs(Freq ~ Gender + Admit, DF))
# La función summary ya hace un test de chi cuadrado:
summary(contin)
# Call: xtabs(formula = Freq ~ Gender + Admit, data = DF)
# Number of cases in table: 4526 
# Number of factors: 2 
# Test for independence of all factors:
# 	Chisq = 92.21, df = 1, p-value = 7.814e-22
