### Comando "break"
?"break"
## Interrumpe un loop.
## Ejemplo:
for(i in 1:10) {
  print(i)
  break
}
i
## Imprime sólo el primer valor
 
## Combinado con if, sirve para interrumpir en el momento que ocurre
## cierta situación:
## Ejemplo:
## Quiero interrumpirlo cuando i llegue al 7
for(i in 1:10) {
  print(i)
  if(i >= 7) break
}
 
### Comando "next"
?"next"
## Interrumpe la iteración del loop y pasa a la siguiente
for(i in 1:10) {
  if(i == 4) next
  print(i)
}
## Se saltea el número 4
 
for(i in 1:10) {
  if(i %% 2 == 0) next
  print(i)
}
## Se saltea los pares... (¿qué hace el %%?)
