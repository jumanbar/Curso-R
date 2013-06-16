## Estructuras de control: loops (for)

# Los "loops" ("lazos" o "bucles" en español) son comandos especiales que sirven para hacer ejecutar una tarea una cantidad arbitraria de veces; se llama iteración a cada una de estas repeticiones. Sirven para hacer en segundos lo que manualmente llevaría horas, días o sería simplemente demasiado.

# Los comandos más universales para hacer loops en programación son "for" y
# "while", y en R esto no es distinto.

# Se puede acceder a la ayuda de R con varios comandos, por ejemplo (no correr):
?Control
?"for"


## SINTAXIS
# Aquí veremos solamente el caso más común que suele utilizarse en R, pero es
# bueno saber que existen variantes más sofisticadas.
# Este comando es usado cuando de antemano sabemos el número de iteraciones que
# necesitamos. En la práctica esto es la mayoría de las veces. Un loop for
# típico se escribe así:

for (i in 1:10) {
  # comando 1
  # comando 2
  # etc ...
}

# Con este código R ejecuta los comandos 1, 2, etc unas 10 veces. Por ejemplo,
# el siguiente ejemplo escribe la palabra "Hemoglobina" 4 veces:

for (i in 1:4) {
  print("Hemoglobina")
}

# ¡Atención! Un error común es olvidar escribir alguno de las llaves { y }; sin
# embargo en el caso de un único comando se pueden eliminar por completo ...

# Más importante aún que la cantidad de veces que se ejecutan los comandos es la
# discreta presencia de la letra "i" en la primer línea. El rol de este objeto
# es el de variable: en cada iteración el i cambia, tomando los valores 1, 2, 3
# y 4 (en este caso). Esto es sumamente útil para hacer casi cualquier cosa más
# elaborada que escribir lo mismo 4 veces ...

# El siguiente ejemplo muestra esta propiedad de forma explícita:

for (i in 1:5) {
  print("El valor i:")
  print(i)
}

# Nótese que ahora i = 5, ya que es el último valor del loop. Nótese también que
# no hay restricción alguna en los números a utilizar. Es perfectamente válido
# (y potencialmente útil) escribir 3:5 o -1:5 en lugar de 1:5 como en el ejemplo.

# Nótese también que se utilizan 2 espacios antes de los comandos interiores a
# las llaves. Esta práctica es simplemente un criterio común para que el ojo
# humano detecte fácilmente cuáles son los comandos del loop.

# ¡Atención! Uno de los errores más comunes es el poner un sólo número aquí,
# por ejemplo:

for (i in 5) {
  print(i)
}

# Esto sólo imprime "5".

# Nótese también: que la letra i no es la única opción, cualquier letra o
# palabra sirve.


## USOS MÁS COMUNES:
# 1. Para acceder de forma secuencial a los distintos valores de un vector,
# matriz o data.frame se pueden usar códigos como el siguiente:

perros <- c("cucho", "bobi", "morti", "sultan", "fido", "yonofui")

for (i in 1:length(perros)) {
  print(paste("Mi perro se llamaba:", perros[i]))
}

# Lo más importante para notar aquí es el uso de los paréntesis rectos para
# indicar que queremos sólo el iésimo elemento del vector "perros". Es decir, se
# escribe "perros[i]" y no "perros" solamente.

# Nótese que aquí en vez de escribir "1:6" se puso "1:length(perros)", de forma
# tal que no es necesario saber de antemano cuántos elementos tiene el vector en
# cuestión.

# En mismo principio se puede utilizar de muchas maneras distintas y en
# particular con matrices y data.frames puede ser muy útil. Por ejemplo, para
# imprimir el promedio de valores de cada fila en una matriz m:

m <- matrix(rnorm(24, 5), nrow=4)
for (i in 1:nrow(m)) {
  print(mean(m[i, ]))
}


# 2. Otro uso común es el de ir "rellenando" un objeto con valores obtenidos en
# cada iteración. En este tipo de estrategias, primero se debe crear el objeto
# vacío y luego en el for se ejecutan los comandos para hacer el rellenado. El
# siguiente ejemplo ilustra este principio utilizando la matriz m creada en el
# ejemplo anterior:

(promxfila <- numeric(nrow(m)))
# Este primer comando genera un vector de ceros con la longitud adecuada.
for (i in 1:nrow(m)) {
  promxfila[i] <- mean(m[i, ])
}

# Es fácil comprobar que el vector promxfila contiene los mismos valores que se
# imprimieron anteriormente.

# Nota: existe una forma más fácil y eficiente de hacer lo mismo:
promxfila <- rowMeans(m)


# 3. Los usos anteriores se pueden combinar para reproducir diferentes tipos de
# procesos. Vamos a ilustrar este principio con la llamada "caminata del
# borracho".

# La caminata del borracho es un proceso muy simple: en cada iteración se tira
# una moneda (usaremos "sample" para esto) y el borracho se mueve un paso a la
# izquierda o a la derecha según el caso.

# Hagamos un borracho con 50 iteraciones, cuya posición inicial es el cero.
# Primero hay que crear el vector para rellenar:

posicion <- numeric(50)
for (i in 1:49) {
  moneda <- sample(c(-1, 1), 1)
  posicion[i + 1] <- posicion[i] + moneda
}

# Podemos visualizar el resultado con un comando simple de plot:
plot(posicion, type="o", xlab="Iteración", ylab="Posición")


# 4. Loops Anidados. Muchas circunstancias pueden llevar a que sea necesario
# hacer un for dentro de otro for, lo cual suele hacer las cosas un poco más
# complicadas. Ilustraremos el concepto utilizando nuevamente la matriz m creada
# anteriormente:

for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    print(m[i, j])
  }
}

# Como fácilmente se puede comprobar, este código simplemente imprime todos los
# elementos de la matriz m.

# Nótese: que la variable i se usa para las filas y la variable j para las
# columnas. Es importante en estos casos usar nombres diferentes para cada for,
# ya que de otra manera se producen errores que pasan inadvertidos.

# En general es lo más aconsejable tratar de evitar utilizar este tipo de
# recursos, ya que muchas veces se pueden resolver los mismos problemas de
# formas más eficientes. En la lección "loops-for-extra" se explica mejor esta
# idea y se dan algunos ejemplos.

## RESUMEN
# Hemos visto el tipo de loop más comunmente utilizado en programación. El loop
# 'for' se utiliza cuando "sabemos" de antemano el número de iteraciones que
# necesitamos.
# Dado que la sintaxis es relativamente elaborada, hay que tener especial
# atención a los errores, particularmente los más comunes: omisión de una llave,
# escribir mál la secuencia de números (1:n) o confundir el nombre de las
# variables (i, j, k, etc ...).
# Los ejemplos empleados dan cuenta de situaciones comunes en que podemos
# utilizar esta herramienta, pero no está limitada a éstas. Siendo particular-
# mente útil al realizar simulaciones con modelos o aplicar análisis a grandes
# series de datos, su combinación dentro de funciones y con otras estructuras
# de control (ej: condicionales) se hace más importante, y resulta fundamental
# como herramienta para cualquier programador.
