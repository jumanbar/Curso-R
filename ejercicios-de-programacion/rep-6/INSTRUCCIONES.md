Ejercicio de programación VI: Estructuras de Control
====================================================

### [IMSER 2013]

De otros años:


* Crecimiento exponencial ...?

* Caminata del borracho?

* Símil función preg?

* Loops con errores: un while que es infinito, un for que tiene mal puesto el rango, ...

- - -

1. Conteos por fila
-------------------

### 1.a Loop for

Suponga que usted debe analizar regularmente matrices de datos, obtenidos en muestreos sucesivos, con cantidades de filas variables. Una de las tareas que se le pide realizar cotidianamente es hacer un conteo de la cantidad de valores mayores a 45 *por cada fila* de la matriz. Para no tener que hacerlo manualmente, usted decide que lo mejor es crear un script de R con el cual hacer este conteo automáticamente.

Para hacer el script lo mejor es usar una matriz de juguete con la cual hacer pruebas. Para esto sirven las siguientes líneas (que también se encuentran en el script del ejercicio):


```r
# Generación de la matriz datos:
datos <- matrix(rpois(rpois(1, 125) * 15, 43), ncol = 15)
```


Para lograr su objetivo, usted deberá usar un loop `for`, con el cual completará el vector `out`, el cual contendrá las sumas de valores mayores a 45 por filas. Como un mini ejemplo, si su matriz `datos` es la siguiente:


```r
datos <- datos[1:5, 1:5]
datos[sample(25, 1)] <- 46  # Alguno > 45 al menos
datos
```

```
##      [,1] [,2] [,3] [,4] [,5]
## [1,]   45   45   43   37   42
## [2,]   35   54   44   40   43
## [3,]   44   53   43   35   46
## [4,]   47   40   36   37   55
## [5,]   41   53   52   45   44
```




Entonces el vector `out` será así:


```r
out
```

```
## [1] 0 1 2 2 2
```


(Este es un ejemplo creado con números al azar, por supuesto.)

Nótese que el sistema de corrección espera que haya un `for` en el script (naturalmente) y que la *variable de iteración* (ver lección 6.2) tome como valores **números enteros positivos**.

### 1.b Extra: apply

Luego de hacer el script del ejercicio 1.a, usted se da cuenta que lo mismo se puede hacer y de forma "más elegante" con una función `apply`. Para esto usted deduce que debe crear una función propia capaz de contar la cantidad de valores mayores a 45 (o a un valor variable, si usted lo prefiere) de un vector numérico cualquiera y luego aplicar esta función con `apply` a todas las filas de `datos` (note que cada fila es un vector cuando se las trata por separado).

Para completar el ejercicio deberá simplemente usar `apply` para lograr el mismo vector `out` que en el ejercicio 1.a.

- - -

2. Una vez más, Zenón
---------------------

### 2.a Zenón recargado

Hacer un while para encontrar el n para un valor arbitrario de $\varepsilon$, siguiendo las directivas del ejercicio de zenon.R

