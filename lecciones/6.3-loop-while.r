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

# Usualmente un loop while se ve como esto (no ejecutar)
while (<condición>) {
  # Aquí
  # instrucciones
}

# Normalmente la condición (la expresión que está entre paréntesis) 
# involucra a algún objeto que es sujeto a cambios en las instrucciones. Veamos 
# un ejemplo sencillo:
x <- 1
while (x < 10) {
  print(x)
  x <- x + 2
}

# Podemos ver que aquí la expresión involucra a x ("x < 10") y que x es 
# modificado en las instrucciones, sumando un +2 en cada iteración. Conviene 
# observar también que aquí en la Preparación se definió x y que esto es 
# fundamental, ya que si no es imposible evaluar la expresión entre paréntesis. 
# Otra observación interesante es que en la consola se imprimieron todos los 
# valores menos el último (11), ¿puede deducir por qué ocurre esto?

# Es importante entonces destacar que la expresión de la condición del loop 
# debe involucrar a una variable que cambie con las iteraciones, y dicha 
# variable debe eventualmente cambiar la condición a FALSE, porque de otra 
# forma es posible generar un loop while que corra indefinidamente. Los 
# siguientes son dos ejemplos (¡no ejecutar!):
# Ej. 1: x no cambia dentro de las instrucciones:
x <- 1
y <- 1
while (x < 10) {
  print(y)
  y <- y + 2
}
# Ej. 2: x cambia pero la condición nunca es FALSE:
x <- 1
while (x > 0) {
  print(x)
  x <- x + 2
}

# Veremos ahora un ejemplo más elaborado: la caminata del borracho.

# La caminata aleatoria o del borracho es un ejemplo típico en cursos de física 
# o de matemática. Sirve para representar procesos aleatorios tales como la 
# deriva génica o el movimiento browniano. En su versión más sencilla, la 
# caminata ocurre sobre una recta (i.e.: tiene sólo 1 dimensión). El hombre 
# alcoholizado se encuentra en una posición inicial (0 para nosotros) y se va 
# a mover de forma aleatoria hacia izquierda o derecha en cada turno. Además la 
# longitud de cada paso es también aleatoria. Entonces para determinar tanto 
# dirección como longitud podemos tomar valores de una distribución normal o 
# gaussiana centrada en cero. La función rnorm nos sirve para este propósito, 
# por ejemplo:
rnorm(100)
# ... los valores pueden ser negativos o positivos y su valor absoluto tiene un 
# desvío estándar de 1. Cada paso del borracho será un número obtenido con esta 
# función.

# Pero la caminata sería infinita a menos que se imponga un límite arbitrario. 
# En nuestra simulación determinaremos que el borracho dejará de caminar una 
# vez que se haya movido una distancia mayor a 10 para cualquiera de las dos 
# direcciones.

# Vamos a tener un valor llamado pos que será la posición instantánea del 
# borracho, y un vector x en el cual vamos a almacenar toda la secuencia de 
# posiciones en un vector llamado x. Sabemos que pos es 0 inicialmente, así 
# que podemos empezar nuestro código con:
pos <- 0

# Para definir x tenemos que saber cuántos elementos debe tener ... ¡pero en 
# verdad no lo sabemos! La caminata es aleatoria, por lo que es imposible saber 
# exactamente cuándo se detendrá. Hay varias formas de solucionar el problema, 
# pero la más sencilla (aunque ineficiente) es:
x <- 0 # ó
x <- pos

# Entonces sólo nos queda hacer el loop:
while (abs(pos) <= 10) {
  pos <- pos + rnorm(1)
  x <- c(x, pos)
}

# Veamos los distintos pasos ...

# 1. La condición:
# Como los límites de la caminata son 10 y -10, nos interesa evaluar si el 
# valor absoluto de pos es el que está por debajo de la distancia elegida (abs 
# es la función valor absoluto, por supuesto).
# 2. El paso del borracho: 
# pos <- pos + rnorm(1), modifica la posición en base a la anterior. Nótese 
# que pos se sobreescribe en este comando.
# 3. Almacenamiento de la nueva posición dentro de x: 
# x <- c(x, pos), aquí estamos "agrandando x", de a un valor cada turno. Sin 
# embargo en verdad estamos cambiando x por un x nuevo, pero eso es un detalle 
# sin importancia.

