
________

Dado el siguiente código, marcar todas las afirmaciones correctas:

~~~
m <- matrix(sample(20), 5, 4)
for (i in 1:ncol(m)) {
  print(m[, i])
}
~~~

- Este código indica que se deben ejecutar 20 iteraciones
- Este código indica que se deben ejecutar 5 iteraciones
- Este código indica que se deben ejecutar 4 iteraciones # ok
- En cada iteración se imprimirá uno de los números de la matriz `m`
- En cada iteración se imprimirá una de las filas de la matriz `m`
- En cada iteración se imprimirá una de las columnas de la matriz `m` # ok

________

Rellenar los espacios vacíos ("`___`")):

1.

~~~
x <- numeric(___) # 10
for (i in 1:9) {
  x[i + 1] <- x[i] + rnorm(1)
}
~~~

2.

~~~
# El siguiente código simula un movimiento aleatorio de una partícula sumando
# un número aleatorio al valor de posición anterior de la misma. La posición
# se guarda en el vector x.
x <- numeric(100)
for (i in 2:100) {
  x[i] <- x[___] + rnorm(1) # i - 1
}
~~~

3.

~~~
for (___ 1:5) { # i in
  print("El valor i:")
  print(i)
}
~~~

4.

~~~
gatos <- c("cucho", "benito", "demostenes", "espanto", "panza")
for (i in ___) { # 1:5 o 1:length(gatos)
  print(paste("Uno de ellos es:", gatos[i]))
}
~~~

5.

~~~
m <- matrix(rnorm(24, 5), nrow=4)
for (i in 1:nrow(m)) ___ # {
  print(mean(m[i,]))
}
~~~

________

El siguiente comando:

    x <- colMeans(m)

Es equivalentea al código (marcar todos los que a su juicio están correctos):

a.

~~~
x <- numeric(ncol(m))
for (i in 1:ncol(m)) {
  x[i] <- mean(m[, i])
}
~~~


Es correcto. La variable i sirve para seleccionar la columna indicada de m en
cada iteración y el número de iteraciones coincide con la cantidad de columnas
de m.

b.

~~~
x <- numeric(ncol(m))
for (k in 1:ncol(m)) {
  x[k] <- mean(m[, i])
}
~~~

No es correcto. Se está llamando a la variable no definida i. Lo correcto sería
utilizar m[, k] en la tercer línea.

c.

~~~
x <- numeric(ncol(m))
for (k in 1:ncol(m)) {
  x[k] <- mean(m[, k])
}
~~~

Es correcto. La variable k sirve para seleccionar la columna indicada de m en
cada iteración y el número de iteraciones coincide con la cantidad de columnas
de m.

d.

~~~
x <- numeric(nrow(m))
for (k in 1:nrow(m)) {
  x[k] <- mean(m[, k])
}
~~~

No es correcto: se usa nrow en lugar de ncol en las primeras dos líneas.

e.

~~~
x <- numeric(ncol(m))
for (k in 1:ncol(m)) {
  x[k] <- mean(m[k, ])
}
~~~

No es correcto, debería decir m[, k] en la 3er. línea.

________

El siguiente comando:

    k <- m + 3 * exp(m)

es equivalente al código (marcar todos los que a su juicio están correctos):

a.

~~~
k <- m
for (i in 1:nrow(m)) {
  for (i in 1:ncol(m)) {
    k[i, j] <- m[i, j] + 3 * exp(m[i, j])
  }
}
~~~

No es correcto: la variable i aparece en ambos loops.


b.

~~~
k <- m
for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    k[i, j] <- m[i, j] + 3 * exp(m[i, j])
  }
}
~~~

Es correcto: las variables i y j indican correctamente las filas y columnas respectivamente
de las matrices k y m.

c.

~~~
k <- matrix(0, nrow(m), ncol(m))
for (j in 1:nrow(m)) {
  for (i in 1:ncol(m)) {
    k[j, i] <- m[j, i] + 3 * exp(m[j, i])
  }
}
~~~

Es correcto: las variables j y i indican correctamente las filas y columnas respectivamente
de las matrices k y m.

d.

~~~
k <- matrix(0, nrow(m), ncol(m))
for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    k[j, i] <- m[j, i] + 3 * exp(m[j, i])
  }
}
~~~

No es correcto: debería poner [i, j] en lugar de [j, i]

________
