## Cuantiles (percentiles, cuartiles, mediana, etc.)

# El término "cuantiles" refiere a la posición ocupada por un determinado velor
# en un conjunto de datos ordenados. Algunos cuantiles en particular nos propor-
# cionan información muy valiosa acerca de la distribución de nuestros datos.

## Mediana

# La Mediana es quizá el cuantil más importante en estadística, ya que se trata
# del central de la distribución de un conjunto de datos. En una distribución
# Normal o Gaussiana, la mediana va a presentar un valor muy similar al de la
# media (promedio). Presenta, sin embargo, algunas características que lo hacen
# particularmente útil al trabajar con datos.
# La mediana, a diferencia de la media, es poco sensible a los valores
# extremos.
# Ej: considerando el siguiente vector
vec <- c(1, 2, 3, 4, 5, 6, 21)
# la media del mismo será:
mean (vec)
# mientras que la mediana será:
median (vec)
# Esta propiedad hace que en determinados casos la mediana represente una
# aproximación más adecuada a la descripción de los datos.

# En el caso en que la cantidad de elementos en nuestro conjunto de datos es
# impar, la mediana es exactamente el valor central. Por el contrario, en caso
# de que nuestro conjunto de datos tuviese una cantidad par de elementos,
vec <- c(1, 2, 3, 4, 5, 6, 21, 22)
# la mediana es el promedio de los dos valores centrales.
median (vec)

# Hay al menos dos formas de obtener la mediana de un conjunto de datos en R.
# La primera es utilizando la función "median", y la segunda es mediante la
# función "quantile":
quantile (vec, prob = 0.5)

## Cuartiles

# De modo similar a como la mediana divide nuestros datos en sus dos mitades,
# los cuartiles los dividen en 4 partes iguales. Podemos pensar en los cuartiles
# como las medianas de los valores menores y mayores a la mediana de nuestros
# datos, respectivamente.
median (vec [which (vec <= median (vec))])  # el primer cuartil
median (vec [which (vec >= median (vec))])  # el tercer cuartil
# El segundo cuartil es sencillamente la mediana de nuestros datos.

# Otra forma de obtener los cuartiles de nuestros datos es, también, mediante la
# función "quantile", de la siguiente manera.
quantile (vec, prob = c(0.25, 0.5, 0.75))
# Aunque si tenemos vectores con pocos datos y cantidad de elementos par, tal
# vez no coincidan. Si redefinimos el primer vector que teníamos podremos ver 
# que esto se cumple:
vec <- c(1, 2, 3, 4, 5, 6, 21)
median (vec [which (vec <= median (vec))])  # el primer cuartil
median (vec [which (vec >= median (vec))])  # el tercer cuartil
quantile (vec, prob = c(0.25, 0.5, 0.75))
# Ahora sí. Obviamente cuanta mayor cantidad de datos tengamos, menores van a ser
# este tipo de discrepancias (similar a lo que pasa con la media y la mediana).

## Percentiles

# Mediante la función "quantile" podemos encontrar el valor de cualquier combi-
# nación de cuantiles, sean éstos cuartiles, quintiles
quantile (vec, prob = c(0.2, 0.4, 0.6, 0.8))
# deciles
quantile (vec, prob = c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9))
# o la combinación de percentiles que se nos ocurra. 

## Intervalos de confianza

# Un ejemplo claro de aplicación estadística de los percentiles son los inter-
# valos de confianza. Los intervalos de confianza nos indican en qué intervalo de
# valores está una determinada cantidad de nuestras observaciones. Así, si
# queremos saber entre qué valores encontramos el 95% de nuestros datos, sólo
# tenemos que "recortar" a los datos 2.5% en cada extremo, o sea, los percentiles
# 2.5 y 97.5
quantile (vec, prob = c(0.025, 0.975))

# En distribuciones conocidas, los intervalos de confianza son funciones
# de la media y el desvío de las mismas. Por ejemplo, si tomamos un conjunto
# de datos que presentan distribución Normal con media en 0 y desvío 1
vec <- rnorm (1000, 0, 1)
# teóricamente los valores de los intervalos de confianza del 95% nos van a dar
# algo muy cercano a -1.96 y 1.96
quantile (vec, prob = c(0.025, 0.975))  # (redefinir varias veces "vec" y volver 
# a intentarlo, no da siempre lo mismo)
# (Por cierto, vuelvan a calcular los cuartiles utilizando este "vec" con los dos
# métodos: la diferencia es ahora menor).
