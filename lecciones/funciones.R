#### Escribir funciones en R
 
# Muchas veces, salvo para tareas sencillas, vamos a tener que escribir
# las instrucciones a ejecutar en una nueva función.
# La función que utilizaremos para este fin será 'function', y se utiliza
# de la siguiente manera:
 
nombre <- function(arg1, arg2, arg3) instrucciones

# Con este comando la función es *definida* (pero no *ejecutada*).
# La nueva función 'nombre' va a evaluar las instrucciones en función de
# los argumentos provistos, y devolverá posteriormente una salida. La
# clase de este nuevo objeto es "function", para sorpresa de nadie.

# Una vez definida, la función puede ser ejecutada de la siguiente manera:

nombre(argumentos)

## Argumentos:
# En este caso los argumentos se llaman "arg1", "arg2" y "arg3". En el
# momento de definirla, al igual que al llamarla, estos deben estar
# separados por comas.
# Es posible definir funciones sin argumentos, aunque generalmente esto
# no es de gran utilidad. Por ejemplo:
alf <- function()
  print("¡No hay problema!")
  
alf() # Es una función con una sóla salida posible.

# Nota: para chequear cuales son los argumentos de cualquier función
# podemos usar la funcion "args":
args(alf)
args(rnorm)
args(sample)

# Si escribimos el nombre de la función a secas (sin paréntesis), podemos
# ver la definición de la función:
alf
sd
aov
lm

## Instrucciones:
# Las instrucciones son comandos de R que se van a ejecutar cada vez que
# el usuario llame la función. En el ejemplo de "alf", el único comando
# indica que hay que imprimir la frase "¡No hay problema!".

# Si se define una función con argumentos, estos serán los objetos
# presentes en el momento en que se ejecuten las instrucciones. Por
# ejemplo:

edad <- function(x) {
  texto <- paste("Vengo de Melmac, tengo", x, "años.\n")
  cat(texto)
}

edad(220)
# Vengo de Melmac, tengo 220 años.
edad("cuarenta")
# Vengo de Melmac, tengo cuarenta años.

# Como se puede ver en el ejemplo, la "x" usada por la función toma el
# valor que el usuario decide darle. Si el usuario no da valor alguno, R
# va a indicarlo con un mensaje de error:
edad()
# Error in paste("Vengo de Melmac, tengo", x, "años.\n") : 
#   argument "x" is missing, with no default
# Muy acertadamente, R nos indica que está faltando el argumento "x", el
# cual no tiene valor por defecto.

# Salida:
# Toda función devuelve algo, ya lo dijimos, y por defecto, ese algo es
# el último objeto generado dentro de las instrucciones. Para el caso de
# la función "alf", esto será la frase "¡No hay problema!" (es lo que
# devuelve la función print), y para el caso de "edad", será NULL, que es
# lo que devuelve la función cat. Más abajo se muestran otras formas de
# definir la salida de una función.

# El lector atento habrá notado que se usaron las llaves "{" "}" la
# última vez. Si estas no se usan, el R interpreta que la función se
# termina con el primer comando de las instrucciones (ver más abajo). La
# utilidad de las llaves consiste en poder usar varios comandos dentro de
# la función, indicando el comienzo y el fin de los mismos.

# Un detalle importante es que las instrucciones de la función se
# ejecutan en un "ambiente paralelo" a nuestra área de trabajo, por lo que
# es fundamental tener claro qué objetos están presentes en este
# ambiente. Por ejemplo, en la función "edad" los objetos "x" y "texto"
# existen dentro del ambiente de la función y toman valores particulares a
# raíz de las instrucciones de la función y de los valores ingresados por
# el usuario. En nuestra área de trabajo puede existir un objeto llamado
# "x", sin embargo esto no va a afectar el resutlado del comando "edad(4)",
# ya que dentro de la función "x" toma el valor 4.

# Los objetos que existen dentro del ambiente de la función son:
# 1- los que están definidos como argumentos de la función (dentro del
#    paréntesis). En el ejemplo anterior sería "x".
# 2- los que están definidos dentro del código de la función, a
#    través de las instrucciones. En el caso anterior, el objeto "texto"
#    tiene estas características.
# 3- los que estaban definidos en el área de trabajo en el momento en que
#    fue definida la función, siempre y cuando no se genere otro objeto
#    con el mismo nombre con las instrucciones. En el ejemplo visto caso no
#    hay ningún caso de este tipo de objetos que usemos, pero al final de
#    la lección ponemos una modificación como ejemplo.
# Este ambiente paralelo sólo existe durante la ejecución de la
# función, antes y después todos los objetos (excepto los que cumplen con
# la condición 3) van a estar ausentes de nuestra área de trabajo. 

