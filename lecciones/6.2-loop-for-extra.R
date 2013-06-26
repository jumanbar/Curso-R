## FOR: lección extra

# En la lección principal se muestra el uso del loop "for" en su forma más
# extendida. En esta lección se busca mostrar el caso más genérico posible así
# como consejos importantes sobre el uso de este loop en procesos de computación
# intensiva.

## FORMA GENÉRICA

# Todo for puede mapearse a este esquema general (no correr):
for (v in s) bloque_de_instrucciones

# Aquí la variable v será un valor que tomará secuencialmente los valores
# contenidos en s. Es decir, en la primer iteración v = s[1], en la segunda
# v = s[2], y así hasta completar todos los elementos. Esto incluye vectores de
# clase character, de forma que el ejemplo usado anteriormente puede
# reescribirse:

perros <- c("cucho", "bobi", "morti", "sultan", "fido", "yonofui")
for (p in perros) {
  print(paste("Mi perro se llamaba:", p))
}

# Esto también nos libera de la restricción de que "i" tome valores según la
# vieja fórmula 1:n, por ejemplo:
s <- c(49, 9, 25)
for (v in s) print(sqrt(v))

# Como se habrá notado, las instrucciones no necesariamente deben ser
# delimitadas por llaves. Un bloque de instrucciones de un sólo comando no
# necesita de esta demarcación, pero si hay más de uno es imperativo usarla.


## EVITANDO EL FOR
# Es sabido entre programadores que en lenguajes interpretados como R es siempre
# una buena idea evitar los loops for para disminuir la velocidad en la
# velocidad de ejecución de nuestro código. Para esto hay varios consejos que
# pueden implementarse y que en muchos casos van a mejorar la eficiencia del
# código de forma dramática. El ejemplo más útil probablemente sea el de lo que
# se denomina "vectorización".

# Nota: la llamada vectorización generalmente no puede ser implementada en
# loops while, debido a que suele ocurrir que es difícil anticipar la cantidad de
# iteraciones que serán necesarias en estos casos.

# Vectorización.
# Como ejemplo, la suma entre matrices de mismo tamaño es una tarea que puede
# hacerse con un loop, y de hecho es lo que un programador experimentado en
# lenguajes más "tradicionales" (como C o C++) tiende a hacer. El código para
# hacer esto sería, por ejemplo:
m <- matrix(sample(2e5), 400, 500)
n <- matrix(sample(2e5), 400, 500)
l <- matrix(0, 400, 500)

for (i in 1:400) {
  for (j in 1:500) {
    l[i, j] <- m[i, j] + n[i, j]
  }
}

# Sin embargo esto en R puede ser fácilmente unas 600 veces más lento que simplemente
# escribir:
l <- m + n
# sin mencionar que es mucho menos sencillo y elegante.

# La clave en este ejemplo es la capacidad de utilizar operadores (o funciones)
# sobre objetos de muchos elementos (como m y n). De la misma forma, por ejemplo,
# utilizando las funciones sum y el operador >= se puede hacer un conteo rápido
# del número de elementos de un vector que cumplen una condición dada:
x <- rnorm(200)
sum(x >= 0) # una cifra cercana a 100 ...

# Varias funciones en R pueden utilizarse para vectorizar procesos y así
# aumentar la eficiencia de nuestro código, algunos ejemplos son: ifelse, which,
# any, all, cumsum, cumprod, sum, prod, rowSums y colSums.

# El caso de apply es una forma de no escribir explícitamente un for, pero no
# acelera la ejecución ya que no utiliza funciones internas en lenguaje C. En
# cambio las variantes de apply, como lapply y sapply, pueden aumentar la velocidad de un
# código notoriamente.

# Otros casos se han visto en las lecciones que fácilmente podrían ser
# vectorizados. Por elemplo, en el caso de la caminata del borracho, R nos da
# las herramientas para evitar el loop antes ejecutado:

set.seed(0)
posicion <- numeric(50)
for (i in 1:49) {
  moneda <- sample(c(-1, 1), 1)
  posicion[i + 1] <- posicion[i] + moneda
}
plot(posicion, type="o")

# Equivale a:

set.seed(0)
pasos     <- c(0, sample(c(-1, 1), 49, replace=TRUE))
posicion2 <- cumsum(pasos)
plot(posicion2, type="o")

# En este caso se utilizaron dos funciones de R que ejecutan loops de forma
# inadvertida por el usuario y que de hecho son mucho más rápidos, ya que se
# utiliza el lenguaje C internamente. Estas funciones son sample, la cual puede
# crea 49 valores en una sóla ejecución, y cumsum, quién hace la suma
# acumulativa del vector pasos.

# Este ejemplo es importante de recordar, ya que la generación de números
# aleatorios suele ser un proceso lento dentro de un código en R. Siempre es
# mejor crear n números aleatorios en un sólo paso que hacerlos de a uno dentro
# de un loop con n iteraciones. Por esta razón siempre es recomendable crear
# números aleatorios en algún paso anterior al loop que necesitamos ejecutar.

# Por ejemplo, una versión intermedia entre las dos anteriores podría ser:
set.seed(0)
posicion <- numeric(50)
monedas  <- sample(c(-1, 1), 49, replace=TRUE)
for (i in 1:49) {
  posicion[i + 1] <- posicion[i] + moneda[i]
}

## FOR INEVITABLES
# En varias ocasiones encontraremos que es realmente inevitable utilizar un loop
# for. Muchas veces esto ocurre porque en cada iteración es necesario utilizar
# valores "anteriores" de un vector o matriz. Por ejemplo, si consideramos la
# conocida serie de Fibonacci, la cual empieza con dos 1 y se calcula cada valor
# siguiente sumando los dos anteriores.

# Es decir, si f(n) es el enésimo valor de la serie, una forma de describir
# la serie es (empezando por n = 3):
# f(n) = f(n - 1) + f(n - 2)

# Los primeros valores son:
# 0 1 1 2 3 5 8 13 21 34 55 89 ...

# Calculemos los primeros 20 elementos de la serie:
fibo <- numeric(20)
fibo[1:2] <- 0:1
for (n in 3:20) {
  fibo[n] <- fibo[n - 1] + fibo[n - 2]
}
plot(fibo, log='y', type='o')

