
- guía de RStudio: explicar sobre el encoding
- ejer. "peso-plantas.txt": poner que es una tabla de 30x2
- agregar "manipular-tablas-plus.R"
- pedir "más de un método" para varios ejercicios (números pares/impares, secuencia de valores, etc...)
- luego de cada tanda de ejercicios, poner las soluciones online
- Ejercicio de programación, tema for: hacer un script que cuente por fila de una matriz la cantidad de elementos que cumplan una condición (mayores que 0, por ejemplo)

* Mejorar los ejercicios de corrección, al menos de los repartidos I y II, poniendo mensajes de error más específicos (se empezó a implementar en rep III).
* Ídem con la función `reload` del repIII.  
* Mejorar lecciones extras en general.
* Capaz que sacar puntaje negativo a respuestas incorrectas de cuestionarios.  
* Leer preguntas de foro que puedan ayudar a mejorar los cuestionarios.  
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

* Agregar ejercicios en funciones, más simples y más diversos:
  - cambiar última y primer fila de
- una matriz; ordenar una matriz según los valores de cualquier columna, según número o nombre).
