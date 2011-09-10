# Loops (for & while):
# Sirven para ejecutar una tarea n veces. Para repetir una rutina, logrando
# en segundos lo que manualmente llevaría horas o días (o sería simplemente
# demasiado).
# Para ver la ayuda de R al respecto se pueden usar los comandos:
?Control
?"while" ## En este caso hay que poner comillas, ya que es un comando especial

## Estructura básica:
while(condición) comando
## Se ejecuta el "comando" repetidamente, siempre que la "condición" sea TRUE
 
#############################################
## Paréntesis: sobre operadores lógicos
## La "condición" es el resultado de una operación lógica, así que debe ser
## TRUE o FALSE
## Algunas operaciones lógicas sencillas:
3 > 2  # TRUE  (¿tres es mayor que dos?)
3 < 2  # FALSE (¿tres es menor que dos?)
3 == 2 # FALSE (¿tres es igual a dos?)
## Con el ! se cambia un TRUE por FALSE y viceversa (equivale a multiplicar
## por -1):
!(3 > 2)
!(3 == 2)
 
## Se pueden juntar varias condiciones con los operadores AND y OR
 
## AND:
condición1 && condición2 ## ¿Se cumplen ambas condiciones?
## Da TRUE sí y sólo sí condición1 es TRUE y condición2 es TRUE
## Ej.:
3 > 2 && 4/5 < 7/8  ## TRUE
3 > 2 && 4/5 == 7/8 ## FALSE
 
## OR:
condición1 || condición2 ## ¿Se cumple al menos una condición?
## Da TRUE si al menos una de las dos condiciones es TRUE
3 > 2 || 4/5 < 7/8  ## TRUE
3 > 2 || 4/5 == 7/8 ## TRUE
1 > 2 || 4/5 == 7/8 ## FALSE
## Final del paréntesis.
#############################################
 
## Retomando el uso de while, veamos un ejemplo:
x <- 1 ## valor inicial...
while(x < 11) { ## La condición es que x sea menor a 11
  print(x)
  x <- x + 1 ## Aumento el valor de x de a 1 por iteración
}
## imprime los enteros del 1 al 10
## En este caso es igual a un
for(i in 1:10) print(i)
## pero es más útil si no sabemos de antemano cuántas iteraciones
## necesitamos realizar...
 
## Ejemplo:
## Esta serie tiende a cero cuando n tiende a infinito
## f( n ) = f(n - 1) / n
## f( 0 ) = 5
## Va a tomar los valores:
## f(0)=5, f(1)=5, f(2)=5/2, f(3)=(5/2)/3, f(4)=((5/2)/3)/4, ...= 5
## Para calcular los sucesivos valores de la serie, llegando hasta un valor
## menor a 0.001 (o sea: f( n ) < 0.001)
f <- 5 ## Valor inicial
n <- 0
while(f > 0.001) {
  n <- n + 1
  f <- f / n
  print(f)
}
f ## ¿A qué número llegó? (¿qué tan cerca del cero?)
n ## ¿Cuántas iteraciones fueron necesarias?
## La cantidad de iteraciones depende del valor inicial de f
## (probar con 100, 1000)
