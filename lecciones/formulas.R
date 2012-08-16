
## Fórmulas

# En R las fórmulas son utilizadas para describir modelos. Estos modelos se escriben con operadores como '~', '+', '*', etc. 

# Formula genérica:
variable.de.respuesta ~ variables.explicativas

# Aquí la fórmula está dada por el operador "~"; a la izquierda está la variable de respuesta, a la derecha la o las variables explicativas. El esquema general es el siguiente:

## El "~" (virgulilla) debería leerse como "es modelado por" o "es modelado como una función de".

# Si el estudiante desea profundizar, puede utilizar el comnado:
?formula

# En esta lección nos vamos a enfocar en el uso de fórmulas para ANOVA y análisis de regresión, con la esperanza de dar los elementos para que cada estudiante pueda profundizar mejor en este tema por su cuenta, en caso de que le sea necesario.


# En R existen varias funciones, tales como aov (Analysis of Variance), lm (Linear Models) y glm (Generalized Linear Models), que usan objetos de la clase "formula" para especificar las variables que deben ser incluidas en el análisis o modelo. Normalmente la fórmula es incluida como el primer argumento de la función. 
# Siguiendo con el ejemplo genérico:

reresion_simple <- lm(variable.de.respuesta ~ variables.explicativas, data=DataFrame) # el argumento data es impresindible para indicarle al R de donde debe sacar los datos para realizar la regresión, es como cuando en el Excel, marcamos las columnas que queremos que sean utilizadas para graficar...

# Las fórmulas, a pesar de ser similares, no funcionan del todo igual respecto a las convenciones con las que todos estamos familiarizados. 
# El primer objetivo de estas es especificar un modelo estadístico. 
# Esto ayuda a simplicar la interfase con el usuario, pero implica que primero este debe aprender la sintáxis propia de estas fórmulas.

# Veamos algunos ejemplos para ir entendiendo la lógica:
x <- runif(20, 5, 30) # variable explicativa
y <- 1.3 * x + rnorm(20, sd=3) # variable de respuesta
y ~ x
# Esta fórmula especifica un modelo lineal, "y es modelado por x". 
# Aunque no se escribe, está implícito que el modelo tendrá un intercepto. 
# La siguiente fórmula expresa exactamente lo mismo:
y ~ 1 + x

# Las fórmulas también son un objeto, de clase "formula"
form  <- y ~ x
class(form)
plot(form)       # grafica los datos y ~ x
lm(form)         # regresión lineal
abline(lm(form)) # visualización del modelo

# En caso de querer quitar el intercepto, se agrega un -1 o un 0:
form2 <- y ~ -1 + x # o
form2 <- y ~ x - 1  # o
form2 <- y ~ x + 0

# Ahora algunos comandos anteriores van a tener lijeras diferencias...
class(form2)
plot(form2)
lm(form2)         # nótese que solo nos brinda el parámetro pendiente 
abline(lm(form2)) # nótese en donde corta el nuevo gráfico

# Hasta ahora sólo usamos una variable explicativa, "x". Sin embargo podemos agregar otras variables usando el operador "+":
y ~ x + z

# Nótese que el significado de "+" no es el mismo que en una suma aritmética. # Aquí simplemente se está incluyendo a la variable "z" en el modelo ("y es modelado como función de x y z").
# A este tipo de modelos con mas de una variable explicativa se les llama comunmente Regresión Múltiple, pero eso ya lo veremos más adelante...

# Nota: podemos usar una matriz para agrupar por columnas las variables explicativas.
# Siguiendo el ejemplo anterior:
X <- cbind(x, z)
y ~ X # es exactamente lo mismo que
y ~ x + z

# Es muy importante utilizar correctamente los símbolos (operadores) dentro de las fórmulas.
# Para evitar confusiones existe una función identidad "I", para diferenciar:
y ~ x + z    # "y en función de x y z"
y ~ I(x + z) # "y en función de la suma de x y z"
# Es decir, usando "I" podemos indicar que queremos usar un operador determinado con su significado matemático normal. 

