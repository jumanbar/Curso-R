# Condicionales (if / else):
# Sirven para ejecutar tareas en caso de que se cumpla una cierta condición de
# interés. Nótese que se puede utilizar, y muchas veces se hace, para evitan 
# que se ejecuten comandos si no se dán las condiciones necesarias.
# Para ver la ayuda de R al respecto se pueden usar los comandos:
?Control
?"if"
?"else"

## SINTÁXIS BÁSICA: IF
# "if" ejecuta uno o más comandos si se da la condición entre paréntesis.

if (condición) comando
 
# Entonces:
if (3 > 2) print('imprime') # imprime la palabra que le dimos la instrucción
if (3 < 2) print('no imprime') # no imprime porque no cumple con la condición
 
# Al igual que vimos antes, se pueden usar las { } para insertar varios
# comandos juntos:
if (3 > 2) {
  print('Es verdadero!')
  print('imprime')
}

## SINTÁXIS BÁSICA: IF + ELSE
# La combinación de 'if' + 'else' sirve para establecer tanto los comandos que
# deben ejecutarse al darse una condición determinada, como aquellos que deben
# ejecutarse al *no* darse dicha condición.

# Se puede esquematizar con este diagrama de flujo (no correr):
                        / Sí -----> comando1
Se cumple la condición? |
                        \ No -----> comando2
 
# La estructura básica de if / else es:
if (condición) comando1 else comando2
# Cuando se cumple una condición dada, se ejecuta el comando1, en caso
# contrario, se ejecuta el comando2

# Estructura básica, pero usando {}:
if (condición) {
  comando1 # Si la condición se cumple (TRUE)
} else {
  comando2 # Si la condición no se cumple (FALSE)
}

 
# Ejemplo: combinacion de un loop con if/else
 
# Supongamos que mi objetivo es que se clasifiquen los números del 1 al 10, 
# bajo el criterio: si es mayor que 5 es 'grande', de lo contrario es 'chico'.
# Para eso voy a utilizar un 'for' con el vector 1:10, la variable de 
# iteración será 'i'. Para almacenar los resultados voy a crear un vector
# vacío:
clasif <- numeric(10)
for (i in 1:10) {
  if (i > 5) {
  # Si se cumple que i > 5, entonces es 'i' es 'grande'
    texto <- paste(i, 'grande')
    # 'paste', como su nombre lo dice, sirve para 'pegar' cadenas de
    # caracteres (en este caso toma un número, 'i', y lo convierte en caracter
    # y luego lo pega al texto 'grande'). 
    print(texto)
    clasif[i] <- 'grande' # *1
  } else {
  # Si no se cumple i > 5, es decir que i <= 5, entonces 'i' es 'chico'
    texto <- paste(i, 'chico')
    print(texto)
    clasif[i] <- 'chico' # *2
  }
}
clasif

# Nota: el ejemplo anterior es bastante sencillo, de hecho se puede hacer más
# eficientemente con la función 'ifelse' 


## FUNCIÓN IFELSE
# La función ifelse evalúa una condición en todos los elementos de un
# vector. En donde se cumple dicha condición asigna un valor determinado,
# mientras que en donde no se cumple asigna un valor alternativo.
 
## Esquema conceptual (no correr):
ifelse(condición, valor1, valor2)
 
# El ejemplo anterior se puede hacer en mucho menos líneas:
x <- 1:10
clasif <- ifelse(x > 5, 'grande', 'chico')
clasif <- paste(x, clasif)
clasif
# Para este tipo de casos sencillos el ifelse es mucho más rápido y simple
# que usar la combinación for + if + else


## EJEMPLO: CUANDO IFELSE NO ALCANZA 
# Hay casos sin embargo, en que usar loops combinados con if y else es
# la mejor opción. Nótese que es necesario hacer un "anidamiento" de
# bloques de comando...
# Ejemplo: Clasificación en tres grupos
clasif <- numeric(10)
for (i in 1:10) {
  if (i > 5) {
    texto <- paste(i, 'grande')
    print(texto)
    clasif[i] <- 'grande'
  } else { # Dentro de este "else" se anida una nueva combinación if / else
    if (i > 2) {
      texto <- paste(i, 'mediano')
      print(texto)
      clasif[i] <- 'mediano'
    } else {
      texto <- paste(i, 'chico')
      print(texto)
      clasif[i] <- 'chico'
    }
  }
}
clasif
 
# Esquemáticamente, en cada iteración este es el flujo creado (no correr):
         / Sí -----> "grande"
(i > 5)? |                    / Sí -----> "mediano"
         \ No -----> (i > 2)? |
                              \ No -----> "chico"


# RESUMEN
# El uso de condicionales es uno de los pilares de programación, ya que 
# permite establecer la forma en que el código va a trabajar bajo distintas
# condiciones. Esto es fundamental para poder tener cierta flexibilidad.
# En general estos comandos son muy útiles cuando queremos separar datos 
# frente a una condicion que nosotros le marcamos, como por ejemplo si están
# encima o debajo de un valor umbral, o si pertenecen a una categoría
# determinada. De esta forma se puede ajustar los comandos que aplicamos para 
# cada caso. 

