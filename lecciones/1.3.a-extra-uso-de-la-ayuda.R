#### Ayuda de R

## Como dijimos antes, la ayuda de R es una herramienta indispensable para la comprensión e
## interpretación de funciones y análisis estadísticos.

## Existen varias formas de acceder a la ayuda de R.
## La primera es consultar la ayuda en forma general. Para ello, ejecutamos el comando
help.start()
## Esto abre la ayuda de R en nuestro navegador predeterminado si estamos trabajando en R, o en
## la pestaña "Help" si estamos trabajando en RStudio.
## En la ayuda general de R vamos a encontrar varias opciones, agrupadas bajo 4 grandes títulos:
## Manuals,
## Reference,
## Miscellaneous material, y
## Material specific to the Windows port (supongo que habrá un equivalente para usuarios Linux o Mac)

## Bajo el título de "Manuals" vamos a encontrar seis manuales de referencia sobre diferentes
## aspectos de R.
## El manual "An introduction to R" es un manual de referencia del funcionamiento de R.
## Es el manual con mayor utilidad inmediata para los usuarios.
## El resto de los manuales son sobre temas más específicos, como escribir extensiones para R,
## instalación y administración, importar y exportar datos, y R internals, que trata sobre funciones
## que se programan fuera de R para configurar aspectos del funcionamiento general del mismo.

## Bajo el título de "Miscellaneous material" vamos a encontrar datos sobre la versión de R que
## estamos usando, sus autores, licencias, FAQ, etc.
## El título al que más comunmente vamos a acudir como usuarios es el de "Reference", y
## particularmente al subtítulo "Packages".
## En éste apartado (seguir el link de "Packages") vamos a encontrar información sobre los paquetes
## instalados en R.
## (recordar: cada paquete es una colección de funciones para realizar actividades específicas en R).
## Vamos a cliquear en el link del paquete "base", que es el paquete de funciones básicas, más
## elementales de R, y del que dependen todos los demás paquetes para su funcionamiento.
## Este paquete se instala por defecto al instalar R.
## Dentro de la ayuda de este paquete vamos a encontrar toda la documentación del mismo.
## En primer lugar, vamos a encontrar un link que dice "Description file", en el que brinda
## información acerca de este paquete.
## Un poco más abajo vamos a encontrar un link, "base-package", donde se brinda una información
## un poco más detallada de las utilidades del paquete "base":
## En el extremo superior izquierdo está la función y entre llaves el paquete al que pertenece
## Luego viene el título del documento: "The R Base Package"
## Luego viene una descripción (mínima) de qué se trata el mismo
## Y finalmente detalles de qué es lo que tiene este paquete, con una instrucción final de cómo
## obtener una lista de sus funciones.

## Todos los paquetes tienen un documento de ayuda de este tipo, describiendo sus utilidades y
## para qué fueron creados.

## Volvamos a la ventana anterior (hacia atrás en el navegador o con las flechas arriba a la
## izquierda en la pestaña de RStudio)

## Vamos a buscar la ayuda de una función conocida, la que utilizamos para calcular anteriormente
## los valores y vectores propios.
## La función "eigen" pertenece a este paquete de funciones básicas de R, así que la vamos a buscar
## en esta ventana y cliquear el link.

## En el extremo superior izquierdo aparece nuevamente la función y el paquete entre llaves.
## El título de la función es "Spectral decomposition of a matrix".
## En la descripción dice que computa los valores y vectores propios de matrices reales o complejas
## Aquí aparece un ítem nuevo: Usage.
## En este está escrita la función y todos sus argumentos, con sus opciones por defecto (las que
## se asumen si no fueron especificadas)
## A continuación aparece la lista de argumentos necesarios para correr la función y sus posibles
## valores. En este caso se trata de la matriz cuyos valores y vectores propios queremos conocer,
## si es una matriz simétrica, "only.values" se utiliza si sólo queremos obtener los valores
## propios (por defecto es FALSE) y EISPACK especifica una rutina de cálculo compatible con versiones
## anteriores de R.
## En "Details" se dan detalles sobre los mismos argumentos y qué ocurre según utilicemos diferentes
## opciones de los mismos.
## "Values" indica la salida de la función una vez ejecutada. En este caso nos dice que la misma
## devuelve una lista con dos elementos: un vector con los valores propios, y una matriz cuyas
## columnas son los vectores propios correspondientes.
## Luego viene una lista de referencias bibliográficas, una sugerencia de funciones relacionadas y un
## ejemplo de uso de la función.

## Bueno, hasta ahora vimos una forma de acceder a la ayuda de una función que nos interese. Vimos el
## camino largo, según el cual tenemos que conocer por lo menos a qué paquete pertenece nuestra
## función ("base", en el caso de "eigen").
## Si conocemos el comando de la función y queremos acceder a la ayuda en forma inmediata, podemos
## intentar:
help(eigen) # o sino:
?eigen
## Ambas opciones nos llevan rápidamente a la ayuda de funciones cuyos paquetes estén en uso. Esto es
## importante, ya que a veces podemos querer acceder a la ayuda y nos va a devolver que no está
## disponible, por ejemplo:
?rgl
## En este caso, podemos ejecutar la función "help.search", especificando el patrón de texto "rgl":
help.search("rgl") # o sinó:
??rgl
## Este comando realiza una búsqueda de esa palabra en títulos, conceptos o alias de funciones.
## Se le puede especificar también el uso de aproximaciones al texto buscado (fuzzy matching).

## O podemos buscar en la base de datos de ayuda online o ducomentos en la página de R, usando el
## motor de búsqueda de http://search.r-project.org.
RSiteSearch("rgl")

## Si ya abrimos el paquete "rgl", ejecutando el comando:
library(rgl) # o seleccionándolo de la lista de paquetes en RStudio, mediante el uso de:
help(rgl) # o
?rgl
## vamos a poder encontrar la ayuda que estábamos buscando.
## Donde dice que "rgl" es un paquete que podemos utilizar para hacer gráficos en 3 dimensiones.

## Otros elementos acerca de los que podemos encontrar ayuda, además de los paquetes y las funciones,
## es sobre las clases de objetos
?matrix
## Donde nos da detalles acerca de las funciones útiles para crear, transformar en o consultar acerca
## de la identidad de los objetos de las diferentes clases.

## Una observación final: si ejecutamos el comando
help()
## no se abre la ventana inicial de la ayuda, sino que nos envía a la ayuda de la función "help".
