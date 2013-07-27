Lista de ideas y/o apuntes generales de cosas a mejorar
=======================================================

* De ahora en más **pueden** modificar el código fuera de los límites, pero avisamos que para la corrección **todo lo que está afuera se descarta**.

(Tal vez:
* Agregar el uso de "nombres de usuario/emails" en la función `evaluar`. Ej:

    username <- function() {
      cat("Ingrese su nombre de usuario por favor: ")
      usname <- readLines(n = 1)
      cat("Ingrese su password: ")
      pw <- readLines(n = 1)
      cat("Ingrese su e-mail: ")
      email <- readLines(n = 1)
      list(username = usname, password = pw, email = email)
    }
)

* *Aclarar desde el principio que el sistema de corrección puede necesitar fixes*!!!!!!.

* Agregar ejercicios en funciones, más simples y más diversos:
  - cambiar última y primer fila de una matriz;
  - ordenar una matriz según los valores de cualquier columna, según número o nombre.

* Ejercicio de programación:
  - for: hacer un script que cuente por fila de una matriz la cantidad de elementos que cumplan una condición (mayores que 0, por ejemplo)

* Cambiar parte d del útimo parcial: si el bus tiene el máximo de pasajeros no sube a más nadie y si tiene el mínimo (0) no baja nadie.

* Poner lugar para que pongan el nombre en los parciales o cualquier script de ejercicios...

* > As someone said, if you want to understand something, explain it to another person, but if you really want to understand it, explain it to a computer.  ("Si quieres entender algo, explícaselo a otra persona, pero si realmente quieres entenderlo, explícaselo a una computadora.")

* Agregar la función "stack" en la parte de manipulación de datos.

