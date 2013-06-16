## LOOP FOR:

# Los "loops" ("lazos" o "bucles" en español) son comandos especiales que 
# sirven para hacer ejecutar una tarea una cantidad arbitraria de veces; se 
# llama iteración a cada una de estas repeticiones. Sirven para hacer en 
# segundos lo que manualmente llevaría horas, días o sería simplemente demasiado.

# Los comandos más universales para hacer loops en programación son "for" y
# "while", y en R esto no es distinto.

# Se puede acceder a la ayuda de R con varios comandos, por ejemplo (no correr):
?Control
?"for"


## SINTAXIS

# Empecemos con un ejemplo muy sencillo:

for (i in 1:4) {
  print(i)
}

# Analicemos lo que ocurre:
# En la consola vemos que se imprimen los números 1, 2, 3 y 4. Esto ocurre 
# porque dentro del loop se puso el comando print(i). En este caso i es un 
# objeto, al cual llamaremos la "variable" o "variable de iteración". Cuando 
# miramos en el paréntesis del for, vemos que dice "i in 1:4". Esto quiere 
# decir que la variable i va a tomar los valores contenidos en el vector 1:4, 
# es decir que en la primer iteración i vale 1, luego 2 y así. En suma, es 
# equivalente a escribir:
i <- 1
print(i)
i <- 2
print(i)
i <- 3
print(i)
i <- 4
print(i)
# ... pero por supuesto que es mucho más económico y elegante.

# Nota: debido a que hay una sola expresión dentro del loop (print(i)), no es 
# necesario usar las llaves para delimitar el loop; son equivalentes estas dos 
# opciones:
for (i in 1:4)
  print(i)
# ó
for (i in 1:4) print(i)

# Nota: puede verificar que i es además un objeto que existe en su sesión y 
# cuyo valor es el último asignado por el loop for. En este caso i == 4:
i

# Por supuesto que este es uno de los ejemplos más elementales que se pueden 
# imaginar de un loop for, pero hay un par de detalles que por costumbre o 
# convención se repiten casi siempre:
# - El usar el nombre "i" para la variable de iteración. No es necesario que 
#   tenga este nombre, eso es un valor arbitrario (puede llamarse, j, k o carlos 
#   sin problemas), pero es aconsejable mantener este criterio para facilitar la 
#   comprensión del código.
# - El utilizar números naturales para el vector de valores que va a tomar i, 
#   en este caso 1:4. Aquí tampoco hay límites en cuanto a los valores o clase 
#   de vector que se elige. A continuación veremos porqué es más común y 
#   conveniente utilizar estos tipos de vectores.

# Un ejemplo un poco más ilustrativo: consideremos que existe un vector v 
# definido así:
v <- c(5, 2, -2, 3)
# Ahora, supongamos que queremos imprimirlo en la consola, un valor a la vez. 
# Podemos recurrir a este código:
for (i in v)
  print(i)

# Como puede ver, ahora la variable i va tomando los valores del vector v y 
# print(i) los va imprimiendo en la consola. Es equivalente a:
i <- v[1]
print(i)
i <- v[2]
print(i)
i <- v[3]
print(i)
i <- v[4]
print(i)

# De todas formas, este ejemplo *no refleja el uso más frecuente* de la 
# variable i. Usualmente lo que se hace es utilizar i para indizar al vector v, 
# así:
for (i in 1:4)
  print(v[i])

# A través de los corchetes estamos usando i para imprimir el iésimo elemento 
# de v en cada iteración. Parece un camino más largo y por lo tanto 
# inconveniente. Sin embargo en la práctica rara vez se va a utilizar la 
# variable i para indizar solamente un vector, si no que suele usarse 
# repetidamente para indizar diferentes objetos, incluyendo matrices, 
# data.frames o listas. Veamos un ejemplo:

# Preparación:
m <- matrix(rpois(12, 8), 4, 3) # Una matriz de 4x3
s <- numeric(4) # Un vector de longitud 4, valores == 0
# Loop:
for (i in 1:4)
  s[i] <- sum(m[i,])
