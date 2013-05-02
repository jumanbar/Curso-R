## Operadores lógicos, continuación.
 
# Continuando con las lecciones sobre operadores lógicos, en esta ocasión se
# muestran breves ejemplos de las funciones: 'any', 'all', 'all.equal',
# 'identical' y el operador '%in%'. Todas estas funciones sirven para comparar
# objetos e identificar similitudes. Todas menos '%in%' devuelven un único valor 
# lógico, aunque 'all.equal' es un poco diferente.
 
# ANY
# Dadas una serie de operaciones condicionales, esta función evalúa si al menos
# una de ellas se cumple. Es una suerte de extensión del operador OR, pero
# puede aplicarse a tantas condiciones como se quiera. La sintaxis de esta
# función es similar a la que vimos anteriormente para 'xor', en el sentido de
# que se ejecuta como una función y no como un operador.
any(condición1, condición2, ..., condiciónN)
# ¿Al menos una de estas condiciones verdadera?
 
# Ejemplos:
any(5 > 8) # FALSE
any(5 > 8, 4 == 5) # FALSE
any(5 > 8, 4 == 5, 0.1 < 0.12) # TRUE; la última sí es verdadera

# Aplicada a vectores, esta función sirve para evaluar si alguno de sus elemen-
# tos cumple con la condición indicada.
set.seed(3)    # Vamos a generar un vector de 10 elementos de una
x <- rnorm(10) # distribución normal o gaussiana
                            
any(x > 1.96) # ¿Algún elemento de 'x' es mayor a 1.96? FALSE
any(x > 1.2)  # ¿Algún elemento de 'x' es mayor a 1.2? TRUE
 

# ALL
# Esta función evalúa que se cumplan todas las condiciones evaluadas, como una
# extensión del operador AND. Funciona en forma similar al anterior.
all(condición1, condición2, ..., condiciónN)
# ¿Son todas estas condiciones verdaderas?
 
# Ejemplos:
all(5 > 1) # TRUE
all(5 > 1, 4 == 4) # TRUE
all(5 > 1, 4 == 4, 0.12 < 0.1) # FALSE; la última es falsa


# IDENTICAL
# Este comando funciona en forma diferente a los anteriores, ya que no evalúa
# el cumplimiento de condiciones (vectores lógicos). En este caso se evalúa si
# dos o más objetos son idénticos. La sintaxis es (no correr):
identical(objeto1, objeto2)
# ¿Son exactamente iguales estos objetos?)
set.seed(0)
x <- rnorm(10)
y <- rnorm(10)
identical(x, y) # FALSE
# "y" es distinto de "x"
set.seed(0)
y <- rnorm(10)
identical(x, y) # TRUE

# Lo interesante de 'identical' es que puede evaluar objetos de cualquier 
# clase, sin importar la sofisticación de los mismos.

# ALL.EQUAL
# Esta función es similar a 'identical', pero busca cuasi equivalencias. La
# sintaxis es también similar a la de 'identical'.
all.equal(objeto1, objeto2)
# Si son diferentes, 'all.equal' hace un pequeño reporte de las diferencias. 
# Por ejemplo, los dos valores siguientes son muy similares:
pi        # 3.141593
355 / 113 # 3.141593

# Pero no son idénticos:
identical(pi, 355 / 113) # FALSE

# Pero con all.equal podemos ver que son aproximadamente iguales:
all.equal(pi, 355 / 113) # [1] "Mean relative difference: 8.491368e-08"

# Esta función tiene además un argumento para manipular la tolerancia. Es 
# decir, podemos establecer un límite de error a partir del cual se puede 
# considerar que dos valores son iguales. Por ejemplo:
all.equal(pi, 355 / 113, tolerance = 8.5e-8) # TRUE
 
# %IN%
# El operador %in% evalúa la presencia de un valor dentro de un vector. Por 
# ejemplo, dado el vector 'character' siguiente:
frutas <- c('banana', 'pera', 'papaya', 'tomate')

# ¿Se encuentra 'tomate' dentro del vector 'frutas'?:
'tomate' %in% frutas # TRUE
# ¡Así es, el tomate es una fruta!

# Es importante notar que el significado cambia cuando se altera el orden de 
# los factores (no es conmutativo):
frutas %in% 'tomate'

# En este caso me devuelve TRUE sólo para las posiciones en las que 'frutas' 
# contiene la palabra 'tomate'; pero así como estaba 'tomate', podría haber 
# un vector de más elementos, por ejemplo:
frutas %in% c('tomate', 'pera')

## Resumen
# Las funciones que vimos en esta sección nos sirven, al igual que las de la
# sección anterior, para comparar objetos en R. Al igual que las anteriores, y
# como veremos más adelante en el curso, estas operaciones presentan gran
# importancia en programación.