# Otro ejemplo con la función I:
y ~ a + I(b+c) # "y en función de las variables a y la suma aritmética de las variables b + c"
y ~ a + b + c # "y en función de las variables a, b y c"
# ¿Cuántas variables explicativas tiene cada modelo?

# Muchas veces no hay confusiones:
y ~ x + log(z)
# Pero en caso de duda, es recomendable recurrir a esta función especial.


# La siguiente tabla muestra los usos de los distintos operadores (no todos) dentro de una fórmula:

# operador |    ejemplo    | interpretación
#----------+---------------+-----------------------------------------------------#
#    +     |      + x      | incluye esta variable
#    -     |      - x      | quita esta variable
#    :     |      x:z      | incluye la interacción entre estas variables
#    *     |      x*z      | incluye ambas variables y la interacción entre ambas
#    /     |      x/z      | anidamiento: incluye a z anidado en x
#    |     |      x|z      | condicional: incluye a x dado z
#    ^     | (u + v + w)^3 | incluye estas variables y todas las interacciones hasta 3 vías
#   poly   |   poly(x, 3)  | regresión polinómica (polinomios ortogonales)
#  Error   |   Error(a/b)  | especifía un término de error
#    I     |    I(x * z)   | incluye una nueva variable, la cual es el resultado de las operaciones internas al paréntesis.
#    1     |      - 1      | intercepto, generalmente usado para ser borrado

# Tal vez hayan notado que algunas estructuras se pueden especificar de varias maneras:
y ~ u + v + w + u:v + u:w + v:w + u:v:w
y ~ u * v * w
y ~ (u + v + w) ^ 3
# Son tres formas distintas de decir lo mismo: y es función de las variables u, v, w y de todas las interacciones posibles. 
# Si queremos quitar la interacción de tres vías, cualquiera de las tres siguientes es válida:
y ~ u + v + w + u:v + u:w + v:w
y ~ u * v * w - u:v:w
y ~ (u + v + w) ^ 2

# El tipo de variable explicativa que se utiliza (binarias, categórica (factores) o numérica) determina la naturaleza del análisis. 
# Por ejemplo, si "u" y "v" son factores:
y ~ u + v
# indica un modelo de análisis de varianza (sin los términos de interacción). 

# Si "u" y "v" fueran "numerical" (numérica), entonces sería una regresión múltiple. 

# Si "A" es un factor y "x" es una variable numérica, entonces
y ~ A + x
# Es un análisis de covarianza, con clases determinadas por "A" y covariable "x".

#############################################################################

# EXTRA

# Normalmente la fórmula es incluida como el primer argumento de la función. # Por ejemplo, para hacer una regresión lineal entre el largo de sépalo y ancho de sépalo de la especie setosa, incluida en la tabla "iris":
regre <- lm(Sepal.Length ~ Sepal.Width, data=iris, subset=Species == 'setosa')
summary(regre)

# Sin embargo las fórmulas también sirven para otras funciones, como por ejemplo plot o xtabs. 
# Usando prácticamente el mismo código anterior podemos hacer un plot:
plot(Sepal.Length ~ Sepal.Width, data=iris, subset=Species == 'setosa')
abline(regre) 
# abline sirve para agregar líneas *rectas* a los gráficos (no confundir con la función "lines").



# El operador "." sirve para indicar "todas las demás variables", en caso de que estemos usando las variables contenidas en un set de datos. 
# Por ejemplo, para el set de datos iris...
# (el estudiante debería darle una mirada para ver que tipo de variables presenta dicho conjunto de datos) -> ?iris 

plot(Sepal.Width ~ ., data=iris)
# Nos va a pedir que demos Enter para ver todos los gráficos posibles # (Sepal.Width en función de Sepal.Length, Petal.Length, Petal.Width y Species; las variables incluidas en la tabla "iris").

# Se puede usar en combinación con modelos de regresión:
lm(Sepal.Width ~ ., data=iris)

## Ver la ayuda de "formula" para más información sobre este operador.

