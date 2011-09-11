#### Vectores
 
# Los vectores son una de las unidades básicas de trabajo en R y muchos
# de los métodos de trabajo con este tipo de objetos se aplica para otras
# clases de objetos. Por ejemplo, casi todos los objetos pueden ser
# indexados usando [ ].
 
# Un vector es una colección de uno o más objetos del mismo tipo (e.g.
# caracteres, números); esta es una restricción importante. Un objeto de este 
# tipo no tiene dimensión, más allá de que en un sentido matemático tienen
# dimensión 1:
dim(1:10) # NULL

# Tal vez sea contraintuitivo, pero objetos con un sólo elemento también son
# vectores:
is.vector(9)
is.vector('a')

# Existen varias formas de hacer un vector en R. Muchas funciones
# devuelven vectores cuyos tamaños son determinados por el usuario, como
# rnorm, sample y seq. Cuando hablamos del tamaño de un vector nos
# referimos al número de elementos que lo componen, lo cual se puede
# averiguar con la función length:
x <- rnorm(11)
length(x) # 11

# Varios vectores o elementos individuales se pueden concatenar para
# crear un nuevo vector cuyo tamaño es igual a la suma de dichos elementos.
# Como mencionamos anteriormente, estos elementos deben ser todos del mismo
# tipo. La función "c" se usa para esto:
x <- c(4, 6, 7) # En general no se recomienda crear objetos de nombre
                # "c", para evitar confusiones.
class(x) # numeric

# Se pueden concatenar varios vectores:
(x <- c(0:5, 11:16))
(y <- c(pi, 2))
(z <- c(x, y))
# Nótese la cantidad de decimales, debido a la inclusión del valor "pi"

# En el caso de concatenar objetos de diferentes tipos, R coherciona los
# elementos a la clase apropiada:
x <- c(4, "papa", 7)
# En este caso "class(x)" devuelve "character"

# Esta coherción es necesaria para el funcionamiento correcto de R, pero
# puede ser una fuente de errores difíciles de detectar para el programador
# que no está atento a estos detalles.

# Algunos ejemplos de vectores de distintas clases:
x <- 1:5
class(x) # integer (enteros)
x <- seq(11, 15, by=0.1)
class(x) # numeric
x <- c('Gabi', 'Fofó', 'Miliki')
class(x) # character
x <- 1:3 > 1.34
class(x) # logical (valores lógicos, TRUE/FALSE)

# Al generar una secuencia, R también devuelve un vector. Para generar una
# secuencia de enteros se usa ":", por ejemplo:
x <- 0:10 # secuencia del 0 al 10
x <- 10:-5 # secuencia del 10 al -5

# Hay que tener un poco de cuidado:
x <- 0:10 - 1
# No es lo mismo que
x <- 0:(10 - 1)

# El orden en que se evalúan los distintos operadores hace la diferencia
# aquí: ":" va primero que la resta ("-"), pero los paréntesis "()"
# preceden a ambos (ver la tabla de órden de precedencia).

x <- rep('char', 5)
# La función "rep" genera un vector repitiendo un objeto tantas veces como
# se indique

# La función "seq" sirve para generar secuencias de intervalos diferentes a
# la unidad:
x <- seq(0, 1, by=0.05)
# el argumento "by" indica el intervalo entre valores consecutivos.
x <- seq(0, 1, length=5)
# el argumento "length" o "len" indica el número de elementos de la salida.


## Índices de los vectores
# Si queremos acceder a uno o más valores de un vector, usamos índices
# entre paréntesis rectos [ ]. El valor que pongamos dentro indica la
# posición del valor requerido en el vector.
 
# Hagamos un vector:
x <- 5:-2
x # [1] 5 4 3 2 1 0 -1 -2
 
# Para acceder al segundo valor:
x[2] # [1] 4
# el "1" en la salida está porque es el primer elemento de la misma.
 
# Podemos guardar este valor en un nuevo objeto:
a <- x[2]
a # [1] 4

# Para acceder a varios valores al mismo tiempo podemos indicar una
# secuencia, o concatenar valores con los elementos deseados:
x[1:4]        # [1] 5 4 3 2
x[c(2, 4, 5)] # [1] 4 2 1

# Esto se puede usar para obtener un nuevo vector con los valores
# cambiados de lugar, por ejemplo:
x[8:1]       # Es el vector x pero con los elementos ordenados alrevés
x[sample(8)] # Elementos desoredenados al azar...

# Si usamos un signo de menos, la salida es un vector sin los elementos
# restados...
x[-1] # [1] 4 3 2 1 0 -1 -2
a <- x[-(1:4)]
a     # [1] 1 0 -1 -2
# Como a tiene valores negativos y el 0, si pedimos:
x[a]
#Error in x[a] : only 0's may be mixed with negative subscripts
# Nos da un error: los índices sólo pueden ser enteros positivos
 
