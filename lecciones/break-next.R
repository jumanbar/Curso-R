#### break / next

# Comando "break"

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


# El comando "next" también genera una interrupción, pero no de todo el
loop, si no de la iteración en la que se encuentra el mismo.
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