# Podemos visualizar la caminata con el siguiente comando:
plot(x, xlab = "Nro. de iteración", ylab = "Posición del borracho", 
     type = "o", pch = 20)

# Veamos varios ejemplos ...

# ========= caminata.R: inicio ========
# Preparación:
pos <- 0
x <- pos
# Loop:
while (abs(pos) <= 10) {
  pos <- pos + rnorm(1)
  x <- c(x, pos)
}
plot(x, xlab = "Nro. de iteración", 
     ylab = "Posición del borracho", 
     type = "o", pch = 20)
# ========= caminata.R: fin ===========

# Si guardamos estos comandos en un script llamado "caminata.R", podemos hacer 
# varios intentos y ver como varían las caminatas, tanto en recorrido como en 
# duración:

x11() # En una ventana nueva: conviene maximizarla
op <- par(mfcol = c(3, 2), oma = c(0, 0, 3, 0))
for (i in 1:6)
  source("caminata.R", encoding = "UTF-8") # Sólo funciona si 
mtext("Seis ejemplos en uno", outer = TRUE, cex = 2)
par(op)

# Nota: el código que usamos aquí para la caminata no es la opción más 
# eficiente. Al final de esta lección se muestran otras opciones más adecuadas 
# para modelar este sistema.

## RESUMEN
# - La diferencia fundamental entre while y for es que en el primero no es 
# necesario definir de antemano el número de iteracciones, dependiendo de una 
# condición (una operación lógica) para ejecutar los comandos internos del 
# loop (hasta que de FALSE).
# - Al igual que con for, es muy importante la preparación.
# - También es *fundamental* tener cuidado de no crear un loop infinito, usando 
#   una condición coerente con las variables que están en juego.
  

## Caminata del borracho: opciones más eficientes (de menos a más)

# 1. Definir x de antemano:
pos <- 0
x <- numeric(1e4)
i <- 1
while (abs(pos) <= 10) {
  pos <- pos + rnorm(1)
  x[i] <- pos
  i <- i + 1
}
x <- x[1:(i - 1)]
# Debido a que el estar cambiando de tamaño del x es un proceso muy ineficiente 
# del punto de vista computacional, es mejor crear un x al que le sobren 
# elementos (aquí se estima que diez mil es más que suficiente) para luego 
# eliminar las posiciones que sobren. Nótese que esto requiere definir la 
# variable i en la preparación, la cual debe ser actualizada en cada turno.

# 2. Definir los valores aleatorios de antemano:
pos <- 0
x <- numeric(1e4)
r <- rnorm(1e4)
i <- 1
while (abs(pos) <= 10) {
  pos <- pos + r[i]
  x[i] <- pos
  i <- i + 1
}
x <- x[1:(i - 1)]
# La creación de números aleatorios es un proceso que puede ser lento si se 
# hace de a uno por iteración. Es mejor siempre crear los valores aleatorios 
# (el vector r) en la preparación. De esta forma alcanza con sumar el iésimo 
# valor a pos en cada turno.
# Nuevamente, esta estrategia requiere que se hagan una cantidad sobrada de 
# números aleatorios antes de empezar el loop.

# 3. Eliminar el loop
r <- rnorm(1e4)
x <- cumsum(r)
a <- which(abs(x) > 10)
x <- x[1:a[1]]
# Aquí recurrimos a la función cumsum, que sirve para vectorizar el cálculo 
# (cumsum hace la suma acumulativa de r: x[1] == r[1], x[2] == r[1] + r[2], 
# ... , x[n] == sum(r[1:n]). Luego con which identificamos todas las posiciones 
# de x en las que el borracho se pasó de los límites y luego recortamos x, 
# seleccionando la secuencia desde el x[1] hasta el primer x quese va de los 
# límites.

