## Operadores relacionales
 
# En esta lección vamos a introducirnos en el uso de operadores relacionales. 
# Los operadores relacionales son símbolos mediante los cuales podemos realizar
# operaciones cuyos resultados son objetos de la clase 'logical', que pueden
# adoptar los valores 'TRUE' o 'FALSE', según se cumpla o no la relación
# propuesta en la operación. A modo de ejemplo:

5 == 10/2

# En este caso estamos proponiendo la igualdad entre los dos términos,
# la cual es verdadera, por lo que al correr esta expresión en R obtendremos
# como resultado 'TRUE'.

# Este tipo de operaciones resultan herramientas centrales en programación,
# como veremos más adelante en el curso. En esta primera etapa vamos a 
# abordar el uso de operadores relacionales, o comparadores, y de operadores
# lógicos o booleanos.

## Comparadores: <, >, <=, >=, ==, !=
# La operación más sencilla e intuitiva que vamos a realizar, dados dos
# valores u objetos, va a ser la comparación de los mismos. Para realizar
# este tipo de operación contamos con todo un conjunto de operadores,
# denominados comparadores u operadores relacionales. Estos son: <, >, <=,
# >=, == y !=, correspondiendo a las comparaciones: 'menor a', 'mayor a',
# 'menor o igual a', 'mayor o igual a', 'igual a' y 'distinto de'. El uso
# de estos operadores es bastante intuitivo. Como ejemplo:
3 > 2  # TRUE  (¿tres es mayor que dos?)
3 < 2  # FALSE (¿tres es menor que dos?)
3 == 2 # FALSE (¿tres es igual a dos?)
5 == 5 # TRUE (¿cinco es igual a cinco?)
5 != 5 # FALSE (¿cinco es distinto de cinco?)
# Nótese que los objetos a comparar deben estar en el orden correcto,
# particularmente en los que se está planteando una desigualdad.
# En el último ejemplo se intenta comparar dos objetos de diferentes
# clases. Además de los valores, deberemos tener en cuenta este tipo de
# detalles.

## Casos particulares: NA, NULL y NaN
# Estos valores especiales no se pueden usar con estos comparadores. Para
# identificarlos en cambio se usan las funciones is.xxx. Por ejemplo:

is.na(NA)     # TRUE
is.na(5)      # FALSE
5 == NA       # NA

is.null(NULL) # TRUE
is.nan(NaN)   # TRUE

# Nota:
# - NA   : "Not Available", no disponible.
# - NULL : objeto "vacío"
# - NaN  : "Not a Number", no es un número (ej.: log(-1), sqrt(-1))

# En el caso de que las operaciones involucren vectores, los resultados
# dependerán de la entrada de la operación. Ej:
x <- -5:5
x < 2     # En este caso se compara cada elemento de 'x' con el valor 2.
x == 2
y <- 5:-5
x == y    # Compara cada elemento del vector 'x' con el correspondiente de 'y'.
x >= y[1] # Compara cada elemento de 'x' con el primer elemento del vector 'y'.

# El resultado de una operación lógica de este tipo puede tener una aplicación
# inmediata. Un ejemplo de ello es la identificación de los valores de un vector
# que cumplen una determinada condición.
cond <- abs(x) < 2.5
# 'cond' devuelve como 'TRUE' en cuáles posiciones en el vector 'x' se cumple
# la condición de estar ocupadas por cifras cuyo valor absoluto es menor a 2.5.
cond
# Esto que permite usar al objeto denominado "cond" (un vector de clase
# 'logical') para obtener los valores de 'x' que cumplen la condición indicada
# en su asignación. Así:
x[cond] # -2 -1  0  1  2
# es lo mismo que escribir la operación en extenso dentro de los corchetes:
x[x < 2.5 & x > -2.5]
# o
x[abs(x) < 2.5]


## Operadores lógicos o booleanos

# AND, OR, XOR y NOT  son también operadores lógicos y sirven para evaluar y
# combinar varias operaciones lógicas (e.g. comparaciones). Las distintas
# modalidades son: cumplimiento en forma simultánea (AND), alternativa (OR), 
# exclusiva (XOR) y el negativo (NOT). Los símbolos para todos estos 
# operadores son & (&&), | (||), xor y !.

# AND: &, &&
# Dadas dos operaciones lógicas, al plantear una expresión del tipo:
# condición1 && condición2, estaremos evaluando el cumplimiento simultáneo de
# ambas condiciones. Esta expresión da como resultado TRUE sí y sólo sí ambas
# operaciones tienen como resultado TRUE. Ej.:
cond1 <- 3 > 2
cond2 <- 4/5 < 7/8
cond1 & cond2 # TRUE
cond1 && cond2 # TRUE