# Estas reglas no se aplican para objetos de la clase "function", es
# decir, funciones: las mismas siempre existirán dentro de nuestra
# función, siempre y cuando hayan sido definidas de antemano.


# La principal ventaja de las funciones, como ya hemos planteado
# anteriormente, es juntar una serie de instrucciones, de la complejidad
# que sea, para poder ejecutarlas en una sola línea de código. Esto
# significa que si tenemos que repetir varias veces una serie de
# instrucciones siguiendo una determinada secuencia, podremos hacerlo
# escribiendo una función, la cual estará disponible para reutilizar cuando
# la necesitemos, cambiando los argumentos.

# Un ejemplo muy simple:
sinexp <- function(x, a=1, b=0.1)
  sin(a * x) * exp(x ^ b)

# Aquí el último objeto generado es el resultado de la ecuación escrita,
# por lo que esta es la salida de la función.

# Esta función tiene una sóla instrucción, la cual se pone (generalmente)
# en la segunda línea y con una indentación.
# Tiene 3 argumentos: x, a y b. Los dos últimos tienen agregada la
# asignación de un valor, a través del "=": esto indica que "a" y "b"
# tienen valores por defecto 1 y 0.1, que serán los que R usará en caso de
# que el usuario no ingrese otros.

# Usando la función podemos evaluar la salida para distintas
# combinaciones de x, a y b:
sinexp(10) # evaluada para x=10
sinexp(1:10) # evaluada para todos los x=1, 2, 3, ..., 10
sinexp(seq(0, 5, 0.05))
# evaluada para una secuencia de valores (0.05 de distancia)
sinexp(seq(0, 5, 0.05), 2, 0.08) # a=2, b=0.08
curve(sinexp(x, a=2, b=0.08), to=30, n=1e4)
# hace una gráfica con la función


## Ejemplo: "error estándar".

# Un ejemplo "de libro": el cálculo del error estándar de un promedio, que
# es una función que no existe en el paquete básico de R.
# La ecuación para hacer eso es sd / (n - 1) ^ (1 / 2), donde 'sd' es el
# desvío estándar y 'n' la cantidad de observaciones.
# La función la vamos a escribir de la siguiente manera:
 
SEM <- function(datos, na.rm = FALSE) {
  if (na.rm)
    VAR <- datos[!is.na(datos)]
  else
    VAR <- datos
  SD <- sd(VAR)
  N  <- length(VAR)
  SD / sqrt(N - 1)
}
 
# Pero mejor vamos a explicar bien cada una de sus partes:
 
SEM <- function(datos, na.rm = FALSE) {
# Primer línea:
# - Asignamos la función al objeto 'SEM'.
# - También escribimos los argumentos de la misma, que van a ser un objeto
#   'datos' (el cual debe ser del tipo vector) y un objeto lógico 'na.rm'
#   (para definir si se remueven los NA de 'datos'). Este argumento por
#   defecto será FALSE.
# - Ponemos la llave de apertura "{", para indicar el comienzo de las
#   instrucciones
# Los argumentos pueden ser objetos de cualquier clase y deben ir
# separados por comas.
  if (na.rm)
  # Aquí van las instrucciones que se ejecutan si na.rm es TRUE, es decir,
  # si decidimos remover de la muestra los NA (es una sóla instrucción).
    VAR <- datos[!is.na(datos)]
    # Crea, dentro del espacio de la función el objeto 'VAR', que no es
    # otra cosa que 'datos' con los NA extirpados.
  else
    VAR <- datos   # Instrucciones por defecto ('else', es el alternativo
                   # al 'if'), donde 'VAR' va a ser simplemente los datos
                   # de la entrada.
  # Nota: se va a profundizar en el uso de if/else en otras lecciones del
  # curso, bajo el tema "Estructuras de Control".
  SD <- sd(VAR)    # Calculamos el desvío estándar de 'VAR'
  N <- length(VAR) # 'N' va a ser la cantidad de observaciones que tenemos
  SD / sqrt(N - 1) # Y, finalmente, introducimos la ecuación de la que
                   # partimos.
}
# Y cerramos la llave, indicando el fin de las instrucciones.

# Nota: el último objeto generado en esta función es el producto de la
# ecuación del error estándar, por lo cual esta es la salida de esta
# función. Alternativamente, se puede usar el comando "return(out)", en
# donde "out" es el objeto que queremos que sea la salida de la función.
# Usando este comando, es posible definir la salida de la función en
# cualquier parte de las instrucciones y no necesariamente en la última.
# De hecho, cuando se ejecuta "return" se dejan de ejecutar instrucciones
# y se devuelve el objeto indicado. Una función similar es "invisible",
#  cuya única diferencia es que no imprime por defecto el resultado en la
# consola al terminar la ejecución de la función.
 
