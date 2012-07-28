### Funciones
 
## Otro tipo de objetos que vamos a encontrar en R son las funciones.
## Una función es una serie de instrucciones especificadas en uno o más objetos, que pueden ser interpretadas
## y ejecutadas en el entorno de R.
## Se utilizan principalmente para ejecutar tareas que ejecutadas de otra manera llevarían varios pasos, o generarían 
## una cantidad indeseada de objetos intermedios, como subproductos de la ejecución en varios pasos.
 
## Un ejemplo de función es la que utilizamos anteriormente para calcular los valores y vectores propios de una matriz.
class(eigen) # esto devuelve "function"
## En este caso es una función predefinida en R
 
## Para ejemplificar el uso de funciones, vamos a crear una que automatice el cálculo de los valores y vectores propios
## de una matriz y le cambie los nombres a los elementos de la salida correspondiente a sus equivalentes en español.
 
## Empezamos definiendo una matriz cualquiera, cuadrada (igual cantidad de filas que de columnas).
x <- matrix(1:25, 5, 5) # Nota: la definimos acá, pero pueden dejar para definirla más adelante
 
## Si usamos eigen de la siguiente manera:
a <- eigen(x)
## y le pedimos los nombres de los elementos de "v" nos da:
names(a)
#[1] "values"  "vectors"
 
## Pero queremos que el resultado sea:
#[1] "valores"  "vectores"
 
## Para esto vamos a crear una función que se va a llamar "propios"
 
## Teniendo definida nuestra matriz, vamos a definir la función. Capaz que de entrada puede parecer un poco cuesta arriba ahora,
## pero es una función sencilla con comandos que ya hemos visto anteriormente y ver esto ahora va a facilitar la interpretación
## de contenidos posteriores en el curso.
 
## La idea es armar una función con varias instrucciones que vimos en el apartado de nombrar elementos en diferentes
## tipos de objeto. Ya sabemos qué hacen las funciones "eigen", "names", "colnames" y "rownames", así que no hay nada
## demasiado complicado, o no debería haberlo.
 
## En forma compacta, la función se define así:
propios <- function(matriz) {
  a <- eigen(matriz)
  names(a$values) <- 1:length(a$values)
  names(a) <- c("valores","vectores")
  colnames(a$vectores) <- 1:nrow(a$vectores)
  a
}
 
## Pero vamos a verlo paso por paso, con un poco de explicación:
propios <- function(matriz) { # Primero especificamos que "propios" (tal va a ser el nombre de nuestra función) va a ser
  ## una función. Entre paréntesis van a ser los argumentos de la función, o sea, lo que necesita ser especificado 
  ## para que ésta funcione. En este caso una matriz. La llave inicial "{" se pone para especificar que van a haber una serie de
  ## instrucciones internas a la función. Está cerrado al final de la misma.
 
  ## Vamos a crear dentro de la función un objeto "a", al que vamos a asignar la salida de la función "eigen", con los 
  ## vectores y valores propios de la matriz que especifiquemos al ejecutar nuestra función.
  a <- eigen(matriz) ## Recordar que la salida de esta función es una lista.
 
  ## Numeramos los elementos del vector de valores propios desde 1 hasta cuantos tenga.
  names(a$values) <- 1:length(a$values) # La función "length" devuelve la longitud de un vector o lista
 
  ## Vamos a sustituir los dos elementos de la lista "a", con sus equivalentes en español.
  names(a) <- c("valores","vectores")
 
  ## Y ya que estamos, renombramos las columnas de "vectores" numerándolos también desde 1 hasta las que haya.
  colnames(a$vectores) <- 1:ncol(a$vectores) # La función "ncol" devuelve la cantidad de columnas de una matriz o data.frame
 
  ## La última instrucción de nuestra función va a tener que ser el objeto que queremos que devuelva la salida, en este caso:
  a # Este objeto no va a quedar en el área de trabajo, ya que está definido dentro del ambiente de la función.
    # Cuando veamos más formalmente las funciones esto va a ser más claro.
}
 
## Si copiamos y pegamos en R las líneas que van desde "propios" hasta el cierre de la llave "}", vamos a definir en R
## la función "propios", que calcula valores y vectores propios y sustituye o crea nombres de algunos de sus elementos.
 
## La clase de "propios" es "function"
class(propios)
 
## Ahora vamos a poder realizar estas tareas (calcular valores y vectores propios y sustituir esos elementos), para las que
## utilizábamos previamente 4 pasos (eigen y los 3 cambios de nombres), en uno solo:
propios(matriz=x) # Ejecutamos la función que definimos, especificando que la matriz (el argumento de esta función) es "x",
  # que es la que definimos anteriormente. La salida son los valores y vectores como vimos, con sus títulos en español y 
  # sus elementos numerados
 
## Podemos definir otra matriz y correr nuestra función y va a funcionar también
y <- matrix(1:4, 2, 2)
propios(matriz=y) # O simplemente:
propios(y) # La función tiene un solo argumento, por lo que en este caso no hace falta especificar cuál es el que lleva el valor "y"
 
## Vimos entonces que las funciones son una clase de objeto es de una utilidad enorme, ya que una sóla función resume 
## una serie de pasos más larga (tanto como sea necesario para ejecutar una determinada tarea).
