## Anatomía de las funciones

# En esta lección vamos a explorar las distintas partes que componen una función.

# Componentes de una función
# 1- Argumentos formales o parámetros formales (formals)
# 2- Cuerpo de la función
# 3- Ambiente de la función

# Para comprender mejor estos componentes, empecemos por definir una función 'f'
# bien sencilla:

f <- function(a, b = 5, ...) { # a partir de dos variables 'a' y 'b'
  x <- a * b + w               # se crea un objeto 'x' y
  x / 2                        # la función devuelve el valor de 'x' dividido
}                              # entre 2.
w <- 24  # Vamos a definir también un valor 'w', que vamos a usar más adelante.

# 1- Argumentos formales
# Los argumentos de una función son los valores que nosotros podemos manipular
# en la entrada al ejecutar la misma. Vamos a distinguir entre los argumentos
# formales y los argumentos reales (actual arguments). Los primeros son los que
# componen la función como nosotros la definimos. Indican qué valores vamos a
# tener que definir para ejecutar la misma y muchas veces van a tener valores
# por defecto. Veamos cuáles son estos argumentos formales en nuestra función:

formals(f)

# Este comando devuelve una lista de los argumentos formales de cualquier
# función. En nuestro caso, nos dice que los argumentos formales de la función
# f son a y b, indicando además que b tiene un valor por defecto de 5.
# Los argumentos reales, o actuales, son los valores que le vamos a dar a los
# argumentos formales al ejecutar la función. Intentemos correr nuestra función
# con a = 2 y b = 4.

f(2, 4)

# Como dijimos antes, el argumento formal b tiene un valor por defecto por lo
# que, si no nos interesa darle un valor particular, podemos dejarlo sin asignar
# y la función va a utilizar ese valor.

f(2)

# 2- Cuerpo de la función
# El cuerpo de una función es el conjunto de las instrucciones que se van a eje-
# cutar al llamar a la función. En nuestra función, podemos ver el cuerpo de la
# misma, mediante el comando 'body'.

body(f)

# 3- Ambiente de la función
# Este es el componente de las funciones que requiere más explicación, ya que es
# el componente más abstracto de las mismas.
# El primer componente del ambiente de una función es el marco (frame) de la
# misma, y está compuesto por el conjunto de objetos presentes en R en el
# momento que la función es creada. El marco del ambiente de nuestra función
# está compuesto por los objetos presentes en el área de trabajo y los objetos
# de los paquetes cargados. A los primeros podemos consultarlos mediante 'ls'
# y a los segundos mediante 'search'

ls()      # Que nos devuelve los objetos que tenemos asignados
search()  # Que nos devuelve '.GlobalEnv' y cada paquete actualmente cargado

# '.GlobalEnv' es el ambiente correspondiente al interpretador de R, a la línea
# de comando. La función 'environment', aplicada a una función, nos dice en qué
# ambiente fue creada la misma.

environment(f)

# Nuestra función fue creada directamente en el nivel superior, R_GlobalEnv,
# que corresponde a la línea de comando de R, pero veamos que ocurre con alguna
# función, por ejemplo 'mean'.

environment(mean)

# Esta función fue creada dentro del ambiente correspondiente al paquete 'base'.
# Los ambientes están organizados en forma jerárquica dentro de R, de modo que
# el funcionamiento de cualquier función depende de que los objetos a los que
# refiere se encuentren en el ambiente en que fue definida o en uno superior,
# hasta R_GlobalEnv, que es el ambiente parental a todos. Esta pertenencia
# jerárquica entre ambientes es lo que se denomina el enclosure, y es el segundo
# componente del ambiente. Si una función depende de un objeto externo para su
# funcionamiento, éste deberá estar en el ambiente en que fue definida o en
# ambientes parentales a éste. Como ejemplo, veamos qué sucede con nuestra
# función si eliminamos el objeto 'w' que habíamos creado al principio.

rm (w)
f(2, 4)

# El objeto 'w', al que se hace referencia en el cuerpo de 'f', fue removido del
# ambiente de ésta (del marco, concretamente), por lo que ahora no puede correr.
# Volvamos a definirlo para seguir adelante.

w <- 24

# Además, cuando se corre una función se crea un ambiente dentro de la misma,
# que es transitorio y sólo existe mientras la función esté corriendo. En este
# ambiente se van a ejecutar las instrucciones del cuerpo de la función y no es
# accesible desde el workspace, sino que corre en paralelo. El objetivo de esta
# separación, es evitar siempre que sea posible que una función modifique alguna
# variable de la propia sesión. Es decir, pase lo que pase dentro de la función,
# no se van a afectar los objetos que se encuentran en nuestra área de trabajo.
# Si recordamos, en el cuerpo de nuestra función una de las instrucciones crea
# un objeto 'x'. Veamos qué sucede al correr esta función si tenemos un objeto
# llamado 'x' en el área de trabajo.

x <- 1:5
f(3, 4)
x

# El objeto 'x' de nuestra área de trabajo no fue modificado.
# Este territorio puede parecer confuso, por lo que sugiero que experimenten
# hasta entenderlo bien. A modo de guía, veamos la lista de objetos visibles
# para una función de R.
# - objetos definidos en los argumentos
# - objetos creados en el cuerpo de la función (hasta acá son los
#   pertenecientes al ambiente de la propia función).
# - objetos existentes en ambientes "parentales" (todos los "antepasados").

# Para entender un poco mejor esto, nótese que el objeto 'w', definido en para-
# lelo a nuestra función 'f', no es parte de los argumentos, y no está definido
# en el cuerpo de 'f'. El 'w' es usado dentro de la función para calcular 'x'
# (el 'x' del cuerpo de 'f', no el que definimos en el workspace). De hecho, si
# cambio a 'w' el resultado de evaluar 'f' será distinto.

f(3, 4)
w <- 1:5
f(3, 4)

# Esperando que esta lección complemente en buena forma lo visto en el video, la
# próxima lección será acerca de la salida de las funciones.
