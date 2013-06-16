## LOOP WHILE:

# Habiendo visto en la lección anterior el uso y ejemplos del loop for, haremos
# lo propio con el loop 'while', que requiere del cumplimiento de una o más
# condiciones para su ejecución.
# Como su nombre lo indica, 'while' (mientras) es un loop que se ejecutará
# solamente mientras la o las condiciones especificadas se cumplan, interrum-
# piéndose inmediatamente cuando dejen de hacerlo.
# Para ver la ayuda de R al respecto se pueden usar los comandos:
?Control
?"while"


## SINTÁXIS
# "while" es usado cuando el número de iteraciones deseado no es sabido de 
# antemano por el programador, si no que depende de una condición que va a 
# ir cambiando a medida que dichas iteraciones sean ejecutadas. Aquí veremos
# algunos ejemplos sencillos, sin ver necesariamente el caso más general.

# Usualmente un loop while se ve como esto:
while (condición) {
  # comando 1
  # comando 2
  # etc ...
}

# Es una estructura muy similar a la del loop for, por lo que no es difícil de
# entender una vez aprendido el anterior. La gran diferencia es la presencia de
# una "condición".

# Aquí cuando hablamos de una "condición" estamos hablando de valor u operación
# cuyo resultado es de la clase logical. Es decir, se trata de una expresión u
# objeto que es o da como resultado un TRUE o un FALSE.

# Por ejemplo
5 > 8
# es un FALSE, y
10 / 5 == 2
# es un TRUE

# Nótese que en el caso siguiente:
x <- pi < 3
# el objeto x = TRUE, por lo que también es una condición válida para utilizar
# en el paréntesis del while.

# Pero yendo a un ejemplo más concreto, veamos el caso de la "caminata del
# borracho" utilizada en la lección del loop for. En aquel ejemplo nuestro
# borracho caminaba una cantidad de veces designada por el usuario. Supongamos
# ahora que nuestro deseo es detener la caminata sólamente cuando el borracho se
# aleje a una distancia de 10 pasos de la posición inicial (el cero). Con un
# while podemos hacer esto sin problemas:

p <- 0 # inicia en cero
posicion <- p
while (abs(p) < 10) { # abs(p) = valor absoluto de p
  p <- p + sample(c(-1, 1), 1)
  posicion <- c(posicion, p)
}
plot(posicion, type="o", xlab="Iteración", ylab="Posición")

# En general se utilizan operaciones lógicas, como >, >=, ==, etc, para
# caracterizar la condición necesesaria para ejecutar los comandos del loop.
  
## RESUMEN
# El loop 'while' funciona de forma similar a 'for', excepto por el detalle
# de que donde el primero requiere un número de iteraciones, el otro evalúa 
# que se cumplan determinadas condiciones y seguirá ejecutándose mientras lo 
# hagan (a menos que uno interrumpa su ejecución).
# En las siguientes lecciones veremos el uso de condicionales, que complementan
# las funciones de los loops y constituyen las herramientas básicas de 
# programación.
