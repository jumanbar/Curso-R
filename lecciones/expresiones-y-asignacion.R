#### Expresiones y asignación
 
## Una expresión es un comando ingresado en la línea de comandos, evaluado
## por R, que devuelve un resultado, y es luego descartado.
2 + 3 # una expresión, en este caso R devuelve "[1] 5", el resultado de la
## expresión evaluada.
 
## Una asignación consiste en asignarle un nombre a un objeto que puede ser
## el resultado de una expresión, u otro tipo de objeto.
x <- 1     # asigna el número 1 al nuevo objeto "x"
x <- 2 + 3 # borra el "x" anterior y crea un nuevo "x", cuyo valor es 5.

## Escribiendo en la línea de comandos el nombre del objeto que acabamos de
## generar, devuelve el resultado de la expresión asignada, que debería
## ser "[1] 5"
x

## En R los caracteres (generalmente) utilizados para asignar objetos son
## "<-" y "->". Las flechas que representan estos símbolos indican la
## dirección de la asignación:
x <- 3 + 2
3 + 2 -> x
## Ambos comandos son equivalentes

## Nótese que cuando escribimos:
x <- 2 + 3
## no imprime se imprime el resultado en la consola, sino que R lo asigna a
## un objeto de nombre "x"; si nuestro deseo es que sí se imprmima el valor
## resultante, se puede rodear la expresión con paréntesis:
(x <- 2 + 3)

## El caracter "=" también se puede usar (sólo de derecha a izquierda),
## pero en general es desaconsejado, ya que puede confundirse con la
## asignación de valores dentro de un llamado a una función (esto
## probablemente confunda un poco, pero va a quedar más claro a medida que
## se avance en el curso).
 
#### Comandos incompletos
x <-
2 + 3 # R pone un signo de + en el lugar del prompt, para indicar que hay
      # que completar el comando. si invocamos al objeto x, el resultado va
      # a ser el mismo.
x # "[1] 5"
 
## El nombre del objeto se puede usar adentro de nuevos comandos. por ejemplo:
x + 1
x * 2
y <- x * 4 + 5

## No es raro encontrar el mismo objeto en ambos lados de la asignación:
x <- x + 1

## Alguno tal vez se sienta indignado por este uso desprolijo de números
## y variables, el asunto es no confundir la asignación con un signo de
## igualdad: aquí lo que R hace es simplemente ejecutar 2 operaciones en el
## órden de precedencia correspondiente: primero se ejecuta la suma ("x + 1",
## que debería dar 6) y luego la asignación, lo que equivaldría a "x <- 6"
## si se han seguido exactamente los mismos pasos.
## Es decir, se sustituye el valor viejo de x por uno nuevo

## Las expresiones en R pueden ser mucho más complejas que las que hemos
## mostrado hasta ahora. Muy frecuentemente una expresión va a incluir una
## función de R. Las funciones en R siguen ciertas reglas que son relevantes
## para entender una expresión y una asignación:

## (1)
## Las funciones siempre devuelven un objeto:
exp(1)
# [1] 2.718282
## En este caso lo que devuelve es el número 2.718282. Dado que la
## expresión no incluye ninguna asignación, el número se imprime en la
## consola. Igual que antes, se puede asignar este resultado a un nombre:
z <- exp(1)

## A veces una función devuelve "NULL":
u <- plot(1:5 ^ 5)
u # NULL

## Esto es simplemente un objeto "vacío". Nótese que usando este
## artilugio, no se rompe la regla de que *siempre* las funciones deben
## devolver un objeto.

## (2)
## Las funciones no modifican el objeto que es usado como argumento
## (entrada). Esto implica que para sustituir x por el valor de la
## función evaluada en x, siempre debemos asignar a x la salida de dicha
## función. Por ejemplo, con la función exponencial:
exp(x)      # aquí no estamos modificando x
x
x <- exp(x) # aquí si: lo estamos sustituyendo por la salida de "exp(x)"
x

## Hay más reglas relevantes en la lección "Aspectos básicos", así que
## no se profundizará más aquí.

## Observaciones:
## (1)
## Las expresiones se pueden guardar como objetos, usando la
## función "expression":
e <- expression(1 + 20)
e # "expression(1 + 20)"
## Se puede evaluar dicha expresión usando "eval":
eval(e) # 21

## (2)
## El argumento de una función puede contener una expresión (incluso a
## veces es la única forma en que trabaja la función). Por ejemplo:
h <- exp(v <- 5)
h # exp(5)
v # 5
## Aquí no sólo estamos guardando el resultado de exp(5) en "h", si no
## que también estamos asignándole el valor 5 a "v".

#### Redondeando:
## Las expresiones en R son los bloques con los que se construyen objetos
## y se elaboran instrucciones para obtener lo que deseamos. Una
## expresión es un comando y un conjunto de expresiones componen las
## instrucciones necesarias para que el R realice la tarea que necesitamos,
## es decir, un algoritmo, un programa.


