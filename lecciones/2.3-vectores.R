## Vectores

# Los vectores son una de las unidades básicas de trabajo en R y muchos de los
# métodos de trabajo con este tipo de objetos se aplica para otras clases de
# objetos. Por ejemplo, casi todos los objetos pueden ser indexados usando [ ].

# Un vector es una colección de uno o más objetos del mismo tipo (e.g.
# caracteres, números); esta es una restricción importante a la hora de crear
# un vector, como veremos más adelante.

# Esta característica hace que se los denomine "vectores atómicos" (atomic
# vectors).

# Un vector no tiene dimensión en R, más allá de que en álgebra se considera que
# los vectores tienen dimensión 1. Es decir, en R y a diferencia de otros
# lenguajes como Matlab u Octave, los vectores no son fila o columna, si no
# que simplemente son una secuencia de valores. Esto se refleja en el hecho de
# que al consultar por la dimensión de un vector, con el siguiente comando:
dim(1:10)
# El resultado es simplemente NULL, es decir, no tiene una dimensión asociada.

# Existen varias formas de hacer un vector en R. Ya vimos el uso del operador
# : en el ejemplo anterior y en otros casos. De esta forma se pueden crear
# secuencias de números enteros fácil y rápidamente. Algunos ejemplos son:
0:10  # secuencia del 0 al 10
10:-5 # secuencia del 10 al -5

# Hay que tener un poco de cuidado siempre en la sintaxis, sobre todo cuando
# uno de los extremos es el resultado de una operación, por ejemplo:
0:10 - 1
# no es lo mismo que
0:(10 - 1)
# El orden en que se evalúan los distintos operadores hace la diferencia. Aquí:
# ":" va primero que la resta ("-"), pero los paréntesis "()" preceden a ambos
# (ver "Orden de precedencia" para más detalles).

# Varios vectores o elementos individuales se pueden concatenar para crear un
# nuevo vector cuyo tamaño es igual a la suma de dichos elementos. Como mencio-
# namos anteriormente, estos elementos deben ser todos del mismo tipo. La
# función "c" se usa para esto:
x <- c(4, 6, 7) # NOTA: En general se recomienda no asignar el nombre 'c' a
                # objetos, para evitar confusiones.

# De manera similar, se pueden concatenar varios vectores:
(x <- c(0:5, 11:16))
(y <- c(pi, 2))
(z <- c(x, y))
# Nótese la cantidad de decimales, debido a la inclusión del valor "pi" en el
# segundo caso.

# En el caso de concatenar objetos de diferentes tipos, R reasigna los elemen-
# tos a la clase apropiada. Por ejemplo si concatenamos elementos numéricos y
# caracteres:
x <- c(4, "papa", 7)
class(x)

# R convierte a todos en character y no a la inversa, ya que es la opción que
# no se presta a ambigüedades.

# Esta coerción es necesaria para el funcionamiento correcto de R, pero puede
# ser una fuente de errores difíciles de detectar para el usuario que no está
# atento a estos detalles.

# Las clases posibles de los vectores son 5: integer, numeric, character, logical
# y complex. Estos son algunos ejemplos:
x <- 1:5
class(x) # integer (enteros)
x <- seq(11, 15, by=0.1)
class(x) # numeric
x <- c('Gabi', 'Fofó', 'Miliki')
class(x) # character
x <- 1:3 > 1.34
class(x) # logical (valores lógicos, TRUE/FALSE)
x <- 1:4 + 1i
class(x) # complex

# Una función práctica es rep, la cual sirve para repetir n veces un valor o un
# vector. Por ejemplo el siguiente comando
rep('char', 5)

# genera un vector character con 5 repeticiones de la palabra 'char'. De forma
# similar, si el primer argumento es un vector, va a estar repetido n veces, y
# esta repetición puede tener algunas variantes:
rep(c(5, 7, 2), 3)
rep(c(5, 7, 2), each=3)
# Nótese las diferencias en las salidas. Vea la ayuda de R para ver en
# profundidad el funcionamiento de rep.

# La función "seq" sirve para generar secuencias de valores con mayor flexibilidad que
# el operador :. Por ejemplo, para generar secuencias de valores entre 0 y 1,
# cuyos valores consecutivos tengan una diferencia de 0.05, podemos correr:
seq(0, 1, by = 0.05)
# el argumento "by" indica la diferencia que queremos. Alternativamente,
# podemos estar interesados en especificar el largo final del vector y que R
# simplemente, calcule automáticamente la diferencia entre valores
# consecutivos. Para esto usamos el argumento length o len:
seq(0, 1, length = 5)
seq(0, 1, len = 5)


## Índices de los vectores

# Los corchetes o paréntesis rectos se utilizan para especificar elementos de
# los vectores, usando índices, los cuales deben ser números enteros. Si
# queremos acceder a uno o más valores de un vector, usamos índices entre
# paréntesis rectos [ ]. El valor que pongamos dentro indica la posición del
# valor requerido en el vector. Es decir, x[i] indica el iésimo valor de x.

# Hagamos un vector 'x':
x <- 5:-2

# Para acceder al segundo valor, ponemos un 2 entre corchetes, luego del
# nombre del vector:
x[2]

# Por supuesto, podemos guardar este valor en un nuevo objeto:
a <- x[2]

