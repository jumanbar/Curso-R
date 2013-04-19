## Identificadores & Coercionadores
 
## Identificadores

# En R existen funciones que sirven para identificar las clases de los objetos.
# Esto nos interesa ya que muchas veces la posibilidad de aplicar una determi-
# nada función u operación va a depender de la clase del objeto con el que esta-
# mos trabajando.

# El primer tipo de identificador que vamos a ver es la función "class", que es
# directamente preguntar la clase del objeto que nos interesa.
x <- 1:5
class(x) # "integer", o sea un vector de enteros, un vector numérico.
y <- c("Hugo","Paco","Luis")
class(y) # "character", es un vector de caracteres.

# Un segundo tipo de identificador tiene la estructura "is.clase", y devuelve un
# objeto de clase "logical", o sea, verdadero o falso. Es, sencillamente, como
# preguntar si el objeto que nos interesa es de esa clase.
is.numeric(y)   # FALSE
is.character(y) # TRUE
is.numeric(x)   # TRUE
# Nótese que a pesar de que "x" es "integer", el resultado es TRUE, ya que los 
# vectores de enteros son también numéricos. 
is.character(x) # FALSE
 
# Algunos identificadores comunes son: is.vector, is.matrix, is.double, 
# is.complex, is.factor, is.data.frame, is.array, is.list, is.logical... La 
# lista completa es enorme (y se puede ver escribiendo is. + doble tab).
 
# Debe destacarse que existen algunos identificadores especiales:
# 1. is.na   (¿Es NA?)
# 2. is.null (¿Es NULL?)
# 3. is.nan  (¿Es NaN?)
# Estas funciones son a veces la única forma de detectar automáticamente la 
# presencia de elementos de estos tipos (NA, NULL, NaN).

# Ejemplos:
# NA viene a ser "Not Available" (no disponible) y se usa, por ejemplo, cuando
# falta algún dato en una serie.
x <- c(4, 7, NA, 5)
class(x) # sigue siendo "numeric", ya que el NA no altera la clase y se tiene en
         # cuenta la de los demás elementos.
x == NA  # En este caso no sirve usar este operador, ya que lo que devuelve no
         # tiene sentido: [1] NA NA NA NA
is.na(x) # Sólo con is.na se puede identificar un "NA", en este caso el tercer
         # elemento de nuestro vector: [1] FALSE FALSE TRUE FALSE

# NaN es "Not a Number" (no es un número)
log(-1) -> y # Recordemos: no se pueden calcular logaritmos de números negativos
# Warning message:
# In log(-1) : NaNs produced
y # [1] NaN
is.nan(y) # TRUE
 
# NULL viene a ser un "conjunto vacío"
x <- NULL
x == NULL  # logical(0)
is.null(x) # TRUE


## Coercionadores
 
# Muchas veces nos interesa convertir un objeto de una clase a otra. En R existe
# una serie de funciones que sirven para hacer estas transformaciones. Estas
# funciones, en la medida en que el objeto que nos interesa tenga el formato
# adecuado, lo "coercionan", lo transforman, generando un objeto de salida de la
# clase deseada.
 
# El nombre de estas funciones sigue la pauta: "as.clase", en donde la palabra
# "clase" debe ser sustituida por la clase a la que nos interesa que pertenezca
# nuestro objeto.
 
# Por ejemplo:
x <- c("2", "34", "5", "8")
class(x) # "character", un vector de caracteres
(y <- as.numeric(x)) # creamos ahora un objeto "y" a partir de "x", cambiando la
                     # clase a la que pertenece.

# A veces la transformación puede llevar a la pérdida de información. Por 
# ejemplo pasar de numeric a logical y después de nuevo a numeric no lleva al 
# objeto inicial:
x <- -3:5
class(x) # "integer"
(y <- as.logical(x))
# [1]  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
class(y) # "logical"
(z <- as.numeric(y))
# [1] 1 1 1 0 1 1 1 1

# Así que "z" es distinto a "x", a pesar de que a priori uno puede pensar que se
# hicieron caminos inversos, esto no es así ya que la operación realizada (en
# total) no fue biyectiva.

# También debe tenerse en cuenta que no todas las clases pueden coercionarse
# como queremos.
 
# Otras funciones útiles son: as.matrix, as.data.frame, as.factor, as.list,
# as.vector

# Estas funciones se comportan de forma similar a las que vimos aquí. En todos
# los casos deberemos ser particularmente cuidadosos de que el objeto de entrada
# tiene un formato y un tipo de datos acorde a lo que queremos que sea el obje-
# to de salida.

# Resumen:
# Los identificadores (is.___) sirven para determinar si un objeto pertenece o 
# no a una clase en particular. Los Coercionadores (as.___) son funciones de 
# gran utilidad cuando necesitamos aplicar ciertos métodos que no están para
# las clases que tengo a disposición. Ambos conjuntos de funciones siguen una
# convención de nombres para facilitar el uso de las mismas.
