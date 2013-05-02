- - -

Sobre el Markdown:
------------------

Este foro cuenta con la ventaja de que utiliza automáticamente el formato Markdown. Se trata de una forma muy simple de dar formato a nuestro texto, como por ejemplo palabras en **negrita** o *itálica*, o `código` dentro del texto... y lo más útil probablemente sea la capacidad de poner bloques de código (varias líneas de código) usando 4 espacios antes del texto y separado por una línea de espacio antes y después de haber ingresado el código, lo que finalmente se ve así:

    x <- runif(200)
    y <- runif(200)
    plot(x, y)
    abline(0, 1)
    points(9.5, 2.3, col= 'red')

Encabezados:

# Encabezado nivel 1

## Encabezado nivel 2

### Encabezado nivel 3

Los encabezados se escriben con un `#` (numeral) al principio, lo que puede tener efectos inesperados al poner código (ya que los comentarios se inician con el numeral).

Y también links: [histograma](http://i.imgur.com/nDeS2O0)


- - -

Como muestra, el texto anterior se ve así antes de enviar el post:

    Sobre el Markdown:
    ------------------

    Este foro cuenta con la ventaja de que utiliza automáticamente el formato Markdown. Se trata de una forma muy simple de dar formato a nuestro texto, como por ejemplo palabras en **negrita** o *itálica*, o `código` dentro del texto... y lo más útil probablemente sea la capacidad de poner bloques de código (varias líneas de código) usando 4 espacios antes del texto, lo que finalmente se ve así:

        x <- runif(200)
        y <- runif(200)
        plot(x, y)
        abline(0, 1)
        points(9.5, 2.3, col= 'red')

    Encabezados:

    # Encabezado nivel 1

    ## Encabezado nivel 2

    ### Encabezado nivel 3

    Los encabezados se escriben con un `#` (numeral) al principio, lo que puede tener efectos inesperados al poner código (ya que los comentarios se inician con el numeral).

    Y también links: [histograma](http://i.imgur.com/nDeS2O0)

    - - -

Observación: es importante que recuerden poner las líneas en blanco antes y después del bloque de líneas de código. Las líneas consecutivas aparecen en la misma línea a menos que pongamos una línea en blanco entre medio.

También se hizo un pequeño [video del uso del markdown](http://www.youtube.com/watch?v=c9n-LKVDY4U&feature=youtu.be) (5 min) en foros y recomendamos [dingus](http://daringfireball.net/projects/markdown/dingus) o [markx](http://markx.herokuapp.com/) para practicar el sistema.

De esta forma se puede hacer mucho más fácil leer el código que ponemos en los mensajes de foro.

