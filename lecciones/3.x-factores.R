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
 
# Si queremos crear un factor con tres niveles y cinco casos de cada uno,
# podemos crear un vector de clase "character" con los valores deseados:
clasif <- rep(c('N1', 'N2', 'N3'), 5)
# y, a partir del mismo crear un factor:
x <- factor(clasif)
# Este comando admite otras opciones que no exploraremos ahora, pero que se 
# pueden ver en la ayuda
?factor
 
# Alternativamente, podemos utilizar la función "gl"
?gl
# de modo que si queremos crear un factor similar al anterior, lo haremos de la
# siguiente manera:
x <- gl(3, 5, labels=c('N1', 'N2', 'N3'))
# El resutado no es exactamente el mismo, sino que están agrupados todas las
# observaciones que tienen la misma etiqueta.
 
# Niveles (rótulos)
levels(x) # salida de clase "character"
# [1] "N1" "N2" "N3"
 
# Para obtener simplemente los rótulos de todas las observaciones, se
# puede cohercionar el factor en un "character":
as.character(x)
as.vector(x)
 
# Nótese que los factores no son vectores:
is.vector(x)
 
# La función "nlevels" nos devuelve la cantidad de niveles de un factor:
nlevels(x)
# [1] 3
 
# Para quitarle los rótulos a un factor:
y <- unclass(x)
y
# Ahora lo puedo transformar en numeric:
as.numeric(y)
# Nótese que los números de este nuevo vector no tienen por qué guardar relación
# alguna con los valores de los rótulos originales del factor.
 
# Si los nombres de los rótulos son números
f <- gl(2, 3)
f
# entonces se puede convertir el factor en un vector numérico (con los valores
# de los rótulos), usando:
as.numeric(levels(f))[f]
 
# Una variable numérica puede ser categorizada en un factor, usando la función
# "cut".
?cut
# Por ejemplo, si asumimos que "edades" es un muestreo de edades de estudiantes
# de la universidad:
edades <- rpois(150, 25)
 
# Podemos crear, por ejemplo, un factor de 4 categorías:
(edades4 <- cut(edades, 4))
# de 6
(edades6 <- cut(edades, 6))
# etc.
 
# En la consola podemos ver en qué rango de edades cae cada observación y cuáles
# son estos rangos ("Levels").
 
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
# to "stringsAsFactor = FALSE".