* [Para la idea del paquete imser, aprovechar que ahora .Rprofile y .Renviron funcionan en windows! (tienen que ir en ~)(ver: http://www.biostat.wisc.edu/~kbroman/Rintro/). De esta forma se puede agregar fácilmente un path determinado (o cambiarlo cuando sea necesario) para la carpeta del curso.]

* En ejercicio 6 del cuestionario 6.2 (el de los gatos) y en general en ese tipo de ejercicio (relleno), utilizar errores más comunes del 2012 para anticipar respuestas equivocadas y dar un feedback!

* Mensajes de error: cambiar "no es el valor correcto" por "no es el valor esperado", en todos los casos que esto aplique.

* INSISTIR MUCHO, POR EJEMPLO EN LA LETRA DE REPARTIDOS, CON LO DE LAS SOLUCIONES GENÉRICAS!!! (SOBRE TODO EN EL REP 1)
  El año que viene debería haber una lección "cómo hacer el repartido"!!

* Recomendar que tengan una configuración de teclado fácil (que los símbolos que se ven en las teclas son los que se escriben en la consola). Esto se puede agregar en alguno de los documentos de guía del curso.

* También estaría bueno unificar todos los documentos de guía.

* Foro: decirles que escriban el código en el foro, pero que después lo borren si está la duda solucionada.

* Unificar todos los documentos en 1!

* Lista de estándares:

  - mensajes de aviso o error deben empezar con minúscula y sin espacios al principio. si son de warning debe indicar el número de ejercicio ("ej. 1.a: se detectó un problema con ...").
  - los archivos de los ejercicios deben empezar con el número de ejercicio: 1.a-aprobados.R

* Aclarar mejor el uso de is.na, is.null e is.nan

* Aclarar en las letras de los repartidos que muchas cosas que se piden son para que funcione bien la correción automática. Esto sobre todo con el repartido 1. Se agregaría al video y la lección que se va a hacer (mejorar) para repartidos.

* Mejorar corrección del 1.b del repartido 4: http://imser2013.ribbot.com/posts/51b0ecac203f03000200065d

* Aclarar que en los videos no va a estar todo para que resuelvan los repartidos; tienen que indagar en la ayuda u otras fuentes (foros, google, etc)

* Diversificar las aplicaciones de los repartidos (ej: ejemplos relativos a sociología; se puede preguntar a exestudiantes a ver si se quieren colaborar elaborando problemas nuevos).

### Unidad 5

* Agregar en la unidad 5 (funciones) cuestionarios más parecidos a los de la unidad 6 (aquellos en los que hay que agregar errores, fill in the blanks, etc).

* Chequear que en ejercicios anteriores el estudiante haya hecho bien las funciones para usar sus versiones en los subsiguientes (ej: funciones filtroc y aplicar en 2.c).

* Nuevo ejercicio: 2.d "gráficos personalizados". Ver los archivos tmp.Rmd y 2.d-plot.edu.R

### Unidad 6

* Ejercicio 2.a del repartido... ver http://imser2013.ribbot.com/posts/51d334917b0a57000200067b

Para el final del curso
-----------------------

* Hacer una encuesta a parte de la evaluatoria final con las siguientes consultas y afines:
	- ud. le gustaria que el curso dure menos tiempo ?
	- ud. considera que hubiera podido realizar los modulos en una semana ?
	- ud. considera que si le dan dos semanas por modulo pero es capaz de realizarlo en una, utilizaría igualmetne las dos semanas?


Nuevo Repartido I:
==================

- No tendrá nota. Es decir, no se usará esa nota en el cálculo de la nota final.
- Será más un tutorial que un repartido.
- Tendrá las soluciones en escrito y en video. El video será además una demostración de cómo usar la interfaz de RStudio (es redundante con la lección 1.2?).
- Los ejercicios existentes del repartido I los repartimos entre el nuevo repartido I y el repartido II (o incluso otros?).

## Tutorial tentativo:

    # Elegir el directorio de trabajo:
    setwd("camino absoluto")

    # Explicar que ocurre con el camino relativo si lo queremos volver a utilizar.
    # Con RStudio: Ctrl + Shift + k. Nótese que el comando setwd aparece igualmente en la consola (abajo-izquierda) y además también aparece en la historia de comandos. Dicha historia se encuentra en el panel de arriba-derecha, en la pestaña "History". Esta historia es muy útil si queremos buscar y recuperar algún comando ejecutado hace un tiempo.

    # Primer comando (no escribir aún):
    mi.objeto <- 4

    # Dónde escribir el comando?
    # Opción 1: la consola de RStudio (abajo-izquierda; bajo el nombre "Console"). Sólo hay que dar enter al terminar de escribirlo. No hace falta que el cursor esté al final de la sentencia para dar el enter.

    # Opción 2: en el editor de texto plano de RStudio (arriba-izquierda). Primero debe iniciar un archivo nuevo: vaya a File >> New >> R Script (Ctrl + Shift + N), recién entonces será visible este panel. En RStudio este panel se llama "Source" (que significa fuente); es el código fuente con el que trabajamos en un momento dado. Como aún no guardamos el archivo, este figura bajo el nombre "Untitled1" (Sin título 1).
    
    # En general preferimos la segunda opción. Escribir los comandos en el editor nos permite guardar todo lo que hacemos, de forma que se puede repetir en el futuro.

    # A continuación, escriba nuestro primer comando, primero en la consola, dando enter al final para que se ejecute, y luego en el Source (editor de texto):
    mi.objeto <- 4

    # Nota: ponga los espacios en blanco también; no afectan al comando, pero facilitan la lectura.

    # Debido a que usted le dió enter al comando en la consola, ahora en su sesión existe un objeto llamado `mi.objeto`. Puede ver una lista de los objetos que existen en el panel de arriba-derecha, bajo la pestaña "Workspace" (área de trabajo).
    # También puede ver una lista de objetos existentes con el comando `ls`: escriba en la consola
    ls()

    # Como se dijo antes, preferimos usar el editor para escribir nuestros comandos, ya que nos permite repetirlos fácilmente. En RStudio se pueden ejecutar directamente los comandos escritos en el editor de texto plano. Hay que ubicar al cursor en la línea que nos interesa y apretar las teclas Ctrl + Enter (en simultáneo). Haga la prueba con la línea `mi.objeto <- 4`.

    # Al usar Ctrl + Enter podemos ver que aparece la misma línea en la consola y se ve así:
    > mi.objeto <- 4
    >

    # Al ver esto tenemos la información necesaria para saber que el comando ya fue ejecutado, ¿cómo? gracias a la existencia del "command prompt", el pequeño signo de `>` que aparece al principio de cada línea en la consola.

    # El command prompt sólo que aparece en la última línea es un indicador de que R ya terminó de ejecutar todo lo que se le pidió anteriormente. Es una forma de decir "estoy listo para recibir órdenes". Considere ahora las diferencias entre encontrar esto en la consola:
    > mi.objeto <- 4
    # y esto:
    > mi.objeto <- 4
    >

    # En el primer caso el comando `mi.objeto <- 4` aún no se ejecutó, mientras que en el segundo sí. ¿Se ve la diferencia?

    # Un error muy común de principiante es el de copiar líneas de comando incluyendo el command prompt al principio. Al tratar de ejecutar estas líneas surge un error que difícilmente pueda comprender el usuario, ya que como se dijo es un principiante. Es buena idea ver un ejemplo de este error: agregue un command propt al principio de nuestro comando, de forma que quede así: "> mi.objeto <- 4" (sin las comillas). Ahora envíe esta línea a la consola (ponga el cursor en esa línea y aprete Ctrl + Enter). Vea el mensaje de error que devuelve R:

    > > mi.objeto <- 4
    Error: unexpected '>' in ">"

    # Nota: puede que el mensaje esté en español en su PC, dependiendo del idioma en el que haya instalado R.
    # Borre el command prompt que acaba de agregar para evitar errores futuros.

    # El command prompt es entonces una indicación útil, pero también molesta. Muchas veces en libros o páginas web se muestran comandos de R que empiezan con el command prompt, lo cual es muy desconsiderado, ya que el usuario debe encargarse de borrar manualmente cada uno antes de poder reproducir los ejemplos.

    # El command prompt tiene otra variante, el signo de `+`. El significado es diferente, indica que los comandos anteriores no están completos. Por ejemplo si escribo `mi.objeto <-` va a faltar algo. El 4 que usamos antes completaba a la sentencia. Haga el ejemplo, borre el 4 al final de nuestro comando y envíelo a la consola de R. Puede ver que en la misma aparece lo siguiente:
    > mi.objeto <-
    +

    # Esta es la forma de R de indicar que el comando no es completo. Le está diciendo al usuario "aún me falta algo para poder ejecutar sus órdenes, dígame ¿qué valor debo asignar a `mi.objeto`?". El usuario, usted, puede completar el comando sin problemas: vaya a la consola y escriba 4. Ahora de enter.
    > mi.objeto <-
    + 4
    >

    # También tiene la opción de interrumpir el comando y volver al command prompt normal. Alcanza con ir a la consola y apretar la tecla de escape (Esc). En este caso se ve así en la consola:
    > mi.objeto <-
    + 4

    >

    # Pasaremos ahora a hacer cosas más elaboradas ...

    # Si no lo hizo antes, agregue al principio del script el comando que sirve para elegir el directorio de trabajo. Si usted usó los botones de RStudio (o la combinación Ctrl + Shift + k) de todas formas el comando aparece en la historia de comandos (arriba-derecha). Si no lo encuentra, use la lupa o buscador, que aparece en la pestaña History y escriba `setwd`, para filtrar la historia. Si selecciona con el ratón dicho comando, con el botón "To Source" puede enviar este comando al editor de texto; recuerde ubicarlo al principio del mismo, en la línea 1. Y recuerde que tampoco puede usarse un camino relativo aquí (más adelante se explica por qué).

    # De aquí en más agarrar algún ejercicio del repartido 1 y hacerlo paso a paso