Como seguramente recordará, en el Repartido I se propuso calcular la serie que representa a la [paradoja de Zenón](https://es.wikipedia.org/wiki/Paradojas_de_Zen%C3%B3n#La_dicotom.C3.ADa), cuyo valor para el enésimo elemento se definió como:

$$
  Z_n = \sum_{i=1}^{i=n} \frac{1}{2 ^ i} \;=\;
  \frac{1}{2 ^ 1} + \frac{1}{2 ^ 2} + \frac{1}{2 ^ 3} + ... + \frac{1}{2 ^ n} \;=\;
  \frac{1}{2} + \frac{1}{4} + \frac{1}{8} + ... + \frac{1}{2 ^ n}
$$

En R, el valor de $Z_n$ se puede obtener con las siguientes líneas de código:


```r
n <- 20  # El n puede ser cualquiera en verdad...
Zn <- sum(1/(2^(1:n)))
```


En ocasión de aquel primer repartido, el objetivo era encontrar el mínimo `n` que cumpliera la desigualdad $1 - Z_n < \varepsilon$, siendo $\varepsilon = 10 ^ {-6}$. El único método con que contaba en ese momento era manualmente cambiar el valor de `n` aumentando en una unidad, ejecutar el código y determinar manualmente si cumplía tal condición (para repetir el proceso en caso de que de no hacerlo). Sin embargo con las herramientas que usted a aprendido en esta unidad es posible ver que se pueden automatizar estos procedimientos, e incluso generalizarlo para cualquier $\varepsilon$. Este es el objetivo de este ejercicio.

Para esto usted deberá usar el loop `while`, ya que es (en principio) el más adecuado para esta tarea, pues no sabemos de antemano cual va a ser el `n` "correcto". Además recuerde que el loop `while` necesita que se cumpla una condición para continuar su ejecución, tal como el procedimiento de encontrar el `n` correcto.

La siguiente es la salida en la consola para el caso de `epsilon <- 5e-2` y empezando con `n <- 1` (aunque no lo muestre en la salida): 


```
## n = 2 - Zn = 0.75 
## n = 3 - Zn = 0.875 
## n = 4 - Zn = 0.9375 
## n = 5 - Zn = 0.9688
```


**Recuerde que**: **1.** en cada iteración `n` debe aumentar en una unidad, **2.** el script debe funcionar igual debien para cualquier valor de `epsilon` elegido y **3.** es lo mejor utilizar el código indicado anteriormente para obtener `Zn` o la corrección automática tendrá problemas con el redondeo de los valores. 

### 2.b Guardar los valores

Luego de hacer la parte 2.a, usted decide que es buena idea tener toda la secuencia de valores de `Zn` que se van obteniendo en un único vector numérico, al cual llamará `Z`. Para esto es necesario modificar tanto la preparación como las instrucciones del loop, como recordará de las lecciones de la unidad 6.

La siguiente es la salida en la consola para el caso de `epsilon <- 5e-2` y empezando con `n <- 1` (aunque no lo muestre en la salida): 


```
## n = 2 - Zn = 0.75 
## n = 3 - Zn = 0.875 
## n = 4 - Zn = 0.9375 
## n = 5 - Zn = 0.9688
```

```
## [1] 5
```

```
## [1] 0.03125
```

![Serie de Zenón, con n (final) = 5](figure/fig1.png) 


**Recuerde que**: **1.** en cada iteración `n` debe aumentar en una unidad, **2.** el script debe funcionar igual debien para cualquier valor de `epsilon` elegido y **3.** es lo mejor utilizar el código indicado a continuación para obtener `Zn` o la corrección automática tendrá problemas con el redondeo de los valores. 


```r
n <- 20  # El n puede ser cualquiera en verdad...
Zn <- sum(1/(2^(1:n)))
```


La figura 1 se obtuvo con el siguiente código:


```r
plot(Z, xlab = "n", ylab = expression(Z[n]), type = "o", pch = 19, ylim = c(0.5, 
    1))
```



- - -


3. Línea urbana
---------------

Como proyecto del gobierno municipal local, usted va a simular el trayecto de un ómnibus a través de su recorrido. El objetivo es obtener una simulación razonablemente fiel a los datos observados para esa línea. Se supone que dicho gobierno va a utilizar los datos generados y complementarlo con análisis matemáticos rigurosos, a fin de diseñar un sistema de transporte óptimo que tenga un buen balance entre el costo de flota y eficiencia de transporte.

### 3.a Modelo básico

Usted ya ha hecho un modelo que, si bien es muy crudo aún, tiene los componentes básicos necesarios. El código es el siguiente:


```r
set.seed(0)
paradas <- 50
maximo <- 60
pasajeros <- rpois(1, 10)
registro <- numeric(paradas)
registro[1] <- pasajeros
for (i in 1:paradas) {
    # Bajan:
    pasajeros <- pasajeros - rpois(1, 2)
    
    # Suben:
    pasajeros <- pasajeros + rpois(1, 3)
    
    registro[i] <- pasajeros  # Actualiza registro
}
plot(registro, type = "o", pch = 19, xlab = "Parada", ylab = "No. de pasajeros", 
    ylim = c(0, max(registro)))
abline(h = c(0, maximo), lty = 3)
```

![Modelo 'crudo'; las líneas indican los límites que debería tener el nro. de pasajeros](figure/fig2.png) 


Como puede ver en el gráfico generado (fig. 2), la cantidad de pasajeros sobrepasa en ocasiones al menos uno de los límites posibles para un bus real (en este caso, el máximo es 60 y el mínimo es 0, naturalmente).

El objetivo de este ejercicio tiene que ver con este último: **modificar el código de forma tal que se impongan límites a los valores posibles de `pasajeros`**. En particular, siempre que la cantidad de pasajeros sea mayor que el máximo estipulado (siendo que ya subieron y bajaron los pasajeros correspondientes a ese turno), debe corregirse el valor de `pasajeros`, dejándolo en el `maximo`. El caso análogo debe ocurrir si `pasajeros` toma valor negativo, cambiándolo por 0.

### 3.b ¿Cuántos se quedan afuera?

Uno de los principales objetivos del gobierno municipal es el de saber cuántos pasajeros quedan sin poder subir al bus en cada parada. Para esto es necesario registrar, en su simulación, el número de pasajeros que sobrepasan el límite máximo de la capacidad del vehículo.

Usted decide crear un vector numérico, el cual tendrá tantos valores como paradas hay en el recorrido y registrará para cada una el la cantidad de personas que no han podido subir al vehículo. Dicho vector será `nosuben` y deberá tener la longitud correcta *antes* de iniciar el loop.


![Simulación con límites y el vector nosuben en verde](figure/fig3.png) 


La siguiente imagen se obtuvo haciendo la simulación, ejecutando previamente ``set.seed(11)`` y luego el comando gráfico:


```r
plot(registro, xlab = "Parada", ylab = "No. de pasajeros")
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9.png) 


### 3.c Heterogeneidad

1. La cantidad de pasajeros que bajan o suben siempre se obtiene con la función `rpois(1, lambda)`, siendo `lambda` un número entero cualquiera. El sistema de corrección del ejercicio espera que usted use siempre líneas como estas para simular subidas o bajadas de pasajeros:

Sugerencias: (1) la función ``sample`` puede ser útil para simular la subida de pasajeros. (2) Tanto en este como en los siguientes ejercicios, en caso de no estar seguro/a de cómo proceder, puede facilitar mucho la tarea hacer un diagrama de flujo sencillo antes de empezar a escribir código.

```r
# Usando lambdas 2 y 3 como ejemplos:
pasajeros <- pasajeros - rpois(1, 2)
pasajeros <- pasajeros + rpois(1, 3)
```


### 3.d Extremos
- - -

### b. Cambio de loop

Modifique el código de la parte anterior de forma tal que haga lo mismo, pero utilizando un loop ``while``.

Sugerencias: (1) agrege manualmente una variable (p.ej.: ``i``) que sirva para indexar los distintos objetos y recuerde actualizarla en la linea correcta del código y (2) usar un ``if`` posterior al loop puede ser útil para sustituir los ceros del final por 44 en el vector registro (aunque no es de ninguna manera el único método).

Nota: el gráfico que se dió en la parte anterior tamibén aplica para este ejercicio. 

### (``*``) c. Función ``bus``

Modifique el código reparado en la parte **a** para crear una función llamada ``bus`` que ejecute la misma simulación, en la que el número de paradas y capacidad máxima del bus sean los argumentos de la misma. El nombre de estos argumentos son a su elección.

Como salida la función debe devolver simplemente el vector ``registro``.

Nota: recuerde que esta función debe trabajar correctamente para cualquier elección del número de paradas y máximo de pasajeros. En el siguiente ejemplo se muestra un caso que puede servir de referencia:





```r
set.seed(11)
# Nro. de paradas = 40 Máximo de pasajeros = 80
x <- bus(40, 80)
```

```
## Parada 1 hay 1 pasajeros
## Parada 2 hay 1 pasajeros
## Parada 3 hay 4 pasajeros
## Parada 4 hay 4 pasajeros
## Parada 5 hay 4 pasajeros
## Parada 6 hay 10 pasajeros
## Parada 7 hay 10 pasajeros
## Parada 8 hay 12 pasajeros
## Parada 9 hay 18 pasajeros
## Parada 10 hay 18 pasajeros
## Parada 11 hay 19 pasajeros
## Parada 12 hay 22 pasajeros
## Parada 13 hay 28 pasajeros
## Parada 14 hay 33 pasajeros
## Parada 15 hay 38 pasajeros
## Parada 16 hay 42 pasajeros
## Parada 17 hay 45 pasajeros
## Parada 18 hay 47 pasajeros
## Parada 19 hay 48 pasajeros
## Parada 20 hay 51 pasajeros
## Parada 21 hay 52 pasajeros
## Parada 22 hay 56 pasajeros
## Parada 23 hay 58 pasajeros
## Parada 24 hay 60 pasajeros
## Parada 25 hay 60 pasajeros
## Parada 26 hay 63 pasajeros
## Parada 27 hay 65 pasajeros
## Parada 28 hay 65 pasajeros
## Parada 29 hay 65 pasajeros
## Parada 30 hay 67 pasajeros
## Parada 31 hay 70 pasajeros
## Parada 32 hay 72 pasajeros
## Parada 33 hay 74 pasajeros
## Parada 34 hay 75 pasajeros
## Bus lleno!
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12.png) 


