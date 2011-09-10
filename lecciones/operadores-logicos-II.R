### Operadores lógicos, continuación...

## En esta sección se muestran breves ejemplos de las funciones:
any, all, all.equal, identical, isTRUE
## Todas estas funciones sirven para comparar objetos e identificar similitudes.
## Todas ellas devuelven un único valor lógico (TRUE o FALSE), aunque all.equal
## es un poco diferente...
 
## ANY
any(condición1, condición2, ..., condiciónN)
## ¿Al menos una de estas condiciones verdadera?
 
## Ejemplos:
any(5 > 8) # FALSE
any(5 > 8, 4 == 5) # FALSE
any(5 > 8, 4 == 5, 0.1 < 0.12) # TRUE; la última sí es verdadera
 
set.seed(3)
x <- rnorm(10)
any(x > 1.96) # FALSE
any(x > 1.2)  # TRUE
 
x <- 1:5
y <- 5:1
x == y
# [1] FALSE FALSE  TRUE FALSE FALSE
any(x == y) # TRUE
 
 
## ALL
all(condición1, condición2, ..., condiciónN)
## ¿Son todas estas condiciones verdaderas?
 
## Ejemplos:
all(5 > 1) # TRUE
all(5 > 1, 4 == 4) # TRUE
all(5 > 1, 4 == 4, 0.12 < 0.1) # FALSE; la última es falsa
 
x <- 1:5
y <- 5:1
x == y
# [1] FALSE FALSE  TRUE FALSE FALSE
all(x == y) # FALSE
all(x == rev(y)) # TRUE
 
set.seed(3)
x <- rnorm(10)
all(x > 1.96)  # FALSE
all(x > -1.96) # TRUE
 
 
## IDETICAL
identical(objeto1, objeto2)
## ¿Son exactamente iguales estos objetos?)
set.seed(0)
x <- rnorm(10)
y <- rnorm(10)
identical(x, y) # FALSE
## "y" es distinto de "x"
set.seed(0)
y <- rnorm(10)
identical(x, y) # TRUE
 
## isTRUE(x) equivale a identical(TRUE, x)
x <- 5 > 2
isTRUE(x) # TRUE
y <- 2 < -5
isTRUE(y) # FALSE
## No es una función que tenga muchas aplicaciones, pero puede ser usada en caso
## de que el objeto a comparar pueda haber sido generado de forma incorrecta en un
## paso anterior de nuestro script o progrma.
 
 
## ALL.EQUAL
all.equal(objeto1, objeto2)
## Es similar a "identical", pero busca "casi equivalencias". Si son diferentes hace un pequeño reporte
## de las diferencias:
pi        # 3.141593
355 / 113 # 3.141593
pi == 355 / 113 # FALSE
##
all.equal(pi, 355 / 113)
# [1] "Mean relative difference: 8.491368e-08"
# not precise enough (default tol) > relative error
 
## Si los objetos comparados son realmente idénticos, entonces devuelve TRUE:
x <- 1:5
y <- 5:1
all.equal(x, y)
# [1] "Mean relative difference: 1"
all.equal(x, rev(y)) # TRUE