# La función which sirve para saber los índices de los elementos del vector
# que cumplen una determinada condición:
a <- which(x > 1)
a # [1] 1 2 3 4
x[a] # Deben ser sólo los elementos de x mayores que 1

# Ha veces usar which es un poco engorroso si queremos hacer cosas
# simples. Una forma alternativa es usar directamente el vector lógico
# dentro de los paréntesis rectos:
(y <- x > 1) # Este es un vector "logical", los TRUE se corresponden con
x[y] # los elementos de "x" que cumplen con la condición (> 1)
# o
x[x > 1] # Lo mismo, pero en un sólo paso
 
# Los índices también se pueden usar para modificar al vector:
x[1] <- 8000
x # [1] 8000 4 3 2 1 0 -1 -2
x[1:3] <- 8000:8002
x # [1] 8000 8001 8002 2 1 0 -1 -2
x[c(3, 6)] <- c(55, 66)
x # [1] 8000 8001 55 2 1 66 -1 -2
 
# NOTA: En RStudio se puede modificar vectores cliqueando el nombre del
# vector en la ventana de workspace (panel 3, arr. der.)
 
## Funciones y vectores
# Al poner un vector dentro de una fórmula, aplica la fórmula a todos los
# elementos independientemente
x <- 0:5
x     # [1] 0 1 2 3 4 5
2 * x # [1] 0 2 4 6 8 10
x ^ 2 # [1] 0 1 4 9 16 25 # acá estamos elevando al cuadrado
 
 
y <- x ^ 2 + log(pi / 2)
# la fórmula puede ser todo lo complicada que se quiera...
y
# [1] 0.4515827 1.4515827 4.4515827 9.4515827 16.4515827 25.4515827
# ...pero de esta manera se aplica a todo el vector
 
# Al sumar/multiplicar/elevar entre dos vectores, la operación se hace con
# los elementos uno a uno:
x <- 0:5
y <- rep(0:1, 3)
# (acá se usa la función rep de forma distinta que antes ...)
y     # [1] 0 1 0 1 0 1 # se repitió un par de valores, 3 veces
x * y # [1] 0 1 0 3 0 5 # se multiplica cada para de valores, los
                        # correspondientes a cada índice
x     # [1] 0 1 2 3 4 5 # sigue siendo igual

# De forma similar, la mayoría de las funciones que trabajan con un número
# sólo, lo pueden hacer con un vector completo:
log(x) # [1] -Inf 0.0000000 0.6931472 1.0986123 1.3862944 1.6094379
# Acá aparece el menos infinito ("-Inf"): calculamos el logaritmo de 0
 
exp(x) # [1] 1.000000 2.718282 7.389056 20.085537 54.598150 148.413159
 
# Esta forma de tratar los datos hacen de R un lenguaje muy práctico para
# trabajar con números, en comparación con otros lenguajes más populares
# entre programadores. Esta forma de crear vectores es llamada
# "vectorización", en contraposición con el uso de loops para lograr el
# mismo objetivo.
 
# Hay muchas funciones que devuelven 'resúmenes' o estadísticos
length(x)  # longitud del vector
sum(x)     # sumatoria
prod(x)    # productoria
mean(x)    # promedio
median(x)  # mediana
sd(x)      # desvío estándar
var(x)     # varianza
summary(x) # resumen del vector, incluye varios valores relavantes (mínimo,
           # máximo, media, mediana, cuartiles)

## Plotear vectores
plot(x)     # Pone los índices en el eje x
plot(x ^ 2) # Nuevamente estoy anidando dos funciones, plotea el resultado
            # del paréntesis
 
# Para plotear dos vectores uno contra el otro, el único requerimiento es
# que tengan la misma cantidad de elementos.
x <- seq( - pi, pi, by=.05)
y <- sin(x)
length(x) == length(y) # ¿x e y tienen la misma cantidad de elementos?
plot(x, y)
# Ahora x está en el eje de las abscisas; x e y tienen que tener la misma
# cantidad de elementos
plot(x, sin(x))
# Exactamente lo mismo, pero sin asignar la función seno, sino colocándola
# directamente en el comando del gráfico
plot(y ~ x)
# También da lo mismo, literalmente y "en función de" x (ver la lección
# de fórmulas, más adelante en el curso). Esta forma de presentar la
# relación entre los vectores es importante para la aplicación de funciones
# o análisis como las regresiones, por ejemplo.

# En definitiva, los vectores son la estructura más básica que tenemos para
# manejar la información en R. Es importante notar que muchos objetos están
# compuestos por vectores: las columnas o filas de una matriz, las variables en
# una data.frames o una lista, etc. Para trabajar con R es necesario comprender
# cómo los vectores trabajan con operadores y funciones, y buscar aprovechar las
# facilidades de la vectorización cada vez que se pueda.
