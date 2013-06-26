#### break / next

## Comando "break"

# Debido a que es un comando especial, es necesario usar comillas para
# acceder a la ayuda:
?"break"

# Como se puede sospechar por el nombre, break sirve para interrumpir un
# loop. Por ejemplo:
for (i in 1:10) {
  print(i)
  break
}
i 
# Imprime sólo el primer valor, luego es interrumpido.
 
# Combinado con if, sirve para interrumpir en el momento que ocurre
# alguna situación en particular. Por ejemplo, quiero interrumpir el loop
# anterior cuando i llegue al 7
for (i in 1:10) {
  print(i)
  if (i >= 7)
    break
}

## Combinar "break" con "repeat"

# Como se mencionó brevemente, el comando "repeat" es otro tipo de loop que se
# puede usar en R. Es el más simple de todos: se limita a repetir un comando
# hasta que el usuario de una orden de finalización. Una forma de determinar
# la finalización es usando un "break". Usando uno de los ejemplos de la
# lección de "while", la serie que tiende a cero:
# f( n ) = f(n - 1) / n
# f( 0 ) = 5
# Se puede expresar así con "repeat":
f <- 5 # Valor inicial
n <- 0
repeat {
  n <- n + 1 # n es el número de elementos + 1, actua como un contador, el cual
  # comienza en 0
  f <- f / n # f depende del valor del f anterior el cual se relaciona con n
  print(f)
  if(f <= 0.001) # en este caso el límite se lo da el comado if
    break
}

# Esto debería hacer exactamente lo mismo que el ejemplo dado en la lección
# mencionada:
f <- 5 # Valor inicial
n <- 0
while(f > 0.001) { # en este caso el límite lo hace por defecto el comando
                   # while
  n <- n + 1
  f <- f / n
  print(f)
}

## Comando "next"

# El comando "next" también genera una interrupción, pero no en todo el
# loop, si no de la iteración en la que se encuentra el mismo.
?"next"

# Por ejemplo, usando un if + next se puede modificar el ejemplo inicial
# para que se impriman todos los números menos el 4
for (i in 1:10) {
  if (i == 4)
    next
  print(i)
}

# Para imprimir sólo los impares
for (i in 1:10) {
  if (i %% 2 == 0) # (¿qué hace el %%?)
    next
  print(i)
}

# Para no imprimir 4:7
for (i in 1:10) {
  if (i %in% 4:7)
    next
  print(i)
}

# El uso de break y next no es tan extendido, pero es muy útil cuando
# realmente es necesario, evitando que se prolonguen las iteraciones, y
# que se hagan cálculos innecesarios.

