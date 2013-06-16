## Estructuras de control: una introducción

# Hasta ahora en el curso nos hemos limitado a trabajar con secuencias simples 
# de comandos, scripts o funciones que ejecutan de forma "lineal" las 
# instrucciones que les damos. Esto está muy bien, se pueden lograr cosas 
# muy útiles y sofisticadas con este sistema. Sin embargo, aún falta conocer 
# las herramientas más potentes que tiene la programación: las ESTRUCTURAS DE 
# CONTROL.

# Se trata de un conjunto de herramientas que permite manejar de forma mucho 
# más elaborada el flujo de ejecución de nuestros comandos. Permiten realizar 
# cosas como saltear líneas, repetir líneas, hacer bifurcaciones y mucho más 
# (virtualmente, lo que sea que se nos ocurra).

# Tanto las estructuras de control como el uso de funciones (i.e.: unidades 5 
# y 6 del curso) son aspectos fundamentales de la programación, más allá de cuál 
# sea el lenguaje que escojamos para nuestro trabajo. En R podemos acceder a la 
# ayuda de las estructuras de control con el comando:
?Control

# Se trata de comandos especiales, que se utilizan con sintaxis muy diferentes 
# a las de las funciones normales. A sabiendas de que es defectuosa, aceptaremos 
# esta clasificación provisional:

# (1) Loops o bucles:
#  - for, while

# (2) Condicionales:
#  - if, else (e ifelse)

# (3) Otros:
#  - break, next, repeat

# Nos vamos a enfocar en los puntos (1) y (2) en lo que queda del curso, ya que 
# son por lejos los más utilizados en la práctica.

# Para dar una idea de cómo las estructuras de control permiten establecer un 
# flujo "no lineal" de ejecución, utilizaremos la siguiente función de ejemplo 
# (no hace falta entenderla por ahora, pero sí definirla en su sesión de R):

preg <- function() {
  R <- 0 # Preparación
  while (R != 3.1415) { # Inicio del loop (while)
    cat("Escriba el valor de PI hasta el 4to. decimal: ") # Plantea el problema
    R <- readLines(n = 1) # Toma la respuesta del usuario
    R <- as.numeric(R)    # Convierte la respuesta en numeric
    if (R == 3.1415) # Condicional 1
      break  # Corta y termina el loop
    if (R > 3.1415) { # Condicional 2
      cat(" -- ese valor es muy ALTO ... intente de nuevo!\n") # Respuesta 1
    } else {
      cat(" -- ese valor es muy BAJO ... intente de nuevo!\n") # Respuesta 2
    }
  } # Fin del loop (while)
  cat("¡Es correcto!\n") # Respuesta 3 / Salida
} # Fin de la función

# Hagamos una prueba: la siguiente es una copia de mi sesión en R, luego de 
# cargar la función preg... (por supuesto que es más interesante si usted en 
# su casa hace su propio ejemplo):

# > preg()
# Escriba el valor de PI hasta el 4to. decimal: 3.1420
#  -- ese valor es muy ALTO ... intente de nuevo!
# Escriba el valor de PI hasta el 4to. decimal: 3.1410
#  -- ese valor es muy BAJO ... intente de nuevo!
# Escriba el valor de PI hasta el 4to. decimal: 3.1416
#  -- ese valor es muy ALTO ... intente de nuevo!
# Escriba el valor de PI hasta el 4to. decimal: 3.1415
# ¡Es correcto!

# Como se puede ver, la función pide una y otra vez el valor de PI hasta el 4to. 
# decimal y es claro que hasta que el usuario no da la respuesta correcta, la 
# función no deja de pedirla. Pero no sólo es capaz de hacer esto, si no que 
# además le indica al usuario si su valor es demasiado alto o bajo, es decir, 
# es capaz de elegir la retroalimentación correcta según la situación que se 
# le presente. 

# Con sólo mirar el comportamiento de la función podemos intuir los elementos 
# (1) y (2) de nuestra clasificación de las estructuras de control:

# - Hay un ciclo/loop (1), ya que la pregunta se *repite* tantas veces como sea 
#   necesario.

# - Hay "bifurcaciones", es decir, condicionales, ya que el comportamiento es 
#   diferente según ciertas condiciones (la respuesta del usuario).

# Invitamos a ver una figura que ayuda a interpretar el flujo de ejecución de la 
# función preg:

browseURL("https://www.dropbox.com/s/g31jgxknbllqv95/6.1-diagrama.png")

# Una de las cosas más fáciles de identificar en el esquema son los 
# condicionales, destacados como rombos (¿R == PI?, ¿R > PI?). Nos damos 
# cuenta de que son bifurcaciones/condicionales porque tienen dos salidas 
# posibles, asociadas a las palabras "Sí" y "No", lo que en la práctica 
# equivale a los valores lógicos TRUE y FALSE. Luego si observamos bien, 
# veremos que se pueden seguir flujos (flechas) que parten desde la pregunta 
# y que terminan en la misma. Este es el loop de la función preg.

# Pero también nos interesa identificar otros elementos: hay un Inicio, al cual 
# llamaremos "Preparación", hay una Salida y dos retroalimentaciones posibles 
# dentro del loop: ALTO y BAJO. Baje la siguiente imagen para ver una 
# clasificación completa por colores de los elementos de la figura:

browseURL("https://www.dropbox.com/s/t9v5sn2xaqf7v4z/6.1-diagrama-final.png")