- - -

### d. Gente que también baja

Hacer una variante del código (de cualquiera de las partes anteriores) en la que además de subir personas, a partir de la parada 10 se bajen entre 1 y 5 pasajeros por parada. Tanto la subida y la bajada deben ejecutarse **antes** de determinar si se alcanzó el máximo estipulado de pasajeros y por lo tanto si debe dejar de detenerse el bus en las paradas.

Sugerencia: puede ser muy útil hacer un diagrama de flujo sencillo para planificar el código antes de escribirlo.

El siguiente es un ejemplo del resultado de aplicar los cambios que se piden en la función ``bus``:

* Cambiar parte d del útimo parcial: si el bus tiene el máximo de pasajeros no sube a más nadie y si tiene el mínimo (0) no baja nadie.

#### Base:
suben rpois(1, 3) en cada parada
bajan rpois(1, 2) "

#### a. Límites:
no pueden haber más de `maximo` pasajeros
no pueden haber menos de `0` pasajeros

#### b. Heterogeneidad:
entre las paradas 15 y 40 (inclusive) se sube mucho más gente: rpois(1, 8)
a partir de la parada 33 se bajan muchos más: rpois(1, 5)

#### c. Los extremos:
nadie se baja antes de la parada 5
nadie se sube a partir de la parada 45 (inclusive)

