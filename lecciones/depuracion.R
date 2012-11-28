#### Depuración de funciones o "debugging"
 
# Es inevitable tener errores al programar. En inglés el término para
# referirse a un error de programación es "bug"
# (http://es.wikipedia.org/wiki/Error_de_software), y por lo tanto, la
# expresión para la tarea de eliminar estos erorres es "debug"; en español
# "depurar"
 
# En R se puede usar la función debug para inspeccionar el código interno
# de una función en el momento mismo en que se ejecuta, pero hay métodos más
# primitivos / sofisticados que también pueden ser de utilidad.
 
# Como ejemplo, vamos a ver una función sencilla con errores hechos a
# propósito. Vamos a ver algunos tipos de errores comunes y fáciles de
# detectar, y luego vamos a meternos de lleno en 3 métodos más elaborados de
# depuración.

# La función que usaremos se encuentra se en el archivo 'davuelta.R'. Una vez
# abierto el archivo van a encontrar estas líneas:

## Inicio ##
davuelta <- function(x) {
# Esta funcion sirve para "dar vuelta" un vector: cambia la primer mitad de
# sus elementos por la segunda. Ej:
# si x = 1 2 3 4
# el resultado debe ser:
# 3 4 1 2

  len <- length(x)
  if(len %% 2 != 0)
    stop('x no tienen un número par de elementos')
    # La función sólo funciona con vectores con longitud par. Este es el 
    # mensaje de error que va a mostrar si esta condición no se cumple.
  mitad <- len / 2
  x1  <- x[1:mitad]
  x2  <- x[mitad:Len]
  out <- (x2, x1)
  return(out)
}
## Fin ##

# Lo primero que debemos hacer es entender bien cual es el objetivo de la
# función y qué estrategia se toma para lograrlo. En este caso la función
# tiene una pequeña descripción y un ejemplo para entender qué es lo que
# hace, incluida en el código mismo. La idea del algoritmo utilizado se
# esquematiza en el archivo "diagrama-davuelta.pdf", para ayudar a entender
# los pasos seguidos por la función.

# Lo primero que vamos a hacer es cargar la función a nuestra sesión de R, lo
# cual se puede hacer copiando y pegando las líneas anteriores o usando el
# comando source para que R lea las líneas del archivo:
source('davuelta.R') # suponiendo que está en el directorio de trabajo actual.
# En caso de tener el archivo abierto en RStudio se puede usar la combinación
# "Ctrl + Shift + s" para hacer lo mismo.

# Lo primero que van ver es un mensaje de error:
# Error in source("~/Cursos/R/Curso-R/lecciones/davuelta.R") : 
#   ~/Cursos/R/Curso-R/lecciones/davuelta.R:16:13: unexpected ','
# 15:   x2  <- x[mitad:Len]
# 16:   out <- (x2,
#                 ^

# El mensaje de error nos indica el momento exacto en que R no pudo
# interpretar los comandos escritos en el archivo. En este caso nos dice que
# hay una coma inesperada en la línea 16 del archivo, usando un "^" para
# indicar exactamente en dónde está.

# Este es un caso de error en la definición misma de la función: R ni
# siquiera puede terminar de cargar la función en nuestra área de trabajo,
# por lo que aún "no existe":
exists('davuelta') # FALSE

# En este caso no es difícil darse cuenta de lo que sucede: quien escribió la
# función olvidó poner "c" antes de comenzar el paréntesis, así que debemos
# arreglar el error:
# 16:   out <- c(x2, x1)
#              ^

# Errores como este son muy comunes, sobre todo si falta un paréntesis, un
# operador, una coma, una llave...

# Ahora probamos cargar de vuelta el archivo (habiendo guardado previamente):
source('davuelta.R')

# Si se hizo correctamente, esta vez no deberían haber errores al ejecutar
# "source". Ahora podemos usar un ejemplo para ver si la función hace lo que
# queremos correctamente. Sabemos que si
x <- 1:7
davuelta(x) # Debería dar nuestro mensaje de error.

# Pero sí
x <- 1:6
# entonces el resultado debería ser: 4 5 6 1 2 3

# Probemos:
davuelta(x)
# Error in davuelta(x) : object 'Len' not found

# Otro mensaje de error, esta vez no tan fácil de descifrar... Cuando aparece
# un mensaje de este tipo, es decir que no encuentra un objeto o una función, lo
# más probable es que el objeto este (1) mal escrito o (2) nunca haya sido
# definido apropiadamente.

# En este caso es sencillo: "len" existe, pero es con minúsculas, por eso no
# reconoce la existencia de "Len". Buscamos en qué parte del script aparece
# "Len" (Ctrl+f en RStudio sirve para buscar palabras) y lo cambiamos por
# "len":
# 15:   x2  <- x[mitad:len]
#                      ^

# Vamos a guardar y cargar el archivo:
source('davuelta.R') # No debería dar mensaje de error
davuelta(x)
# [1] 3 4 5 6 1 2 3