# Como en este caso cond1 y cond2 son vectores de un sólo elemento, las dos 
# variantes & y && sirven. Sin embargo cuando se trata de vectores logical de 
# varios elementos es necesario utilizar & para realizar la operación elemento
# por elemento, tal como ocurre con los operadores matemáticos o relacionales.

# Por ejemplo, al utilizar los vectores 'x' e 'y' que definimos anteriormente, 
# las comparaciones entre 'x' e 'y' devuelven vectores lógicos de varios 
# elementos:
x >= y
x <= y
# Al aplicar el operador lógico & a ambas comparaciones
x >= y & x <= y 
# obtenemos un vector lógico con valores de TRUE para las posiciones que son 
# TRUE en las dos comparaciones (en este caso, sólo en la posición 6, en la 
# que tanto x como y valen 0).

# NOTA: El uso de & para comparaciones con vectores está sujeto a que las
# condiciones evaluadas tengan la misma longitud. En caso de que no sea así, R 
# recurre al reciclado de valores para completar al vector de menor longitud.

# Cuando usamos incorrectamente && en lugar de & para este tipo de casos, R 
# simplemente evalúa los primeros elementos de los vectores lógicos e ignora 
# el resto. En general && es preferido para el control de flujo, es decir, el 
# uso de los condicionales if o while por ejemplo. Esto lo veremos en una 
# parte posterior del curso.

# OR: |, ||
# Dados dos objetos a y b de la clase logical, al plantear una expresión del 
# tipo a || b, alcanza con que uno de los dos sea TRUE para que el resultado 
# sea TRUE también, sin exigir que lo sean ambos (caso de AND) ni que lo sea uno
# o el otro en forma excluyente (caso de 'xor'). Ejemplo:
3 > 2 || 4/5 < 7/8  # TRUE
3 > 2 || 4/5 == 7/8 # TRUE
1 > 2 || 4/5 == 7/8 # FALSE

# Para el caso de operaciones que involucren vectores, se sigue con | y || el
# mismo criterio que con & y &&:
# | para evaluar pares de valores en los vectores
x > y | x < y
# || para evaluar el primer valor de cada vector.
x > y || x < y


# XOR: xor(a, b)
# Dados a y b vectores lógicos, 'xor' devuelve como resultado TRUE solamente en 
# las posiciones en las que solo uno de los dos contiene un TRUE. Es decir, 
# solo evalúa como verdadero si se cumple en forma exclusiva una de las dos 
# condiciones. Conceptualmente es equivalente a sustraer de los resultados 
# verdaderos de una operación con OR los resultados que sean, además, verdaderos
# en una operación con AND. La sintaxis es, sin embargo, diferente a lo visto
# para AND u OR ya que utiliza una función.
# Ejemplo:
x > 0
x < 3
# Se puede ver que en ambas comparaciones los elementos 7 y 8 son TRUE.
# Aplicando la función 'xor' a estas dos condiciones
xor(x > 0, x < 3)
# veremos que en esas posiciones devuelve FALSE.

# NOT: !a
# Si a es un vector lógico, entonces !a es el opuesto de este vector. Es 
# decir, para todo valor TRUE de a, !a tendrá un valor FALSE y viceversa. Por 
# ejemplo, compare los siguiente vectores lógicos:
x > 0
!(x > 0)

## Resumen
# A modo de resumen esquemático, si consideramos dos vectores lógicos 
# condición1 y condición2 con la siguiente estructura:

# condición1      <---TRUE------><-------FALSE----------><----TRUE---->
# condición2      <-----------FALSE------------><-------TRUE---------->

# los resultados de las operaciones que vimos en esta sección, aplicadas a los
# mismos serían:

# AND '&'         <-------------------FALSE-------------><----TRUE---->

# AND '&&'        <FALSE> (Sólo se evalúan los primeros valores)

# OR '|'          <---TRUE------><----FALSE----><-------TRUE---------->

# OR '||'         <TRUE> (Ídem que con &&)

# XOR             <---TRUE------><----FALSE----><-TRUE--><---FALSE---->

# NOT condición1  <----FALSE----><---------TRUE---------><---FALSE---->
# NOT condición1  <-----------TRUE-------------><-------FALSE--------->


## Adicionalmente, como operadores lógicos, existen las funciones
# especiales: is.na, is.nan e is.null, las que aparecen explicadas
# en las entradas del glosario de NA, NaN y NULL respectivamente
# (particularmente en la entrada de NA).