# Ahora vamos a probar nuestra función, para lo que vamos a crear un
#  objeto 'x' que consiste en una serie de observaciones de alguna
# variable aleatoria.
 
x <- sample(1:100, 25, replace = T)

SEM(datos = x)
 
# Ahora vamos realizar un cambio en 'x', introduciendo algunos NA.
 
x[c(2,5,12,25)] <- NA
 
# Y volvemos a ejecutar 'SEM' para 'x', lo que da un resultado "feo":
 
SEM(datos = x)
 
# Para arreglar este asunto, vamos a indicarle en los argumentos que no
# debe tener en cuenta los NA de 'x'.
 
SEM(datos = x, na.rm = TRUE)
 
# Y volvemos a tener un resultado.

 
## Ejemplo: el argumento especial "..."

# Considerando una función simple que grafica una curva logística,
# incluimos el argumento "..." de esta manera:
logi <- function(ini=-8, fin=8, int=0.05, ...) {
  x <- seq(ini, fin, by=int)
  y <- exp(x) / (1 + exp(x))
  plot(y ~ x, type='l', ...) # acá también se agrega "..."
  return(y)
}
logi()
 
# La lista de argumentos contiene "...", el cual se repite dentro del
# llamado a la función plot. Esto permite pasar argumentos a la función
# plot sin que estén definidos de antemano, usando el nombre del argumento
# en el momento de llamar a la función logi. Por ejemplo, los argumentos
# "col", "lwd", "ylab" y "main" se pueden agregar:
x <- logi(-15, 15, col="blue")
x <- logi(-15, 15, col="blue", lwd=4)
x <- logi(-15, 15, col="blue", lwd=4, ylab="Curva Logística")
x <- logi(-15, 15, col="blue", lwd=4, main="Curva Logística", ylab='f(x)')
 
# El mismo principio se puede aplicar a cualquier función.

 
# Como hemos visto las distintas funciones permiten ejecutar una serie de
# instrucciones que requieren ser evaluadas en una determinada secuencia,
# pero reduciendo considerablemete el espacio utilizado y perimitiendo
# reutilizar la función, una vez guardada el área de trabajo o el script
# en que la definimos. Las funciones que creamos no quedan incorporadas a
# R en sí, sino que las vamos a tener que volver a cargar para volver a
# utilizarlas. De todos modos simplifican mucho el trabajo cuando debemos
# realizar tareas que requieren varias instrucciones, sobre todo si
# tienen una cierta complejidad.

# Una estrategia muy útil es guardar las definiciones de las funciones
# que hemos creado en scripts. Se pueden agrupar varias definiciones en un
# mismo archivo, particularmente si son funciones que están relacionadas
# (pueden depender unas de otras, por ejemplo), de forma que cada archivo
# es una "biblioteca" de funciones. En el momento de iniciar la sesión de
# R basta con usar la función "source" para traer la biblioteca al área de
# trabajo, por ejemplo:
source("/camino/hacia/el/script.R")

# El archivo "estimaPi.R" es un script con 2 funciones incluidas que
# ilustra esta idea.

# Como comentario final, no hay una receta universal para escribir
# funciones, pero hay algunas recomendaciones que facilitan mucho la
# tarea:

# 1- Hacer un esquema previo de qué es lo que queremos de nuestra función
# 2- En este esquema previo armar la secuencia de comandos en el orden que
#    deberían ejecutarse.
# 3- Tratar, en la medida de lo posible, que las funciones utilizadas sean
#    las opciones más 'económicas' en memoria y procesador para realizar
#    la tarea deseada: si armamos un tándem de funciones muy demandantes
#    el resultado va a ser un monstruo devorador de recursos.
# 4- Intentar probar varias veces con datos artificiales (y sobretodo con 
#    errores artificiales) nuestra función para comprobar que anda bien.
# 5- Armar el script siguiendo las recomendaciones de estilo, ya que
#    además de facilitar la colaboración con los colegas sirven
#    fundamentalmente para identificar fácilmente los comandos que puedan
#    estar funcionando mal.
# 6- Utilizar herramientas de depuración (ver la lección correspondiente)
#    ayuda a descubir los errores de programación.
# 7- La práctica hace al maestro. No frustrarse si las funciones no nos
#    quedan bien de entrada.


##########################
# Apéndice: se muestra un ejemplo de una función con un objeto presente en el
# ambiente de la misma, a pesar de estar definido por fuera de las
# instrucciones y los argumentos:
y <- 5
edad <- function(x) {
  texto <- paste("Vengo de Melmac, tengo", x, "años y", y,"meses.\n")
  cat(texto)
}

edad(8)
# Vengo de Melmac, tengo 8 años y 5 meses.

# Como se puede ver, el objeto "y" es usado por la función para completar la
# frase de salida.