# ¡Excelente! ¡un resultado que parece razonable! ... sin embargo no es
# exactamente lo que esperábamos. Veamos, debería dar:
# [1] 4 5 6 1 2 3
# Y sin embargo da:
# [1] 3 4 5 6 1 2 3

# Podemos ver que sobra un 3 al principio del vector... qué está pasando?

# Para descubrirlo vamos a mostrar tres métodos posibles, los cuales son
# sumamente efectivos si se utilizan correctamente: (1) Imprimir en consola,
# (2) usar el depurador de R o (3) usar "browser". El orden en que se van a
# ver indica una creciente sofisticación y, en general, un aumento en la
# eficiencia de los métodos para hallar errores. En la práctica no es la idea
# usar los tres métodos en cada ocasión, la elección del método correcto en
# general depende del tipo de error.

# Los tres métodos requieren de una cierta intuición, entendimiento del
# código de la función que queremos arreglar, práctica y paciencia.

## MÉTODO 1: IMPRIMIR EN LA CONSOLA

# Este método es el más simple. Se trata cambiar la función para que imprima
# en la consola ciertos objetos que nosotros consideramos son clave para
# hallar el error.

# En nuestro caso, supongamos que x1 y x2 son los objetos que nos interesa
# mirar. Debido a que sólo existen dentro de la función, no tiene sentido
# escribir x1 o x2 en la consola:
x1
# Error: object 'x1' not found

# Por lo tanto, vamos a agregar estas líneas en el código de la función,
# luego de la línea 15:
cat("x1:\n")
print(x1)
cat("x2:\n")
print(x2)
# Nota: tanto "cat" como "print" sirven para imprimir cosas en la pantalla,
# sin embargo tienen algunas diferencias sutiles (que no vamos a profundizar
# aquí). El caracter especial "\n" indica el fin de línea. Es posible que en
# windows sea más conveniente usar "\r".

# Volviendo a cargar el archivo y ejecutando la función, vamos a ver lo
# siguiente:
source('davuelta.R')
davuelta(x)
# x1:
# [1] 1 2 3
# x2:
# [1] 3 4 5 6
# [1] 3 4 5 6 1 2 3

# Lo que estamos viendo es justamente los vectores x1, x2 y la salida (en la 
# última línea) de la función tal como está definida en este momento. Se puede 
# notar que el vector que no es lo esperado es x2, ya que tiene cuatro 
# elementos, siendo el primero (3) el que sobra. Esto nos indica que el error 
# debe estar en la construcción de x2.

# Hasta aquí llegamos con la estrategia de imprimir en la consola. Como se
# puede ver, este método sólo nos puede decir el resultado de pasos
# intermedios de nuestro código, pero no nos permite jugar con los objetos
# mismos, lo que sí es posible con el siguiente método: "debug"

## MÉTODO 2: DEBUG

# Primero que nada vamos a borrar las 4 líneas de código que habíamos
# agregado anteriormente.

# La función debug sirve para indicar a R que cierta función debe ser
# depurada. En la jerga informática se dice que se coloca una "bandera"
# ("flag") a la función en cuestión. Veamos:
debug(davuelta)

# Ahora, si corremos
davuelta(x)
# Vamos a ver algo así:

# debugging in: davuelta(x)
# debug at ~/Cursos/R/Curso-R/lecciones/davuelta.R#1: {
#     len <- length(x)
#     if (len%%2 != 0) 
#         stop("x no tienen un número par de elementos")
#     mitad <- len/2
#     x1 <- x[1:mitad]
#     x2 <- x[mitad:len]
#     out <- c(x2, x1)
#     return(out)
# }
# Browse[2]>

# Lo que R nos muestra es (1) el nombre de la función que estamos depurando
# ("debugging"), (2) el número de línea en la que nos encontramos y (3) un
# command prompt especial: "Browse[2]>"

# El número de línea se indica junto con el nombre del archivo:
# "debug at davuelta.R#1:"

# En este caso, debido a que existe un bloque de comandos marcados por las
# llaves de inicio y fin de la función, el R nos muestra todo el código de la
# misma (nótese que se excluyen los comentarios).

# En este momento estamos "adentro" de la función. Cada vez que apretemos
# enter se va a correr una nueva línea de código de la función. Por ejemplo
# si apretamos enter 1 vez, vamos a ver esto:

# debug at ~/Cursos/R/Curso-R/lecciones/davuelta.R#8: len <- length(x)
# Browse[2]>

# La primer línea nos indica cuál va a ser el siguiente paso a ejecutar:
len <- length(x)
# Esta expresión sólo se va a ejecutar cuando el usuario lo permita,
# apretando enter.

# Nótese el comando se corresponde con la línea 8 de nuestro archivo, como lo
# indica la consola.

# Ahora vamos a apretar enter 5 veces, de forma que la siguiente línea sea la
# 16, por lo que en la consola debería verse:
# debug at ~/Cursos/R/Curso-R/lecciones/davuelta.R#16: out <- c(x2, x1)

# En este momento podemos jugar a nuestras anchas con los objetos presentes
# dentro de la función, a saber:
ls()
# [1] "len"   "mitad" "x"     "x1"    "x2"
x2
# [1] 3 4 5 6

