## Operadores lógicos
 
# En esta sección vamos a introducirnos en el uso de operadores lógicos.
# Los operadores lógicos son símbolos mediante los cuales podemos re-
# alizar operaciones cuyos resultados son objetos de la clase 'logical',
# de tipo Booleano, que puede adoptar los valores 'TRUE' o 'FALSE',
# según se cumpla o no la relación propuesta en la expresión. A modo de
# ejemplo:
5 == 10/2
# En este caso estamos proponiendo la igualdad entre los dos términos,
# la cual es verdadera.
# Este tipo de operaciones resultan herramientas centrales en programa-
# ción, como veremos más adelante en el curso. En esta primera etapa
# vamos a abordar el uso de operadores relacionales, o comparadores,
# y de operadores Booleanos.

## COMPARADORES
# La operación más sencilla e intuitiva que vamos a realizar, dados dos
# valores u objetos, va a ser la comparación de los mismos. Para ralizar
# este tipo de operación contamos con todo un conjunto de operadores,
# denominados comparadores u operadores relacionales. Estos son: <, >,
# <=, >=, == y !=, correspondiendo a las comparaciones: 'menor a',
# 'mayor a', 'menor o igual a', 'mayor o igual a', 'igual a' y 'distinto
# de'. El uso de estos operadores es bastante intuitivo. Como ejemplo:
3 > 2  # TRUE  (¿tres es mayor que dos?)
3 < 2  # FALSE (¿tres es menor que dos?)
3 == 2 # FALSE (¿tres es igual a dos?)
5 == 5 # TRUE (¿cinco es igual a cinco?)
5 != 5 # FALSE (¿cinco es distinto de cinco?)
1 == "string" # FALSE
# Nótese que los objetos a comparar deben estar en el orden correcto,
# particularmente en los que se está planteando una desigualdad
# En el último ejemplo se intenta comparar dos objetos de diferentes
# clases. Además de los valores, deberemos tener en cuenta est tipo de
# detalles.

# En el caso de que las operaciones involucren vectores, los resultados
# dependerán de la entrada de la operación. Ej:
x <- -5:5
x < 2 # Compara cada elemento de 'x' con el valor '2'
x == 2
y <- 5:-5
x == y # Compara cada elemento de 'x' con el correspondiente de 'y'
x >= y[1] # Compara cada elemento de 'x' con el primer elemento de 'y'

# El resultado de una operación lógica de este tipo puede tener una
# aplicación inmediata, como forma de identificar los valores que cum-
# plen una determinada condición. Por ejemplo:
(z <- abs(x) < 2.5)
# 'z' devuelve como 'TRUE' cuáles de las posiciones en el vector 'x'
# están ocupadas por cifras cuyo valor absoluto es menor a 2.5, lo que
# permite usar a "z" (clase logical) para obtener los valores de 'x'
# que cumplen esta condición. Así:
x[z] # -2 -1  0  1  2
# es lo mismo que escribir:
x[x < 2.5 & x > -2.5]
# o
x[abs(x) < 2.5]

## OPERADORES LÓGICOS O BOOLEANOS
# AND, OR (&, &&, | y ||) y XOR son operadores en los que tanto la
# entrada como la salida son vectores de clase 'logical'. Estos opera-
# dores nos sirven para evaluar si se cumplen más de una operación lógica
# (e.g. comparaciones) en forma simultánea (AND), alternativa (OR) o
# exclusiva (XOR).
 
# AND: &, &&
# Dadas dos operaciones lógicas, al plantear una expresión del tipo:
# condición1 && condición2, estaremos evaluando el cumplimiento simul-
# táneo de ambas condiciones. Esta expresión da como resultado TRUE sí
# y sólo sí ambas operaciones tienen como resultado TRUE. Ej.:
cond1 <- 3 > 2
cond2 <- 4/5 < 7/8
cond1 & cond2 # TRUE
cond1 && cond2 # TRUE
# En este caso, como en cada una de las operaciones estamos comparando
# un valor numérico contra otro, el uso de & y && devuelven el mismo
# resultado. Estos operadores presentan diferencias, sin embargo, al
# ser utilizados en operaciones que involucren vectores. El uso de &
# nos permite evaluar el cumplimiento de las condiciones para cada par
# de valores. Ej:
x >= y # FALSE FALSE FALSE FALSE FALSE TRUE TRUE TRUE TRUE TRUE TRUE
x <= y # TRUE TRUE TRUE TRUE TRUE TRUE FALSE FALSE FALSE FALSE FALSE
x >= y & x <= y # Evalúa los pares de valores simultáneamente >= y <=,
# devolviendo TRUE sólo en la posición en que los vectores 'x' e 'y'
# presentan ambos el valor '0'.
# El uso de & para comparaciones con vectores está sujeto a que las
# condiciones evaluadas tengan la misma longitud.

# Si, en cambio, utilizáramos &&, estaríamos evaluando el cumplimiento
# de las condiciones para el primer valor de cada vector. Por ejemplo:
x >= y && x <= y # FALSE
x < 0 && y > 0 # TRUE

# OR: |, ||
# Dadas dos operaciones lógicas, al planter una expresión del tipo:
# condición1 || condición2, estaremos evaluando el cumplimiento de
# al menos una de las condiciones planteadas. Estas expresiones
# devuelven como resultado TRUE si al menos una de las dos condiciones
# es TRUE. Ej.:
3 > 2 || 4/5 < 7/8  # TRUE
3 > 2 || 4/5 == 7/8 # TRUE
1 > 2 || 4/5 == 7/8 # FALSE

# Para el caso de operaciones que involucren vectores, se sigue con
# | y || el mismo criterio que con & y &&.
 
# XOR: xor(condiciones1, condiciones2)
# Este operador devuelve como resultado TRUE sólamente en los casos en
# que se cumple en forma exclusiva una condición O la otra, resultando
# en FALSE aquellos casos en que se cumplen ambas simultáneamente.
# Conceptualmente es equivalente a sustraer de los resultados verdaderos
# de una operación con OR los resultados que sean, además, verdaderos
# en una operación con AND.
# Ejemplo:
x > 0
x < 3
# Se puede ver que en ambas comparaciones los elementos 7 y 8 son TRUE
# Precisamente es en estos casos que 'xor' da negativo (FALSE) 
xor(x > 0, x < 3)

# Finalmente, si representamos en forma esquemática el cumplimiento de
# un par de condiciones:

# condición1  <---TRUE------><-------FALSE----------><----TRUE---->
# condición2  <-----------FALSE------------><-------TRUE---------->

# los resultados de las operaciones que vimos en esta sección serían:

# AND '&'     <-------------------FALSE-------------><----TRUE---->

# AND '&&'    <FALSE> (Sólo se evalúa el primer valor de cada condición)

# OR '|'      <---TRUE------><----FALSE----><-------TRUE---------->

# OR '||'     <TRUE> (Sólo se evalúa el primer valor de cada condición)

# xor         <---TRUE------><----FALSE----><-TRUE--><---FALSE---->


## Adicionalmente, como operadores lógicos, existen las funciones
# especiales: is.na, is.nan e is.null, las que aparecen explicadas
# en las entradas del glosario de NA, NaN y NULL respectivamente
# (particularmente en la entrada de NA).