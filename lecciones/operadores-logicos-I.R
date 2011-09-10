#### Comparadores y operadores lógicos
## Muchas veces nos interesa comparar valores, para esto existen los 
## operadores lógicos: <, >, <=, >=, ==, !=, !, &, &&, |, ||, xor.
## Adicionalmente están las funciones especiales: is.na, is.nan e is.null.
## Al usar estos operadores obtenemos objetos de la clase logical.
 
## Comparadores: <, >, <=, >=, ==, !=
## Los simbolos se corresponden con las comparaciones: menor a,
## mayor a, menor o igual a, mayor o igual a, igual a, distinto de.
## El uso de estos operadores es bastante intuitivo:
## Algunas operaciones lógicas sencillas:
3 > 2  # TRUE  (¿tres es mayor que dos?)
3 < 2  # FALSE (¿tres es menor que dos?)
3 == 2 # FALSE (¿tres es igual a dos?)
5 == 5 # TRUE
5 != 5 # FALSE (¿dos es distinto de dos?)
1 == "string" # FALSE
## Nótese que los objetos a comparar deben estar en el orden correcto
 
## AND y OR (&, && + |, ||) son operadores en los que tanto la entrada
## como la salida son vectores logical.
 
## AND: &, &&
condición1 && condición2 ## ¿Se cumplen ambas condiciones?
## Da TRUE sí y sólo sí condición1 es TRUE y condición2 es TRUE
## Ej.:
3 > 2 && 4/5 < 7/8  ## TRUE
3 > 2 && 4/5 == 7/8 ## FALSE
 
## A diferencia de &&, si usamos & podemos usar el AND para varios valores.
## Por ejemplo:
x <- -5:5
(cond1 <- x > -2.5)
# [1] FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
(cond2 <- x < 2.5)
# [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE
(y <- cond1 & cond2)
# [1] FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE
## cond1 y cond2 deben tener la misma longitud para que se pueda usar
## el operador $ (ya que hace comparaciones elemento a elemento).
## Nótese que podría haber hecho:
(y <- abs(x) < 2.5)
 
## En todo caso, ahora puedo usar "y" (clase logical) para obtener
## los valores de "x" que cumplen con la condición dada, así:
x[y]
# [1] -2 -1  0  1  2
## O más directamente:
x[x < 2.5 & x > -2.5]
# o
x[abs(x) < 2.5]
 
 
## OR: |, ||
condición1 || condición2 ## ¿Se cumple al menos una condición?
## Da TRUE si al menos una de las dos condiciones es TRUE
3 > 2 || 4/5 < 7/8  ## TRUE
3 > 2 || 4/5 == 7/8 ## TRUE
1 > 2 || 4/5 == 7/8 ## FALSE
 
## Para el caso de | simple, se sigue el mismo criterio que con &
## comparación elemento a elemento).
 
## XOR: xor(condiciones1, condiciones2)
## Es un OR elemento a elemento pero sólo da TRUE en los elementos no
## compartidos entre x e y (los vectores comparados).
## Ejemplo:
x <- -5:5
x > 0
x < 3
## Se puede ver que en ambas comparaciones los elementos 7 y 8 son TRUE
## Presisamente es en estos casos ("intersecciones") que xor da negativo (FALSE) 
xor(x > 0, x < 3)
 
# Esquemáticamente:	
# condición1	<---TRUE------><-------FALSE----------><----TRUE---->
# condición2	<-----------FALSE------------><-------TRUE---------->
# xor           <---TRUE------><----FALSE----><-TRUE--><---FALSE---->
 
## El uso de las funciones especiales is.na, is.nan, is.null está explicado
## en las entradas del glosario de NA, NaN y NULL respectivamente
## (particularmente en la entrada de NA).
