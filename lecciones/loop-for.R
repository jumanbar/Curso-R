## Estructuras de control: loops (for & while)

# Sirven para ejecutar una tarea n veces. Para repetir una rutina, logrando
# en segundos lo que manualmente llevaría horas o días (o sería simplemente
# demasiado).
# Para ver la ayuda de R al respecto se pueden usar los comandos:
?Control

# Los "loops" (lazos en español) son comandos especiales que sirven para hacer
# una cantidad arbitraria de iteraciones.

# Según wikipedia:
# En programación, Iteración es la repetición de una serie de instrucciones en
# un programa de computadora. Puede usarse tanto como un término genérico (como
# sinónimo de repetición) así como para describir una forma específica de
# repetición con un estado mutable.

# Los comandos más universales para hacer loops en programación son "for" y
# "while", y en R esto no es distinto.


## SINTÁXIS BÁSICA
#  "for" es usado cuando de antemano sabemos el número de iteraciones.

# La siguiente es una descripción, lo más general posible, de la sintaxis del
# for; debe tenerse en cuenta que "variable" es simplemente un nombre
# (usualmente es una sóla letra, como "i" o "j") y "secuencia" es un vector
# cualquiera (generalmente es una secuencia del tipo 1:n):

for (variable in secuencia)
  comando

# Con este código, R ejecuta este "comando" n veces (en donde n es la longitud
# del vector "secuencia"). En cada iteración el valor de "variable" va
# cambiando, tomando uno a uno los valores del vector "secuencia".


# Un ejemplo sumamente simple:
for (i in 1:10)
  print(i)

# Aquí usamos "i" y 1:10 en lugar de "variable" y "secuencia" respectivamente.
# Nuestro comando es "print(i)".

# El resultado de este código es que se imprimen los números del 1 al 10 en
# la consola. Además el objeto "i", luego de ejecutar esto, ahora es el
# número 10:
i


## MÁS DE UN COMANDO
# Si queremos hacer varios comandos en cada iteración usamos { }. Esto es
# lo que se conoce como bloque de código: tódo lo que está entre { y } se
# ejecuta como si fuera una misma línea de comando. Esto implica que hasta
# que no se pone el último } en la consola de R no se ejecuta ninguno de
# los comandos internos.

# Estructura:
for (variable in secuencia) {
   comando1
   comando2
   ...etc
}

# Ejemplo:
for (i in 1:10) { # Es buena práctica poner el { inicial aquí
   print('Extremos:')         
   print(paste(0 - i, 0 + i))
} # Es buena práctica poner el } final aquí

# Es deseable, por un tema de facilidad de lectura, que los comandos interiores
# a los {} estén adelantados una distancia fija, por ejemplo un "tab" o
# tabulación (a esto se le llama "indentación"; ver wikipedia para mayor
# profundidad).

# (Nota: es un error muy común olvidarse de poner las llaves al principio y
# final del bloque de instrucciones, por ejemplo luego de un "if ()" o
# "for (...)". Para evitar estos errores, una actitud "agresiva" de programación
# defensiva es usar siempre llaves para los comandos for, while, repeat, if y
# else.


## GUARDANDO EL RESULTADO
# IMPORTANTE!!! Muchas veces, antes de comenzar el loop se debe crear un vector
# "vacio" (entindase como un vector lleno de ceros).
# Este vector sirve para guardar los números creados. Para este cometido, se
# puede usar un esquema de tipo:
valores <- numeric(n)
# Hasta aquí "valores" es un vector de ceros, con "n" elementos.
for (i in 1:n) {
  nuevoValor <- comando
  valores[i] <- nuevoValor
}

# Aquí "n" es el número de iteraciones que necesito, "valores" es el objeto
# (en este caso un vector) en el que se almacenan los resultados.

# Nótese que se usa la variable "i" para indicar la posición del vector
# "valores" en la cual insertamos el nuevo valor obtenido en cada iteración.


# Ejemplo: Quiero hacer una secuencia de 100 números que vayan aumentando de a
# 3, empezando por el 0 (haciendo de cuenta que no existe la función "seq").

# La variable será "i"
# La secuencia será 1:99

# Nótese que termina en el 99, debido a la forma en que voy a escribir el
# comando (ver abajo).

valores <- numeric(100) # Crea un vector con 100 ceros, luego los voy a ir
                        # sustituyendo (excepto al primero).
for (i in 1:99) {
  nuevoValor <- valores[i] + 3
  valores[i + 1] <- nuevoValor
}
# Sustituye, en cada iteración, (i + 1)ésimo valor de "valores" (que es un cero
# inicialmente) por la suma del iésimo valor de "valores" + 3

valores
plot(valores)
i # es 99

# En este caso se observaron algunas variantes respecto al esquema general
# planteado, lo cual no es raro, ya que cada tarea requiere ajustar detalles.
# Por ejemplo, no es raro utilizar matrices o listas, en lugar de vectores,
# para almacenar los valores obtenidos en nuestro loop.


## LOOPS OBLIGADOS (O NO)
# En el caso anterior, no era necesario utilizar un loop, ya que el comando
# "seq" puede realizar la misma tarea e incluso con mayor eficiencia. No es
# raro que se utilicen loops existiendo otros comandos que hacen lo mismo,
# debido a la cantidad de funciones que existen en R.

# Sin embargo hay ocasiones en que es realmente necesario utilizar un loop. Un
# caso paradigmático es cuando "el valor siguiente depende del anterior". Por
# ejemplo, si consideramos el aumento de un depósito bancaro bajo una tasa de
# interés determinada.