# Para acceder a varios valores al mismo tiempo podemos indicar una secuencia
# o concatenar valores con los elementos deseados:
x[1:4]
x[c(2, 8, 5)]

# De esta forma, cualquier elemento del vector x puede ser seleccionado si
# usamos los números adecuados. Esta utilidad, utilizada con creatividad es
# muy poderosa para elaborar análisis sofisticados.

# Nótese además que el orden de los valores que nos devuelve depende de los
# números usados. Por ejemplo en el caso anterior, el octavo valor de x está
# en segundo lugar en la salida. Esto se puede usar para invertir el orden de
# los valores de un vector (aunque también se puede usar 'rev(x)'), por ejemplo:
x[8:1]

# Si usamos un signo de menos, la salida es un vector sin los elementos
# restados. Por ejemplo, para quitar el primer elemento de x:
x[-1]
# O para quitar varios elementos al mismo tiempo, por ejemplo:
a <- x[-(1:4)]
# Nótese el uso de paréntesis para evitar confusiones...

# La función 'which' sirve para saber los índices de los elementos del vector
# que cumplen una determinada condición:
a <- which(x > 1)
a
x[a] # Deben ser sólo los elementos de x mayores que 1

# A veces usar 'which' es un poco engorroso si queremos hacer cosas simples.
# Una forma alternativa es usar directamente el vector lógico dentro de los
# paréntesis rectos:
x[x > 1]
# Estos son entonces los elementos de "x" que cumplen con la condición (x > 1).

# Los índices también se pueden usar para modificar al vector x. Si
# utilizamos la flecha podemos asignar al iésimo elemento un nuevo valor, por
# ejemplo, si queremos que el primer valor sea 8000:
(x[1] <- 8000)

# Usando varios índices podemos también cambiar varios elementos en
# simultáneo, por ejemplo:
(x[1:3] <- 8000:8002)
(x[c(3, 6)] <- c(55, 66))

# NOTA: En RStudio se puede modificar vectores cliqueando el nombre del vector
# en la ventana de workspace (panel 3, arr. der.)

## Funciones y vectores
# Al poner un vector dentro de una fórmula, aplica la fórmula a todos los
# elementos independientemente
x <- 0:5
x     # [1] 0 1 2 3 4 5
2 * x # [1] 0 2 4 6 8 10
x ^ 2 # [1] 0 1 4 9 16 25 # acá estamos elevando al cuadrado
y <- x ^ 2 + log(pi / 2) # la fórmula puede ser todo lo compleja que se quiera.
y
# [1] 0.4515827 1.4515827 4.4515827 9.4515827 16.4515827 25.4515827
# ...pero de esta manera se aplica a todo el vector

# Esta capacidad de "vectorizar" funciones u operaciones es muy práctica y
# siempre vale la pena recordar, ya que puede aumentar la eficiencia de un
# código dado. En lenguajes que no utilizan estas funcionalidades, suele ser
# necesario recurrir a loops para hacer las mismas operaciones, lo cual suele
# ser bastante más engorroso para trabajar.


## Información

# Hay muchas funciones que devuelven 'resúmenes' o estadísticos con información
# acerca del vector al que se están aplicando. Una de las más útiles es
# length, función que sirve para saber cuántos elementos tiene un vector.
# Vamos a usar el término "longitud" para este valor:
length(x)  # longitud del vector

# Otras funciones frecuentemente usadas son las siguientes:
sum(x)     # sumatoria
prod(x)    # productoria
mean(x)    # promedio
median(x)  # mediana
sd(x)      # desvío estándar
var(x)     # varianza
summary(x) # resumen del vector, incluye varios valores relevantes (mínimo,
           # máximo, media, mediana, cuartiles)

# En particular summary, que es una función genérica, suele ser muy útil
# para previsualizar datos.


## Graficar vectores

# La función plot, también genérica, es muy útil para visualizar los
# valores de un vector. Usada de la siguiente forma (la más simple):
plot(x)
# grafica los valores de x en el eje vertical y los coloca en el orden que
# están en el propio vector (nótese que figura la palabra 'index' en el eje
# horizontal).

# Para plotear dos vectores uno contra el otro, el único requerimiento es que
# tengan la misma cantidad de elementos. Por ejemplo, si creamos los vectores
# x e y de la siguiente manera:
x <- seq( - pi, pi, by=.05)
y <- sin(x)

# Entonces podemos graficar y en función de x así:
plot(x, y)
# Ahora x está en el eje de las abscisas; x e y tienen que tener la misma
# cantidad de elementos

# Alternativamente se puede utilizar el comando:
plot(y ~ x)
# Aquí el operador "~" o "virgulilla" se puede interpretar literalmente como y
# "en función de" x (ver la lección de fórmulas, más adelante en el curso).
# Esta forma de presentar la relación entre los vectores es importante para la
# aplicación de funciones o análisis como las regresiones, por ejemplo.

# En definitiva, los vectores son la estructura más básica que tenemos para
# manejar la información en R. Es importante notar que muchos objetos están
# compuestos por vectores: las columnas o filas de una matriz, las variables en
# un data.frame o una lista, etc. Para trabajar con R es necesario comprender
# cómo los vectores trabajan con operadores y funciones, y buscar aprovechar las
# facilidades de la vectorización cada vez que se pueda, ya que acortan mucho el
# tiempo de cálculo frente a otras alternativas.
