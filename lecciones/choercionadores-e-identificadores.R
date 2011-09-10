#### cohercionadores
## Muchas veces nos interesa convertir un vector de una clase a otra. Existe en R una serie de funciones que sirven para hacer estas transformaciones.
## Estas funciones, si pueden, "cohercionan" el objeto de entrada, generando un objeto de salida de la clase deseada.
## El nombre de estas funciones sigue la pauta: "as.clase", en donde la palabra "clase" debe ser sustituida por una clase verdadera...
## Por ejemplo:
x <- c("2", "34", "5", "8")
class(x) # "character"
(y <- as.numeric(x))
# le agrego paréntesis para que se imprima el resultado en la consola
class(y) # "numeric"
 
# De forma inversa:
u <- as.character(y)
u == x
# [1] TRUE TRUE TRUE TRUE
all.equal(u, x) # TRUE
 
# A veces la transformación puede llevar a la pérdida de información
x <- -3:5
class(x)
(y <- as.logical(x))
# [1]  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
class(y) # "logical"
(z <- as.numeric(y))
# [1] 1 1 1 0 1 1 1 1
 
## Así que "z" es distinto a "x", a pesar de que a priori uno puede
## pensar que se hicieron caminos inversos, esto no es así ya que la
## operación realizada (en total) no fue biyectiva.
 
# Otras funciones útiles son:
as.matrix
as.data.frame
as.factor
as.list
as.vector
 
#### Identificadores
## De manera similar, existen funciones que sirven para identificar
## las clases de los objetos.
x <- 1:5
is.numeric(x) # Nótese que a pesar de que "x" es "integer", el resultado es TRUE
 
is.character(x) # FALSE
 
#### Algunos identificadores comunes:
is.vector
is.matrix
is.double  # Si es un número con decimales o no.
is.complex # números complejos...
is.factor
is.data.frame
is.array
is.list
is.logical
 
## Debe destacarse que exsten algunos especiales:
is.na   # ¿Es NA?
is.null # ¿Es NULL?
is.nan  # ¿Es NaN?
 
### Ejemplos:
## NA viene a ser "Not Available" (no disponible)
x <- c(4, 7, NA, 5)
x == NA  ## No sirve usar este operador
# [1] NA NA NA NA
is.na(x) ## sólo con is.na se puede identificar un "NA"
# [1] FALSE FALSE  TRUE FALSE
 
## NaN es "Not a Number" (no es un número)
log(-1) -> y # log no está definida para números negativos...
# Warning message:
# In log(-1) : NaNs produced
y
# [1] NaN
 
## NULL viene a ser un "conjunto vacío"
x <- NULL
x == NULL  # logical(0)
is.null(x) # TRUE
 
y <- c(5, x, 6, 7)
y # El x ni siquiera aparece...
