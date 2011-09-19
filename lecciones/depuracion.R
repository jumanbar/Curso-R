#### Depuración de funciones o "debugging"
 
# Es inevitable tener errores al programar. En inglés el término para
# referirse a un error de programación es "bug"
# (http://es.wikipedia.org/wiki/Error_de_software), y por lo tanto, la
# expresión para la tarea de eliminar estos erorres es "debug"; en español
# "depurar"
 
# En R se puede usar la función debug para inspeccionar el código interno
# de una función en el momento mismo en que se ejecuta, pero hay métodos más
# primitivos / sofisticados que también pueden ser de utilidad.
 
# Como ejemplo, vamos a ver la función estimaPi. Esta función, así como la
# la función "leib" están definidas en el archivo "estimaPi.R"
# Para cargar este archivo:
source('estimaPi.R') # suponiendo que está en el directorio de trabajo actual.
 
# Para hacer más fácil este ejemplo, se incluyen aquí las líneas necesarias 
# para definir la función "estimaPi" en nuestra área de trabajo:




############ FUNCIÓN estimaPi #####################
estimaPi <- function(n=5, error=0.01, show=TRUE) { # linea 13
# Estima el valor de pi usando la serie de Leibniz
	dif <- Inf
  out <- NULL
	while(dif > error) {
		x <- leib(n) * 4
	 	dif <- abs(x - pi) ## 20
		out <- c(out, dif)
	 	n <- n + 1
	}
	if(show) plot(out)
 	list(estimacion=x, nfinal=n - 1, error=error, dif=out)
} # linea 26
###################################################
 
# La función está definida entre las líneas 13 y 26 del script original.
# Sí se siguieron los pasos correctamente se debería poder correr:
 
x <- estimaPi()
x$estimacion ## debería dar 3.131593
 
# Para generar un error en la función, vamos a cambiar el 'n' por 'N' dentro
# de la función "leib" (línea 19). Luego hay que salvar los cambios del archivo
# "estimaPi.R" y volver a cargarlo:
source('estimaPi.R')
# Nota: los mismos cambios se pueden hacer usando fix(estimaPi) o clickeando
# el nombre de la función en la pestaña "workspace" del panel 3 de RStudio.
 
x <- estimaPi() # Error in leib(N) : object 'N' not found
 
# El mensaje de error ya muestra en dónde está el problema (función leib), pero
# puedo chequearlo con traceback:
traceback()
# 2: leib(N) at <tmp>#6
# 1: estimaPi()
 
# Traceback muestra qué funciones estaban corriendo en el momento en que 
# ocurrió el error; en este caso muestra dos funciones, ya que están anidadas.
# No todas las funciones son registradas por este algoritmo: sqrt, abs, y otras
# (ver ?Special) son ejemplos (en general funciones relacionadas con matemática
# básica).
 
# Ahora arreglamos el error anterior (cambiar N por n dentro del llamado a leib).
# Para generar un nuevo error en la función, comentamos la línea 22 (agregando
# un "#" al principio de la misma (Ctrl+/ en RStudio), de forma que ahora no se
# ejecuta el comando:
# n <- n + 1
# Luego hay que salvar los cambios del archivo estimaPi.R y volver a cargarlo
source('estimaPi.R')
 
x <- estimaPi()
# Ahora no va a terminar nunca, ya que n es el mismo siempre y por lo tanto no
# cambia la estimación de pi (para detenerlo usar Esc o el botón de Stop,
# Ctrl+C si estamos en una terminal de linux).
 
# Vamos a ver 3 métodos para buscar el error en el código de estimaPi
 
# MÉTODO 1: IMPRIMIR
# La forma más sencilla de averiguar qué ocurre, es usando la función print 
# para que estimaPi nos vaya mostrando un objeto que nos parezca importante.
# Por ejemplo, es crucial que dif vaya disminuyendo a medida que se repiten
# las iteraciones de estimaPi, por lo que vamos a agregar una línea, luego de
# la línea 20, en la que pondremos "print(dif)". Salvamos y cargamos de nuevo.
 
# Cada vez que ejecuta este comando se imprime el valor de dif en la consola:
x <- estimaPi()
# Si se siguieron todos los pasos, debería verse algo como:
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# etc ...
 
# Viendo esto es claro que hay algún error, y nos da alguna pista de por dónde
# debemos buscar. Los pasos a seguir son a criterio de cada uno. Es necesario
# comprender bien qué se quiere y cómo debería trabajar la función.
 
# MÉTODO 2: DEBUG
# Una forma diferente de analizar la función es con debug().
# Con el comando:
debug(estimaPi)
# Se "marca" la función para depurar. En la jerga apropiada se dice que se le
# coloca una "bandera" a la función (un "flag").
# Al correr:
x <- estimaPi()
# Vamos a "meternos adentro" de la función. Se ve un command prompt distinto:
# Browse[2]>
# Al dar enter se ejecuta el siguiente comando de la función, de forma que 
# podemos ir paso por paso analizando lo que hace la misma.
# Los objetos que sólo existen dentro de la función ahora se pueden ver, de
# forma que podemos buscar los errores, mirando las diferencias entre lo que
# valen y lo que deberían valer.
# Dentro de esta modalidad, hay ciertos comandos especiales, los cuales se
# pueden ver en la ayuda de browser().
?browser
# Por ejemplo, "c" es un comando reservado para ejecutar un loop sin tener que
# ir paso por paso.
 
# Para salir de este modo de depuración, usamos el comando Q (+ enter)
 
# La función pierde su condición de "marcada" de dos maneras, o se vuelve a 
# definir dentro del área de trabajo:
source('estimaPi.R')
# o se usa
undebug(estimaPi)
 
# De esta forma se le quita la "bandera" a estimaPi
 
# MÉTODO 3: BROWSER
# El método más sofisticado que vamos a ver es la combinación de un 
# condicional, if, con la función browser.
# Para esto vamos a agregar la siguiente línea en el archivo estimaPi.R,
# luego de la línea 18 (luego del while)
if(length(out) > 1000) browser()
# Entonces, si se cumple la condición (que out tenga más de 1000 elementos),
# se va a ejecutar el comando browser(), el cual nos mete dentro de la función,
# de forma idéntica a lo que ocurría con debug...
source('estimaPi.R')
x <- estimaPi()
# La consola debería mostrar:
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# [1] 0.1655465
# Called from: estimaPi()
# Browse[1]>
 
# A diferencia de cuando usamos debug, si ahora queremos ir paso por paso,
# primero hay que usar el comando especial n (+ enter):
# Browse[1]> n
# a continuación podremos ir de a un comando por vez usando enter.
 
# Esta última modalidad es muy útil ya que nos puede ahorrar tiempo si, por
# ejemplo, el problema que debemos solucionar solamente ocurre luego de la
# milésima iteración, o cuando ocurre un evento por azar con muy baja probabilidad. 
 
 
## FINALIZANDO
# Estas funciones nos van a venir bien cuando estemos programando, por razones
# obvias. Es bueno recordar que existen y saber cómo funcionan, ya que muchas
# veces un error sencillo nos puede estar complicando la vida mucho rato y no
# perdemos demasiado tiempo buscándolo si conocemos las herramientas adecuadas.