s
# Aquí se creo un vector s, inicialmente todos sus valores 0, cuyo objetivo 
# era contener los valores de las sumas por fila de la matriz m. Adentro del 
# loop se utilizó i en dos ocasiones: 
# (1) para indicar el número de fila de m al cual se debía aplicar la 
#     función sum ("sum(m[i,])") y 
# (2) para indicar el iésimo valor de s, en donde se almacenó el resultado de 
#     la operación anterior ("s[i] <- ...").

# Nota: el vector s es idéntico al obtenido con el comando:
rowSums(m)

# Nota 2: es un error muy común definir s *adentro* del loop, en lugar de 
# *afuera*. Al cometer este error le estamos indicando a R que s se debe 
# *reiniciar* en cada iteración, de forma que borra todo lo hecho en 
# iteraciones anteriores. Veamos esto en un ejemplo:
m <- matrix(rpois(12, 8), 4, 3) # Una matriz de 4x3
# Loop:
for (i in 1:4) {
  s <- numeric(4) # Un vector de longitud 4, valores == 0
  s[i] <- sum(m[i,])
} # Se agregan las llaves porque hay más de 1 comando
s

# Como se muestra en la observación anterior (s == rowSums(m) para el loop 
# correcto), no siempre es necesario hacer un loop para hacer estas operaciones 
# (aquí rowSums puede hacer lo mismo). En general en R es conveniente saber 
# cuándo podemos evitar hacer un loop, no sólo para "simplificar" la sintaxis, 
# si no porque puede haber una pérdida de eficiencia que, en caso de hacer 
# cálculos pesados, se paga con mucho tiempo perdido. En general el término que 
# refiere a optar por alternativas a los loops es "vectorización" (ver lección 
# 6.2-loop-for-extra.r por más detalles relativos a la vectorización a la 
# eficiencia del uso de recursos). Nótese que la vectorización no es posible en 
# todos los lenguajes de programación y que en lenguajes más tradicionales (como 
# pueden ser C o FORTRAN) es necesario usar loops para las operaciones más 
# simples (como, por ejemplo, sumar dos vectores de igual longitud).

# Hay casos en los que usar loops en R es sencillamente inevitable. Vamos a ver 
# ahora uno de estos casos.

## EJEMPLO: SERIE DE FIBONACCI

# La serie de Fibonacci se puede definir de la siguiente manera: se trata de una 
# secuencia de valores que cumplen la regla general:
# F_{i} == F_{i - 1} + F_{i - 2}

# (Aquí F_{n} es el enésimo elemento de la serie F.)

# Esto implica que es necesario definir de manera arbitraria los dos primeros 
# valores (F_{1} y F_{2}) para poder definir el resto de la serie. Si los 
# primeros valores son 0 y 1 entonces la serie es (hasta el octavo valor):
# F = [0, 1, 1, 2, 3, 5, 8, 13]

# Vamos entonces a crear un loop en R que permita calcular la serie de Fibonacci 
# hasta el enésimo valor. Crearemos la función fibo para este objetivo:
fibo <- function(n = 20, inicio = 0:1) { 
  # n e inicio tienen valores por defecto, por comodidad

}
# ... por ahora la función no hace nada, veamos cómo debemos completarla ...

# Traduciendo la regla general a R, nos quedaría algo así:
out[i] <- out[i - 1] + out[i - 2]
# donde out es un vector en el cual vamos a almacenar todos los valores de la 
# serie. Nótese que esto implica que i no puede ser menor que 3; si i fuera 2, 
# por ejemplo, entonces out[i - 2] sería out[0], lo cual es un valor no definido 
# en R. A su vez, esto implica que out tiene al menos i elementos y que out[1] y 
# out[2] están definidos de antemano.

# Estas condicionantes nos llevan a definir lo que llamamos la Preparación del 
# loop. Por un lado, out tiene que existir y tener al menos 3 elementos, pero de 
# hecho ya decidimos que tendrá n elementos. El valor n está definido como uno 
# de los argumentos de la función, así que no lo definiremos de vuelta. Por 
# otro lado, los dos primeros valores de out se definen con el otro argumento: 
# inicio. De esta forma la preparación sería algo así (no ejecutar):
out <- numeric(n)
out[1:2] <- inicio

