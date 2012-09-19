## MANIPULACIÓN DE TABLAS DENTRO DE R

# La mayoría de las veces es recomendable aprovechar los programas con los que
# uno se siente más cómodo para manipular nuestras tablas/bases de datos. De
# todas formas, existen varias funciones en R para lograr nuestros objetivos,
# varias de las cuales pueden ser sumamente prácticas en muchos casos. En esta
# lección nos vamos enfocar en algunos casos destacados, en particular con
# algunas funciones para seleccionar observaciones y para fusionar matrices. De
# todas formas hay muchos paquetes se enfocan en funcionalidades para trabajar
# con datos, algunos ejemplos son: reshape2, gdata, bigtabulate y plyr.
 
# Estas herramientas pueden ser cruciales si necesitamos aplicar una misma
# rutina a una basta cantidad de tablas y queremos hacerlo de forma automatizada
# (complementando con el uso de loops y condicionales).
 
# En esta unidad vamos a usar varias bases de datos que vienen incluidas en el
# paquéte "datasets", el cual está incluido en el R básico. Para ver la lista
# completa:
library(help='datasets')

# Cualquiera de las bases de la lista está disponible automáticamente en
# nuestra sesión de R, por ejemplo "cars":
head(cars) # "head" sirve para ver los primeros elementos del objeto.
tail(cars) # "tail" es para los últimos.
head(iris)
tail(iris)

# Nota: en otros paquetes también hay bases de datos, pero no están
# disponibles de forma automática, si no que generalmente hay que usar la
# función "data":
data(basededatos) # (no correr)
 
# En R la clase "data.frame" es el tipo de objeto "estándar" para trabajar con
# datos. Presenta varias ventajas para esto, como una gran flexibilidad para
# interactuar con otras funciones en R. Como hemos visto anteriormente,
# presenta características de lista, pero tambien de matrices.

# Las filas de una data.frame son las observaciones, las columnas son las
# variables. Cada columna es un vector o un factor, y las distintas columnas
# pueden ser de clases diferentes. Un ejemplo rápido son las columnas de la
# tabla "iris", que presentan datos numéricos y categóricos (en la última
# columna).

# Si bien es un tipo de lista, una data.frame tiene la restricción de que
# todas las columnas tienen una misma cantidad de elementos, al igual que una
# matriz.

 
# AGREGAR/QUITAR FILAS Y COLUMNAS

# Las funciones cbind y rbind funcionan igual que con las matrices:
iris2 <- cbind(iris, nuevaCol=rep('hola', nrow(iris)))
head(iris2)
# Nótese que el nombre de la nueva columna fue agregado en el momento de
# ejecutar cbind.
 
# En R, por defecto, los vectores de la clase "character" son interpretados
# como "factor" al ser agregados a una data.frame:
class(iris2$nuevaCol) # "factor"
# Esto puede ocasionar errores o advertencias en R. Para estos casos se pueden
# usar los coercionadores, tal como se muestra en la lección correspondiente.
 
# Alternativamente:
iris2$otraCol <- rep('chau', nuevaCol=nrow(iris))
# también así se pueden agregar columnas...
head(iris2)

# En la lección "trabajo con tablas" se muestra el uso de "whithin" para crear
# columnas nuevas.
 
# Para quitar filas o columnas se pueden restar índices, al igual que en una
# matriz:
head(iris2[,-5])
head(iris2[,-c(2, 5)])
head(iris2[-(3:150),])
 
 
# SELECCIÓN DE OBSERVACIONES

# Muchas veces nos interesan, dentro de una tabla, sólo ciertas observaciones
# basadas en ciertos criterios. Generalmente existe la forma de expresar estos
# criterios utilizando operadores lógicos.

# Una de las formas más sencillas es usar which para seleccionar las filas o
# columnas que nos interesan.
x <- which(cars$dist > 20)
# "x" tiene los números de fila de las observaciones que cumplen la premisa
y <- cars[x,]
# Selecciona los casos que cumplen dist > 20

# También es posible escribir:
y <- cars[cars$dist > 20,]
# este método es de alguna forma más directo, aunque tiene la contra que
# suele amontonar palabras y caracteres, resultando en cosas difíciles de leer.
 
# Si queremos buscar en todos los elementos de una matriz o data.frame, se puede
# usar el argumento "arr.ind":
which(cars > 70, arr.ind=TRUE)
#      row col
# [1,]  23   2
# [2,]  34   2
# [3,]  35   2
# [4,]  47   2
# [5,]  48   2
# [6,]  49   2
# [7,]  50   2

# Como se puede ver, el resultado son las filas y columnas de los elementos
# que cumplen con la condición dada.


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

# Nota: muchas funciones aceptan un argumento "subset" para seleccionar las
# observaciones que nos interesan. Ejemplos: plot, lm, xtabs, ...
 
# A su vez el argumetno "select" sirve para elegir las columnas de interés:
(y <- subset(iris, subset=Sepal.Width > 3.8, select=Species))
# sólo la columna "Species"
(y <- subset(iris, subset=Sepal.Width > 3.8, select= -Species))
# sin la columna "Species"
(y <- subset(iris, subset=Sepal.Width > 3.8, select= -5))
# ídem

# En resumen, subset busca ser más intuitivo y directo que usar which() en
# combinación con los operadores [ ].

## Split
# A veces es necesario partir una tabla según ciertos criterios. La función
# split debe considerarse como una opción, ya que en una corta línea puede
# expresar un montón de pasos. Por ejemplo, si quiero partir la tabla "iris"
# en 3 tablas, una por cada especie, puedo hacer:
irisxspp <- split(iris, iris$Species)
str(irisxspp)
# El resultado es una lista con tres data.frames adentro, una por cada spp


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


## REDONDEO
# Si bien R no es un ambiente para trabajar manipulando tablas por excelencia,
# es cierto que tiene muchas facilidades que pueden ser muy útiles y
# prácticas si las sabemos aprovechar. En esta lección no hemos hecho más
# que rascar la superficie de lo que se puede hacer con funciones pre-armadas.
# Para el lector y el usuario ávido, recomendamos adentrarse en el uso de los
# paquetes reshape2, gdata, bigtabulate y plyr.
