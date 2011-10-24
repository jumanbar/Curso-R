## Estructuras de control: el loop 'while'

# Habiendo visto en la lección anterior el uso y ejemplos del loop 'for',
# haremos lo propio con el loop 'while', que requiere del cumplimiento de una
# o más condiciones para su ejecución.
# Como su nombre lo indica, 'while' (mientras) es un loop que se ejecutará
# solamente mientras la o las condiciones especificadas se cumplan, interrum-
# piéndose inmediatamente cuando dejen de hacerlo.
# Para ver la ayuda de R al respecto se pueden usar los comandos:
?Control
?"while" # En este caso hay que poner comillas, ya que es un comando especial


## SINTÁXIS BÁSICA
# "while" es usado cuando el número de iteraciones deseado no es sabido de 
# antemano por el programador, si no que depende de una condición que va a 
# ir cambiando a medida que dichas iteraciones sean ejecutadas.

# El loop de while se escribe, en términos generales, de la siguiente manera
while (condición) comando
# Durante su ejecución, se ejecuta el "comando" repetidamente, siempre que la
# "condición" sea TRUE.

#############################################
# Paréntesis recordatorio: sobre operadores lógicos
# La "condición" es el resultado de una operación lógica, dando como resultado
# los valores TRUE o FALSE.
# Algunas operaciones lógicas sencillas:
3 > 2   # TRUE  (¿tres es mayor que dos?)
3 < 2   # FALSE (¿tres es menor que dos?)
3 == 2  # FALSE (¿tres es igual a dos?)

# Con el caracter '!' se cambia un TRUE por FALSE y viceversa (equivale a 
# multiplicar por -1):
!(3 > 2)
!(3 == 2)
 
# Se pueden juntar varias condiciones con los operadores AND y OR
 
# AND:
condición1 && condición2  # ¿Se cumplen ambas condiciones?
# Da TRUE sí y sólo sí condición1 es TRUE y condición2 es TRUE
# Ej.:
3 > 2 && 4/5 < 7/8   # TRUE
3 > 2 && 4/5 == 7/8  # FALSE
 
# OR:
condición1 || condición2  # ¿Se cumple al menos una condición?
# Da TRUE si al menos una de las dos condiciones es TRUE
3 > 2 || 4/5 < 7/8   # TRUE
3 > 2 || 4/5 == 7/8  # TRUE
1 > 2 || 4/5 == 7/8  # FALSE
# Final del paréntesis.
#############################################

 
# Retomando el uso de 'while', veamos un ejemplo:
x <- 1  # valor inicial...
while (x < 11) {  # La condición es que x sea menor a 11
  print(x)
  x <- x + 1     # En cada iteración, el valor de 'x' se incrementa en +1
}
# Al ejecutar este loop, se imprimen los enteros del 1 al 10
# En este caso es igual a un
for(i in 1:10) print(i)
# Sería más útil si no sabemos de antemano cuántas iteraciones
# necesitamos realizar...
 
## EJEMPLO: UN CASO EN QUE ES NECESARIO
# Veremos una serie sencilla que tiende a 0 cuando 'n' tiende a infinito. La
# misma se puede caracterizar por estas dos ecuaciones: 
# f( n ) = f(n - 1) / n
# f( 0 ) = 5
# Los primeros valores de esta seríe van a ser:
# f(0) = 5
# f(1) = 5
# f(2) = 5 / 2
# f(3) = (5 / 2) / 3
# f(4) = ((5 / 2) / 3) / 4, etc...
# Si queremos calcular todos los valores de la serie que sean mayores a un
# valor determinado, digamos 0.001, entonces 'while' es la herramienta ideal.
# Veamos la implementación:
f <- 5  # Valor inicial
n <- 0  # 'n' será el 'contador', el número de elemento de la serie
while (f > 0.001) {
  n <- n + 1
  f <- f / n
  print(f)
}
f  # ¿A qué número llegó? (¿qué tan cerca del cero?)
n  # ¿Cuántas iteraciones fueron necesarias?
# La cantidad de iteraciones depende del valor inicial de f (probar con 100,
# 1000, etc.) y también del valor predeterminado en la condición (probar con
# 0.0001, 1e-5, 1e-6).

# Un comentario: a diferencia de lo que ocurría con las funciones, que corren
# en un ambiente paralelo al del área de trabajo, los objetos creados dentro de
# los loops, sí pasan a existir dentro de ésta.
# Ejemplo: a nuestro loop anterior le vamos a hacer una modificación
f <- 5  # Le damos valores iniciales nuevamente
n <- 0
while (f > 0.001) {
  n <- n + 1
  f <- f / n
  valores <- c(n, f)  # Devuelve un vector con el valor de 'n' y 'f' en cada
                      # iteración. Al terminar el loop sólo conservará el 
                      # valor final, ya que se redefine cada vez, pero no 
                      # necesita existir previamente en el área de trabajo.
  print(f)
}

valores  # [1] 7.0000000000 0.0009920635

# Un comentario sobre las condiciones.
# Como decíamos antes, pueden escribirse condiciones de modo que se
# cumplan más de una condición simultáneamente o una de varias.
# Como ejemplo, vamos a pedirle al loop anterior que se ejecute en tanto 'f'
# sea mayor a 0.001 y 'n' sea menor a 10 iteraciones.
f <- 5000
n <- 0
while (f > 0.001 && n < 10) {
  n <- n + 1
  f <- f / n
  valores <- c(n, f)
  print(f)
}
# Si lo ejecutamos así, en 7 iteraciones se alcanza un valor menor a 0.001
# Podemos probar con 'f' iniciales de diferentes valores. Con 50, vamos a
# obtener 9 iteraciones, y con 500, vamos a necesitar las 10 de la segunda
# condición. Si probamos con un f inicial de 5000, se va a cortar el loop antes
# de alcanzar un valor de f menor a 0.001.
  
## RESUMEN
# El loop 'while' funciona de forma similar a 'for', excepto por el detalle
# de que donde el primero requiere un número de iteraciones, el otro evalúa 
# que se cumplan determinadas condiciones y seguirá ejecutándose mientras lo 
# hagan (a menos que uno interrumpa su ejecución).
# En las siguientes lecciones veremos el uso de condicionales, que complementan
# las funciones de los loops y constituyen las herramientas básicas de 
# programación.

