## Factores
 
# Los objetos de clase "factor" son objetos que sirven para trabajar con varia-
# bles categóricas, como pueden ser franjas etarias, nombres de especies o
# lugares. Una forma de comprender el concepto de factor es pensando en su uso
# dentro del diseño experimental: un factor es una variable cuyo efecto se busca
# entender; en un experimento se crean distintos tratamientos, cada uno con un
# nivel determinado para dicho factor. Estos tratamientos equivalen al concepto
# de niveles o "levels" utilizado en los objetos "factor" de R.
 
# Ejemplo: efecto del nitrógeno en el crecimiento de un cultivo. Un
# tratamiento puede ser sin N y otro con N. Entonces tenemos un factor ("N")
# con dos niveles (que pueden ser denominados 0 y 1, o de cualquier otra
# forma).

# Este tipo de objetos se encuentra frecuentemente como variables en 
# data.frames, como por ejemplo la quinta columna de la data.frame "iris":
str(iris)
class(iris$Species)
# En general estos objetos no sirven para trabajar con operadores matemáticos, 
# de manera similar, si bien no idéntica, a lo que ocurre con vectores 
# character. Por ejemplo:
iris$Species * 2
# De todas formas estos objetos se pueden coercionar en vectores numéricos, 
# como veremos en esta lección.


## Métodos de creación

# Una manera simple de crear un factor es hacer un character y luego 
# transformarlo con el coercionador as.factor o directamente con la función 
# "factor". Por ejemplo, un factor con tres niveles/categorías llamados N1, 
# N2 y N3, repetidos cinco veces cada uno (el equivalente a un experimento con 
# tres tratamientos y 5 réplicas), puede crearse así:
# 1ero. hago el vector 'character':
clasif <- rep(c('N1', 'N2', 'N3'), each = 5)
# y, a partir del mismo creo un factor:
f <- factor(clasif)
# o
f <- as.factor(clasif)
# Este comando admite otras opciones que no exploraremos ahora, pero que se 
# pueden ver en la ayuda:
?factor
 
# Alternativamente, podemos utilizar la función "gl", de modo que si queremos 
# crear un factor idéntico al anterior, lo haremos de la siguiente manera:
f <- gl(3, 5, labels=c('N1', 'N2', 'N3'))
# El resutado no es exactamente el mismo, sino que están agrupados todas las
# observaciones que tienen la misma etiqueta.

# Otro método útil de crear factores es el uso de la función cut para pasar 
# de valores numéricos ("continuos") a categorías/niveles. Para esto sólo es 
# necesario indicar el número de los niveles que necesitamos. Por ejemplo, si 
# asumimos que "edades" es un muestreo de edades de estudiantes:
edades <- rpois(150, 25)

# Podemos crear un factor de 4 categorías con el siguiente comando:
(edades4 <- cut(edades, 4))
 
# En la consola se ve en qué rango de edades cae cada observación y cuáles
# son estos rangos ("Levels"). Se usa la notación estándar de matemáticas 
# para indicar intervalos semiabiertos: paréntesis curvo para el extremo 
# "abierto" y paréntesis recto/corchete para el extremo "cerrado".
# (más detalles en Wikipedia:)
browseURL('https://es.wikipedia.org/wiki/Intervalo_%28matem%C3%A1tica%29#Intervalo_semiabierto')


## Conversión a otras clases de objetos

# A veces nos interesa trabajar sólo con los rótulos de las observaciones, es 
# decir, con un vector de clase character hecho a partir del factor. Esto se 
# obtiene con as.character o as.vector, por ejemplo:
as.character(f)
as.vector(f)

# De manera similar, es posible también convertir al factor en un vector 
# numérico, cuyos valores se corresponden con los rótulos originales. Por 
# ejemplo, compare las dos salidas de los siguientes comandos:
f
as.numeric(f)
as.integer(f)


## Niveles de los factores

# Como ya se vió, los niveles/categorías/tratamientos son parte cetral de la 
# definición de los factores y siempre se imprimen en la consola cuando vemos 
# estos objetos. Si queremos ver exclusivamente este atributo de un objeto de 
# clase factor, entonces podemos usar la función levels:
levels(f)
# Nota: la salida aquí es de clase "character". Esta función también se 
# puede usar para modificar los rótulos de los niveles del factor, de manera 
# similar a cómo se usa la función names:
levels(f)[2] <- 'n2' # Cambia el nombre del segundo nivel

# Finalmente, la función nlevels nos da el número de categorías de nuestro 
# factor:
nlevels(f)
# [1] 3
# (es decir, es equivalente a "length(levels(f))")


# Resumen:
# En definitiva, los factores son una construcción útil de R que está pensada
# para trabajar con variables categóricas. En el curso se va a profundizar en
# los usos de los factores, particularmente en los temas relacionados con esta-
# dística y trabajo con datos.
 
# Nota final: no es nada raro confundir un objeto "factor" con uno "character",
# sobre todo cuando uno está aprendiendo R (y en particular luego de importar
# matrices o data.frames). Por esto se recomienda estar atento a la salida que R
# imprime en la consola (si es un factor se imprimen los "Levels:..." al final).
# En el caso de importación de datos, la opción por defecto es que las columnas
# con texto se interpetan como factores. Esto se puede evitar usando el argumen-
# to "stringsAsFactor = FALSE" en las funciones read.xxxx

