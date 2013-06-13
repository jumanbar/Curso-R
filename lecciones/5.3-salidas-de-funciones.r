## Salidas de funciones

# En esta lección vamos a explorar las diferentes opciones de salida que podemos
# darle a una función, desde un valor sencillo sin ningún detalle hasta salidas
# listadas más complejas.

v <- 15:25  # Vamos a necesitar un objeto 'v' para los ejemplos.

# Salidas simples
# Si recordamos la lección anterior, los objetos definidos dentro del cuerpo de
# una función sólo existen en el instante que dura el ambiente creado durante la
# ejecución de la misma. En la medida en que nos interesa obtener una salida de
# la evaluación de una función, hay que definir qué objetos van a salir de este
# ambiente a la consola, y para ello debemos definir salidas en el cuerpo de la
# función.
# Por defecto, la salida de una función es el resultado de la última evaluación
# contenida en el cuerpo de la misma. Si tomamos como ejemplo la siguiente
# función

f <- function(v) {
  v <- v[!is.na(v)]
  p <- sum(v) / length(v)
  p
}
f(v)

# la salida va a ser el valor de 'p', en este caso el promedio de 'v'.
# El último comando no necesita ser la llamada a un objeto, puede ser una
# operación. Intentemos ver qué pasa si suprimimos la llamada a 'p', y nos que-
# damos sólo con la operación anterior pero sin asignar el resultado.

f <- function(v) {
  v <- v[!is.na(v)]
  sum(v) / length(v)
}
f(v)

# El resultado final es el mismo.
# Veamos ahora qué sucede si asignamos el objeto 'p', pero no lo llamamos al
# final del cuerpo de 'f'.

f <- function(v) {
  v <- v[!is.na(v)]
  p <- sum(v) / length(v)
}
f(v)

# En este caso no hay una salida visible a la consola. Esto no implica que no
# exista una salida, ya que si asignamos la evaluación de la función a un objeto
# en la consola, éste va a ser asignado con esta salida invisible.

a <- f(v)
a

# Una opción que podemos adoptar es interrumpir la ejecución de la función y
# definir con precisión una salida de la misma. Para ello podemos utilizar el
# comando 'return', utilizando como argumento el objeto que queremos en la
# salida.

f <- function(v) {
  v <- v[!is.na(v)]
  p <- sum(v) / length(v)
  if (p > 15) return(15)
  p
}
f(v + 20)

# En este caso, cuando el condicional 'if' es verdadero, la función devuelve el
# valor indicado en este comando, y todo lo que se encuentra posterior al mismo
# no es ejecutado. (El uso de condicionales lo veremos detalladamente en la
# unidad siguiente)

# Otro comando que se puede utilizar es 'invisible', que hace que la salida de
# nuestra función no sea impresa en la consola.

f <- function(v) {
  v <- v[!is.na(v)]
  p <- sum(v) / length(v)
  invisible(p)
}
f(v)

# Esto produce el mismo resultado que la situación en la que el resultado sólo
# era visible si asignábamos la evaluación de la función a un nuevo objeto.

a <- f(v)
a


## Salidas más elaboradas

# A veces las salidas que queremos no se limitan a un vector o matriz, sino que
# necesitamos obtener más de un resultado de nuestra función. La solución más
# sencilla y frecuente es usar listas.

f <- function(v) {
  v <- v[!is.na(v)]
  p <- sum(v) / length(v)
  m <- matrix(rnorm(9, mean = p), 3, 3)
  list(prom = p, matriz = m)
}
f(v)

# Si recordamos de unidades anteriores, en funciones como 'lm', 'summary', etc.,
# se utiliza exactamente este método.


# A modo de cierre y resumen de la presente lección, nos quedan 3 puntos:
# - Definir las salidas es necesario ya que los objetos del ambiente de
#   ejecución de una función no son accesibles desde los ambientes parentales
#   (i.e.: el área de trabajo).
# - En general la salida de una función es la última evaluación del cuerpo de
#   instrucciones, pero esto cambia al usar 'return'.
# - El uso de listas (generalmente nombradas) suele ser una solución útil para
#   obtener salidas elaboradas cuando no nos alcanza con un objeto sencillo.