#### d. Gente que no sube:
Cantidad de gente que quiere subir pero no puede porque el bus está lleno.



```
## Parada 1 hay 12 pasajeros
## Parada 2 hay 14 pasajeros
## Parada 3 hay 15 pasajeros
## Parada 4 hay 17 pasajeros
## Parada 5 hay 19 pasajeros
## Parada 6 hay 19 pasajeros
## Parada 7 hay 18 pasajeros
## Parada 8 hay 21 pasajeros
## Parada 9 hay 21 pasajeros
## Parada 10 hay 22 pasajeros
## Parada 11 hay 23 pasajeros
## Parada 12 hay 23 pasajeros
## Parada 13 hay 21 pasajeros
## Parada 14 hay 20 pasajeros
## Parada 15 hay 22 pasajeros
## Parada 16 hay 30 pasajeros
## Parada 17 hay 33 pasajeros
## Parada 18 hay 37 pasajeros
## Parada 19 hay 44 pasajeros
## Parada 20 hay 49 pasajeros
## Parada 21 hay 60 pasajeros
## Parada 22 hay 60 pasajeros
## Parada 23 hay 60 pasajeros
## Parada 24 hay 60 pasajeros
## Parada 25 hay 60 pasajeros
## Parada 26 hay 60 pasajeros
## Parada 27 hay 60 pasajeros
## Parada 28 hay 60 pasajeros
## Parada 29 hay 60 pasajeros
## Parada 30 hay 60 pasajeros
## Parada 31 hay 60 pasajeros
## Parada 32 hay 60 pasajeros
## Parada 33 hay 60 pasajeros
## Parada 34 hay 60 pasajeros
## Parada 35 hay 60 pasajeros
## Parada 36 hay 58 pasajeros
## Parada 37 hay 59 pasajeros
## Parada 38 hay 56 pasajeros
## Parada 39 hay 57 pasajeros
## Parada 40 hay 58 pasajeros
## Parada 41 hay 55 pasajeros
## Parada 42 hay 57 pasajeros
## Parada 43 hay 55 pasajeros
## Parada 44 hay 53 pasajeros
## Parada 45 hay 49 pasajeros
## Parada 46 hay 38 pasajeros
## Parada 47 hay 35 pasajeros
## Parada 48 hay 30 pasajeros
## Parada 49 hay 28 pasajeros
## Parada 50 hay 27 pasajeros
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13.png) 



```r
set.seed(11)
x <- bus(30, 60)
```

```
## Parada 1 hay 1 pasajeros
## Parada 2 hay 1 pasajeros
## Parada 3 hay 4 pasajeros
## Parada 4 hay 4 pasajeros
## Parada 5 hay 4 pasajeros
## Parada 6 hay 10 pasajeros
## Parada 7 hay 10 pasajeros
## Parada 8 hay 12 pasajeros
## Parada 9 hay 18 pasajeros
## Parada 10 hay 18 pasajeros
## Parada 11 hay 19 pasajeros
## Parada 12 hay 22 pasajeros
## Parada 13 hay 28 pasajeros
## Parada 14 hay 33 pasajeros
## Parada 15 hay 38 pasajeros
## Parada 16 hay 42 pasajeros
## Parada 17 hay 45 pasajeros
## Parada 18 hay 47 pasajeros
## Parada 19 hay 48 pasajeros
## Parada 20 hay 51 pasajeros
## Parada 21 hay 52 pasajeros
## Parada 22 hay 56 pasajeros
## Parada 23 hay 58 pasajeros
## Bus lleno!
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14.png) 