# Una de los retos que presenta el aprender a programar con estructuras de 
# control es el poder traducir este flujo dinámico y flexible a un texto 
# estático (el código de la función). Es por esto que el tema de esta unidad 
# es probablemente el más difícil para quienes quieren aprender a programar.

# Veamos ahora cómo se traduce el esquema a los elementos de la función.

# A. El inicio:
# El inicio es lo que vamos a llamar de ahora en adelante la "Preparación". Se 
# trata de comandos que deben ser ejecutados *antes* de que iniciar un loop; 
# son necesarios para que este funcione correctamente. En este caso, la única 
# línea de la preparación es (no ejecutar):
R <- 0
# Más adelante explicaré porqué es necesaria esta línea.

# B. El loop:
# En este caso el loop elegido es while (ver el código abajo). Se indican el 
# inicio y final del loop de forma similar a una función: una llave abre al 
# comienzo y una cierra sobre el final. En el caso del while debe indicarse 
# entre paréntesis una condición necesaria para que se ejecuten los comandos 
# internos del loop. En este caso la condición involucra al objeto R y es por 
# eso que se necesita definir R de antemano en la Preparación (punto A).
# Estas son las líneas del loop (no ejecutar):
while (R != 3.1415) { # Inicio del loop (while)
  cat("Escriba el valor de PI hasta el 4to. decimal: ") # Plantea el problema
  R <- readLines(n = 1) # Toma la respuesta del usuario
  R <- as.numeric(R)    # Convierte la respuesta en numeric
  if (R == 3.1415) # Condicional 1
    break  # Corta y termina el loop
  if (R > 3.1415) { # Condicional 2
    cat(" -- ese valor es muy ALTO ... intente de nuevo!\n") # Respuesta 1
  } else {
    cat(" -- ese valor es muy BAJO ... intente de nuevo!\n") # Respuesta 2
  }
} # Fin del loop (while)

# C. La pregunta al usuario y las posibles respuestas
# Las siguientes líneas se necesitan para que la función le haga la pregunta 
# al usuario y además reciba su respuesta (no ejecutar):
cat("Escriba el valor de PI hasta el 4to. decimal: ") # Plantea el problema
R <- readLines(n = 1) # Toma la respuesta del usuario
R <- as.numeric(R)    # Convierte la respuesta en numeric
# Las líneas siguientes constituyen las tres respuestas posibles para el 
# usuario (no ejecutar):
cat(" -- ese valor es muy ALTO ... intente de nuevo!\n") # Respuesta 1
cat(" -- ese valor es muy BAJO ... intente de nuevo!\n") # Respuesta 2
cat("¡Es correcto!\n") # Respuesta 3 / Salida
# Nótese que las respuestas contemplan los tres casos posibles: que la 
# respuesta del usuario sea igual, mayor o menor al valor esperado. Es 
# importante tener en cuenta todas las posibilidades siempre que se utilizan 
# "bifurcaciones".

# D. Las bifurcaciones/condicionales
# Podemos encontrar los condicionales en las líneas que empiezan con if (no 
# ejecutar):
if (R == 3.1415) # Condicional 1
if (R > 3.1415) { # Condicional 2
  # Respuesta 1
} else {
  # Respuesta 2
}
# En el primer caso, se trata de un condicional que puede terminar el loop y 
# por lo tanto llevar a la salida de la función. Si se da que la respuesta del 
# usuario es exactamente 3.1415, entonces la condición dentro del paréntesis 
# es TRUE, lo que lleva a ejecutar la siguiente línea de código: break. El 
# efecto de ejecutar este comando especial es que se corta el loop, de forma 
# que la función pasa a la siguiente línea, la cual es la respuesta 3, la 
# Salida de la función. De esta forma el primer condicional implica la 
# siguiente bifurcación:
# si - TRUE: se termina la función (el usuario llegó a la respuesta correcta).
# si - FALSE: la respuesta del usuario es incorrecta, por lo que hay que 
#             determinar si es incorrecta por ser muy alto o muy bajo el valor 
#             obtenido.

# En el segundo caso, se trata de un condicional con una estructura más 
# elaborada: no se trata de un if solitario, si no de un par if/else. Este 
# condicional funciona de una manera muy simple:
# - si TRUE: el valor que dió el usuario es muy alto, así que se le da la 
#            respuesta 1 (y en forma más genérica, se evalúan cualesquiera 
#            que sean los comandos incluidos en las llaves de apertura y cierre 
#            asociadas al if).
# - si FALSE: el valor que dió el usuario es muy bajo (ya sabemos que la 
#             respuesta no es correcta (i.e.: R != 3.1415), por que de haberlo 
#             sido, el loop se hubiera cortado antes, en el condicional 1, y 
#             por lo tanto el condicional 2 nunca se habría evaluado), así que 
#             se le da la respuesta 2 (y en forma más genérica, se evalúan 
#             cualesquiera que sean los comandos incluidos en las llaves de 
#             apertura y cierre asociadas al else).

## Resumen:
# El objetivo de este ejercicio es mostrar cómo el uso de las Estructuras de 
# Control implican un cambio fundamental en la forma de concebir la 
# programación, respecto a lo que hemos visto hasta ahora en el curso. Entender 
# y dominar el uso de las mismas es un gran desafío, ya que implica expresar a 
# través de un texto estático (el código) una estructura sumamente dinámica.
# Los componentes más importantes de las estructuras de control son:
# - Los LOOPS (for, while)
# - Los CONDICIONALES (if, if/else)

