#######################################################
### ESTRUCTURA BÁSICA NECESARIA PARA DEFINIR UNA FUNCIÓN:

nombre <- function( arg1, arg2, arg3 ) {
# En la primer línea se define el nombre de la función y el de los
# argumentos necesarios para correrla.
# En este caso la función se llama "nombre" y los argumentos
# se llaman "arg1", "arg2" y "arg3"

   ## Los límites marcados por { y } indícan el "ambiente" de la
   ## función. Acá va la secuencia de comandos que generan una
   ## salida.

   ## Lo que no se define acá adentro (en general) es como si
   ## no existiera afuera (en la sesión de R), y viceversa.
   ## Por eso es necesario que existan argumentos, ya que dentro de
   ## este ambiente esos argumentos son objetos (números, vectores,
   ## palabras) con los cuales se ejecutan comandos.

   return( salida )
}
#######################################################

#######################################################
### EJEMPLO DE UNA FUNCIÓN (CURVA LOGÍSTICA)

## Se va a llamar "logi"
logi <- function(ini, fin) {
# Los argumentos ini y fin son números que se van a usar acá:
  x <- seq(ini, fin, by=0.01)
  y <- exp(x) / (1 + exp(x))
  plot(y ~ x, type='l')
   return(y)
}
## Corriendo estas 7 líneas se DEFINE la función, para ejecutarla:
x <- logi(- 10, 10)
## Cuando llamo a la función puedo usar los nombres de los argumentos
## (de igual forma que lo hacemos normalmente)
x <- logi(ini=-10, fin=10) # Es equivalente a lo anterior
x <- logi(fin=10, ini=-10) # Tambien es equivalente

## Se pueden fijar valores por defecto para ini y fin
logi <- function(ini=-8, fin=8) {
  x <- seq(ini, fin, by=0.01)
  y <- exp(x) / (1 + exp(x))
  plot(y ~ x, type='l')
  return(y)
}
## Esta versión de logi se puede correr aunque el usuario no indique alguno
## de los argumentos:
x <- logi()  # va de -8 a 8
x <- logi(0) # va de 0 a 8
x <- logi(fin=0) # va de -8 a 0

## Para chequear cuales son los argumentos de cualquier función:
args(logi)
args(rnorm)
args(plot)

## Se pueden agregar más argumentos:
logi <- function(ini=-8, fin=8, int=0.05) {
  x <- seq(ini, fin, by=int) # El nuevo argumento "int" va a ser pasado
                             # a la función seq
  y <- exp(x) / (1 + exp(x))
  plot(y ~ x, type='l')
  return(y)
}

## Se puede correr:
x <- logi(int=3) ## ¿Se ve distinto que antes el plot? ¿Por qué?

## El argumento especial "..."
## Considerando esta función simple que grafica una curva logística:
logi <- function(ini=-8, fin=8, int=0.05, ...) { # se agrega "..." a la lista de argumentos
  x <- seq(ini, fin, by=int)
  y <- exp(x) / (1 + exp(x))
  plot(y ~ x, type='l', ...) # acá también se agrega "..."
  return(y)
}

## Ahora se pueden pasar argumentos a la función plot que está adentro
## de la función logi, de la siguiente manera (ejemplos):
x <- logi(-15, 15, col="blue")
x <- logi(-15, 15, col="blue", lwd=4)
x <- logi(-15, 15, col="blue", lwd=4, ylab="Curva Logística")
x <- logi(-15, 15, col="blue", lwd=4, main="Curva Logística", ylab='f(x)')

## Lo mismo se puede hacer para cualquier otra función a parte de plot.

## Nota: se puede usar el comando "return(out)", en donde out es el objeto de salida de la
## función, en cualquier parte de la misma. Esto indica que la función se debe interrumpir y
## que se devuelve el objeto out. En caso de querer que nuestra función devuelva algo pero
## que no lo imprima en la consola, se puede usar "invisible(out)".

#######################################################





