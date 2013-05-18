Lista de ideas y/o apuntes generales de cosas a mejorar
=======================================================

* Mejorar los ejercicios de corrección, al menos de los repartidos I y II, poniendo mensajes de error más específicos (se empezó a implementar en rep III).

* Ídem con la función `reload` del rep III.

* Mejorar lecciones extras en general.

* Capaz que sacar puntaje negativo a respuestas incorrectas de cuestionarios?.

* Leer preguntas de foro que puedan ayudar a mejorar los cuestionarios.

(Tal vez:
* Agregar el uso de "nombres de usuario/emails" en la función `evaluar`. Ej:
```r
username <- function() {
  cat("Ingrese su nombre de usuario por favor: ")
  usname <- readLines(n = 1)
  cat("Ingrese su password: ")
  pw <- readLines(n = 1)
  cat("Ingrese su e-mail: ")
  email <- readLines(n = 1)
  list(username = usname, password = pw, email = email)
}
```
)

* Agregar ejercicios en funciones, más simples y más diversos:
  - cambiar última y primer fila de una matriz;
  - ordenar una matriz según los valores de cualquier columna, según número o nombre.

* Ejercicio de programación:
  - for: hacer un script que cuente por fila de una matriz la cantidad de elementos que cumplan una condición (mayores que 0, por ejemplo)

Para 2013
---------

Cambiar parte d del útimo parcial: si el bus tiene el máximo de pasajeros no sube a más nadie y si tiene el mínimo (0) no baja nadie.

Poner lugar para que pongan el nombre en los parciales o cualquier script de ejercicios...


> As someone said, if you want to understand something, explain it to another person, but if you really want to understand it, explain it to a computer.

> Si quieres entender algo, explícaselo a otra persona, pero si realmente quieres entenderlo, explícaselo a una computadora.

Agregar la función "stack" en la parte de manipulación de datos.

* Agregar en la unidad 5 (funciones) cuestionarios más parecidos a los de la unidad 6 (aquellos en los que hay que agregar errores, fill in the blanks, etc).

* [Para la idea del paquete imser, aprovechar que ahora .Rprofile y .Renviron funcionan en windows! (tienen que ir en ~)(ver: http://www.biostat.wisc.edu/~kbroman/Rintro/). De esta forma se puede agregar fácilmente un path determinado (o cambiarlo cuando sea necesario) para la carpeta del curso.]

* En ejercicio 6 del cuestionario 6.2 (el de los gatos) y en general en ese tipo de ejercicio (relleno), utilizar errores más comunes del 2012 para anticipar respuestas equivocadas y dar un feedback!


TAREAS (lista hecha el 7-3-2013 en la PUC):
===========================================

* Lista de dudas x unidad en el foro (Juan unidades 4-6, Carlita 1-3)

* Aclarar que en los videos no va a estar todo para que resuelvan los repartidos; tienen que indagar en la ayuda u otras fuentes (foros, google, etc)

* Diversificar las aplicaciones de los repartidos (ej: ejemplos relativos a sociología; se puede preguntar a exestudiantes a ver si se quieren colaborar elaborando problemas nuevos).

* Cuestionarios:
  - contenidos de las próximas lecciones?
	- mejorar la calidad en general (preguntas más interesantes, más claras; más preguntas en algunos casos que están muy cortos)
	- Determinar el número máximo de intentos para múltple opción?

* Para inicio del curso:
  - Video mostrando los puntos más importantes de la dinámica de las lecciones y cuestionarios
	- Video mostrando la dinámica de los repartidos (cómo llenar un script, dónde ejecutar los comandos, etc).

* Notas finales: N = 0.4 * C + 0.6 * R
(N: nota, C: promedio cuestionarios, R: promedio repartidos)



Para el final del curso
-----------------------

* Hacer una encuesta a parte de la evaluatoria final con las siguientes consultas y afines:
	- ud. le gustaria que el curso dure menos tiempo ?
	- ud. considera que hubiera podido realizar los modulos en una semana ?
	- ud. considera que si le dan dos semanas por modulo pero es capaz de realizarlo en una, utilizaría igualmetne las dos semanas?

* Mensajes de error: cambiar "no es el valor correcto" por "no es el valor esperado", en todos los casos que esto aplique.

* INSISTIR MUCHO, POR EJEMPLO EN LA LETRA DE REPARTIDOS, CON LO DE LAS SOLUCIONES GENÉRICAS!!!
  El año que viene debería haber una lección "cómo hacer el repartido"!!

* Recomendar que tengan una configuración de teclado fácil (que los símbolos que se ven en las teclas son los que se escriben en la consola). Esto se puede agregar en alguno de los documentos de guía del curso.

* También estaría bueno unificar todos los documentos de guía.

* Foro: decirles que escriban el código en el foro, pero que después lo borren si está la duda solucionada.

* Unificar todos los documentos en 1!