# Si la tasa de interés es "t" y la cantidad depositada es "d":
# d( n + 1 ) = d( n ) + d( n ) * t

# (Se indica entre paréntesis el año).
# En este caso, para calcular d( n + 1 ) necesito saber cuanto es d( n ), para
# lo cual debo conocer d( n - 1), etc... Por lo tanto, lo que necesito es
# saber el valor inicial d( 0 ).

# Entonces, para calcular d( n ) a partir de un depósito inicial podemos usar
# el siguiente código:
plata.inicial <- 500         # ¿depósito inicial?
tasa.interes  <- 0.05        # tasa de interés, 5%
deposito <- numeric(10)      # 10 años/iteraciones
deposito[1] <- plata.inicial # Hay que ingresar "manualmente" el valor inicial
                             # *antes* del loop
for (i in 1:9) {
  plata <- deposito[i] + deposito[i] * tasa.interes
  out[i + 1] <- plata
}
 
 
# Otro ejemplo: serie de Fibonacci
# La serie de Fibonacci empieza con dos 1 y se calcula cada valor siguiente
# sumando los dos anteriores.

# Es decir, si f( n ) es el enésimo valor de la serie, una forma de describir
# la serie es (empezando por n=3):
# f( n ) = f(n - 1) + f(n - 2)

# Los primeros valores son:
# 1 1 2 3 5 8 13 21 34 55 89 ...

# Calculemos los primeros 20 elementos de la serie:

fibo <- numeric(20) + 1
# "fibo" es un vector para rellenar.
for (n in 3:20) {
  fibo[n] <- fibo[n - 1] + fibo[n - 2]
}
fibo
plot(fibo)
plot(fibo, log='y', type='o')


## Bonus: LOOPS ANIDADOS
# Aunque suene horrible, no es otra cosa que más de lo mismo. La idea es que
# se hace un loop adentro de otro loop. Usando dos loops anidados podemos
# recorrer los elementos de un objeto de dos dimensiones, como es una matriz:
mat <- matrix(1:20, 4, 5)
for (i in 1:4) {       # i será el índice de las filas de mat
   for (j in 1:5) {    # j será el índice de las columnas de mat
      print(mat[i, j]) # (es necesario usar letras distintas).
}

# Ejemplo: tomando un conjunto de coordenadas cartesianas podemos hacer el
# calculo de la distancia entre cualquier par de puntos, usando la distancia
# euclidiana, que no es otra cosa que una aplicación del teorema de pitágoras:
# h ^ 2 = a ^ 2 + b ^ 2   <==>   h = sqrt(a ^ 2 + b ^ 2)
# (h: hipotenusa y a,b: catetos, de un triángulo rectángulo).
# La distancia euclidiana se calcula sustituyendo "a" por la resta de las
# coordenadas de dos puntos en uno de los ejes, haciendo lo mismo para "b" y
# despejando para la hipotenusa.

# Si el punto A es (x0, y0) y B es (x1, y1), la distancia entre ambos es:
# d = sqrt((x0 - x1) ^ 2 + (y0 - y1) ^ 2)

# Nuestros puntos van a estar representados por una matriz de dos columnas,
# las coordenadas de  "longitud" y "latitud" respectivamente:
x <- rnorm(5)
y <- rnorm(5)
coords <- cbind(x, y)

# Haremos una pequeña función para calcular la distancia entre 2 puntos
# cualesquiera, teniendo en cuenta el formato que le dimos a las coordenadas:

euc <- function(a, b, puntos) {
# Calcula la distancia entre los puntos "a" y "b", incluidos en la matriz
# "puntos"
# a,b: dos números enteros, entre 1 y el número de filas de "puntos".
# puntos: una matriz numérica de dos columnas.
  resta <- puntos[a,] - puntos[b,] # (x0 - x1, y0 - y1) = (a, b)
  return(sqrt(sum(resta ^ 2)))     # sqrt(a ^ 2 + b ^ 2)
}

# Finalmente, quiero calcular las distancias euclidianas entre todos los pares
# de puntos y guardarlos en una matriz M (5x5), en donde M[i,j] = dist.
# entre los puntos i y j ... Para esto lo primero será crear una matriz
# "vacía" para rellenar con los valores de las distancias:
M <- matrix(0, 5, 5)
# Ahora se hacen dos "for" anidados, ambos de 1:5
for (i in 1:5) {
   for (j in 1:5) {
      M[i, j] <- euc(i, j, coords)
      # Aquí relleno el elemento i,j de M con la distancia entre esos puntos.
   }
}
M # La diagonal de M deben ser ceros
diag(M)
# M debe ser simétrica respecto a la diagonal, lo cual se puede comprobar:
M1 <- M - t(M)
sum(M1) # Debe dar 0

# Nota: existen formas más "elegantes" y eficientes de hacerlo, e incluso hay
# una función nativa de R para cacular matrices de distancia ("dist").


## RESUMEN
# Hemos visto el tipo de loop más comunmente utilizado en programación.
# Destacamos que a diferencia del loop 'while', que veremos luego, el loop
# 'for' no requiere de condiciones para su ejecución, más allá de la especi-
# ficación de la cantidad de iteraciones deseadas.
# Los ejemplos empleados dan cuenta de varias situaciones en que podemos
# utilizar esta herramienta, pero no está limitada a éstas. Siendo particular-
# mente útil al realizar simulaciones con modelos o aplicar análisis a grandes
# series de datos, su combinación dentro de funciones y con otras estructuras
# de control (ej: condicionales) se hace más importante, y resulta fundamental
# como herramienta para cualquier programador.