# Hay que tener en cuenta que hay ciertos comandos especiales que sólo existen
# cuando estamos depurando. Uno de ellos es "Q", que sirve para salir de la
# depuración y volver a la sesión normal de R. Otros comandos se pueden ver
# en la ayuda:
?browser

# Ya habíamos visto que el error tiene que ver con la forma en que se
# construye x2. Podemos ver que x2 es creado en la línea 15:
x2 <- x[mitad:len]

# Como tal vez ya lo hayan deducido, el problema está en los índices:
mitad:len
# [1] 3 4 5 6
# Aquí deberíamos tener los elementos 4 5 6 del vector, nos sobra el primero.
# Una solución es usar "mitad + 1" en lugar de "mitad" sólo. Podemos jugar
# con distintas formas de escribirlo ahora, para determinar cuál es la correcta:
mitad + 1:len   # No parece ser la solución...
# [1] 4 5 6 7 8 9
(mitad + 1):len # Ahora sí!
[1] 4 5 6
# Entonces podemos probar con:
x2 <- x[(mitad + 1):len]

# Si damos enter se va a ejecutar la línea 16:
out <- c(x2, x1)
# Podemos examinar "out" para ver si es el resultado correcto:
out
# [1] 4 5 6 1 2 3

# Entonces ya sabemos que es lo que hay que hacer. Pero antes de hacerlo,
# vamos a pasar al tercer método. Suponiendo que ya terminó la depuración,
# se debe quitar la "bandera" a la función, de dos maneras posibles:
undebug(davuelta)
# o cargando nuevamente el archivo con "source":
source('davuelta.R')
# Esto define nuevamente la función y borra la versión anterior, incluyendo
# la bandera de depurar.

# MÉTODO 3: BROWSER

# Éste método es prácticamente igual al debug. Sin embargo tiene la ventaja
# de que nos permite "entrar" en la función en el momento justo que ocurre
# algo "indebido". Este método se vale de dos funciones: el comando especial
# "if" (sobre el que profundizaremos más adelante en el siguiente tema del
# curso) y la función "browser"

# Ahora lo que vamos a hacer es agregar las siguientes líneas al archivo
# "davuelta.R" (luego de la línea 16):
if (length(out) > len)
  browser()

# Ahora cargamos el archivo y ejecutamos la función:
source('davuelta')
davuelta(x)

# En la consola aparece lo siguiente:
# Called from: davuelta(x)
# Browse[1]>

# Qué ocurrió?
# La longitud de out es 7, mayor que len que tiene 6 elementos, por lo tanto
# se cumplió la condición dentro del paréntesis del "if". Esto permitió que
# se ejecutara el comando "browser()", cuyo efecto es meternos dentro de la
# función, de forma similiar a lo que hace "debug", pero esta vez no estamos
# al inicio, si no en el momento preciso en que el comando es ejecutado. Esto
# quiere decir que todos los pasos anteriores de la función ya se hicieron, lo
# que se puede corroborar con un ls:
ls()
# [1] "len"   "mitad" "out"   "x"     "x1"    "x2" 

# Todas las reglas que aplicaban para el uso de "debug" aplican ahora, con una
# excepción: para ir paso a paso primero hay que usar el comando especial "n"
# (una sola vez, queda en efecto hasta que se ejecute "Q" para salir).

# Cuál es la diferencia con el método anterior? Que podemos "entrar" a la
# función en el momento preciso en que ocurre un comportamiento inesperado.
# Muchas veces el momento en que este comportamiento ocurre es verdaderamente
# impredecible, sobre todo si estamos trabajando con números aleatorios y/o
# con repeticiones de rutinas (loops, lo veremos más adelante).

# Para aprovechar este método es necesario pensar en una condición adecuada
# al problema que tenemos en frente. En el caso anterior, la condición se
# deriva de el hecho que teníamos un elemento de sobra. En todo caso y al
# igual que con los métodos anteriores, la habilidad del programador es clave
# en la eficiencia de este método y esta sólo mejora con la práctica.

# El último paso para corregir una función es verificar que anda. Para esto
# la tenemos que someter a pruebas exigentes, de forma que estemos seguros de
# que realmente hace lo que nosotros necesitamos que haga. En nuestro caso lo
# primero que debemos hacer es cambiar la línea 15 del archivo por esta:
  x2 <- x[(mitad + 1):len]
# Luego guardamos y cargamos la función:
source('davuelta.R')
# La probamos con varios objetos:
davuelta(x)
davuelta(-3:3)         # debería dar error
davuelta(-3:4)
davuelta(letters[1:6]) # con caracteres debería andar también


## FINALIZANDO
# Estas funciones nos van a venir bien cuando estemos programando, por razones
# obvias. Es bueno recordar que existen y saber cómo funcionan, ya que muchas
# veces un error sencillo nos puede estar complicando la vida mucho rato y no
# perdemos demasiado tiempo buscándolo si conocemos las herramientas adecuadas.

