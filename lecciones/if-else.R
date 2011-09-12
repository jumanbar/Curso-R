# Condicionales (if / else):
# Sirven para ejecutar tareas en caso de que se cumpla una cierta
# condición de interés, o viceversa, evitar que se ejecuten comandos
# si no se dán las condiciones necesarias.
# Para ver la ayuda de R al respecto se pueden usar los comandos:
?Control
?"if"
?"else"

## Estructura básica:
if (condición) comando
## Se ejecuta el comando si la condición es TRUE
 
## Entonces:
if (3 > 2) print('imprime')
if (3 < 2) print('no imprime')
 
## Al igual que vimos antes, se pueden usar las { } para insertar varios
## comandos juntos:
if (3 > 2) {
  print('Es verdadero!')
  print('imprime')
}
 
### Usando if / else
### La combinación de if + else sirve para lograr este flujo:
                        / Sí -----> comando1
Se cumple la condición? |
                        \ No -----> comando2
 
## La estructura básica de if / else es:
if (condición) comando1 else comando2
 ## Cuando se cumple una condición dada, se ejecuta el comando1, en caso
## contrario, se ejecuta el comando2
## Estructura básica, pero usando {}:
if (condición) {
  comando1 ## Si la condición se cumple (TRUE)
} else {
  comando2 ## Si la condición no se cumple (FALSE)
}
 
## Ejemplo: combinacion de un loop con if/else
## Clasificación de números del 1 al 10 en 2 grupos
clasif <- numeric(10) # Acá voy a guardar el resultado
for(i in 1:10) {
  if (i > 5) { ## Se si se cumple, entonces es "grande"
    texto <- paste(i, 'grande')
    print(texto)
    clasif[i] <- texto ## *1
  } else {    ## Si no se cumple, entonces es "chico"
    texto <- paste(i, 'chico')
    print(texto)
    clasif[i] <- texto ## *2
  }
  # clasif[i] <- texto ## Este comando puede sustituir las lineas *1 y *2
}
clasif
 
## Lo mismo se puede hacer con ifelse
## La función ifelse evalúa una condición en todos los elementos de un
## vector. En donde se cumple dicha condición asigna un valor determinado,
## mientras que en donde no se cumple asigna un valor alternativo.
 
## Esquema conceptual (no correr):
ifelse(condición, valor1, valor2)
 
## Ejemplo:
x <- 1:10
clasif <- ifelse(x > 5, 'grande', 'chico')
clasif <- paste(x, clasif)
clasif
## Para este tipo de casos sencillos el ifelse es mucho más rápido y simple
## que usar la combinación for + if + else
 
## Hay casos sin embargo, en que usar loops combinados con if y else es
## la mejor opción. Nótese que es necesario hacer un "anidamiento" de
## bloques de comando...
## Ejemplo: Clasificación en tres grupos
clasif <- numeric(10)
for(i in 1:10) {
  if (i > 5) {
    texto <- paste(i, 'grande')
    print(texto)
    clasif[i] <- texto
  } else { ## Dentro de este "else" se anida una nueva combinación if / else
    if (i > 2) {
      texto <- paste(i, 'mediano')
      print(texto)
      clasif[i] <- texto
    } else {
      texto <- paste(i, 'chico')
      print(texto)
      clasif[i] <- texto
    }
  }
}
clasif
 
## Esquemáticamente, en cada iteración este es el flujo creado:
         / Sí -----> "grande"
(i > 5)? |                    / Sí -----> "mediano"
         \ No -----> (i > 2)? |
                                 \ No -----> "chico"