# Como puede confirmar, si asigna valores a n y a inicio (inicio debe ser un 
# vector de 2 elementos), out ya es un vector viable para aplicar la fórmula 
# general. Pero para eso tenemos que agregar el loop en sí (no ejecutar):
for (i in 3:n) {
  out[i] <- out[i - 1] + out[i - 2]
}

# Es imporante notar que el rango de valores de i es 3:n; 3 porque ya vimos que 
# i no puede ser menor y n porque es la cantidad de elementos de out.

# Tenemos entonces todo para definir correctamente la función fibo:
fibo <- function(n = 20, inicio = 0:1) {
  # Preparación:
  out <- numeric(n)
  out[1:2] <- inicio
  # Loop:
  for (i in 3:n) {
    out[i] <- out[i - 1] + out[i - 2]
  }
  out # La salida de la función
}

# Podemos comprobar de que fibo hace correctamente su tarea:
fibo()
fibo(22)

# Es importante destacar los puntos claves a tener en cuenta en el proceso de 
# crear fibo:
# 1. El vector out debe estar correctamente definido antes de empezar el loop. 
#    Generalmente la Preparación es necesaria para aprontar vectores como out, 
#    en el cual se almacenan los valores que nos interesan.
# 2. La variable i debe estar contenida en el rango correcto de valores, en 
#    este caso 3:n. Este es un punto en el cual es frecuente comenter errores.

# Pero ¿por qué es que es inevitable usar un loop para este problema?
# Se puede responder con un ejemplo: ¿qué ocurre al tratar de calcular el 
# cuarto elemento de out? Para obtener este valor es necesario primero definir 
# el tercer elemento de out, ya que out[4] = out[3] + out[2]. El mismo problema 
# surgirá cuando se trate de obtener out[5] y los demás valores, por lo que no 
# queda opción que "ir calculando de a uno" los valores de la serie de 
# Fibonacci. En general es fácil ver que siempre que los valores de una 
# secuencia dependen de los anteriores es necesario hacer un loop para poder 
# calcularlos. Dicho de otra forma, los loops son inevitables para calcular 
# secuencias definidas por Relaciones de Recurrencia 
# (https://es.wikipedia.org/wiki/Relaci%C3%B3n_de_recurrencia).
# Nota: muchas veces estas relaciones de recurrencia también tienen soluciones
# cerradas, lo que implica que en esos casos tampoco es estrictamente necesario
# usar un loop (en R) para calcular los valores de la sucesión.

## LOOPS FOR ANIDADOS:

# Nada impide que adentro de un for (o un while) se escriba otro loop. Esto es 
# lo que llamamos un loop anidado. Las reglas que siguen son las mismas que antes, 
# pero hay que tener la precaución de utilizar diferentes nombres para las 
# variables de iteración. En el siguiente ejemplo se usan i y j como variables:

m <- matrix(rpois(4, 8), 2, 2) # Una matriz de 2x2
for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    print(m[i, j])
  }
}

# Como fácilmente se puede comprobar, este código simplemente imprime todos los
# elementos de la matriz m. Nótese: que la variable i se usa para las filas y 
# la variable j para las columnas. 


## RESUMEN
# Hemos visto el tipo de loop más comunmente utilizado en programación. El loop
# 'for' se utiliza cuando "sabemos" de antemano el número de iteraciones que
# necesitamos.
# Dado que la sintaxis es relativamente elaborada, hay que tener especial
# atención a los errores, particularmente los más comunes: omisión de una llave,
# escribir mál la secuencia de números (1:n) o confundir el nombre de las
# variables (i, j, k, etc ...).
# En general siempre va a ser necesario tener una Preparación, es decir líneas
# de código anteriores al loop en las que se definen correctamente uno o varios
# objetos que serán utilizados dentro del mismo. Un error común es definir 
# alguno de estos objetos (como el out en la función fibo) *adentro* del loop,
# cuando es necesario que esto se haga **afuera**, en la preparación.
# Los ejemplos empleados dan cuenta de situaciones comunes en que podemos
# utilizar esta herramienta, pero no está limitada a éstas. Siendo particular-
# mente útil al realizar simulaciones con modelos o aplicar análisis a grandes
# series de datos, su combinación dentro de funciones y con otras estructuras
# de control (ej: condicionales) se hace más importante, y resulta fundamental
# como herramienta para cualquier programador.

