
# REGRESIÓN LINEAL SIMPLE

#==============================================================================#
# Pequeña nota de advertencia: Fórmulas y factores

# Para trabajar con modelos estadísticos en R existen los objetos de clase 
# "formula", los cuales tienen una sintaxis muy particular, hecha para facilitar 
# la interacción entre el usuario y la función de R que hace el análisis. 
# Sin embargo no es del todo intuitiva al principio dicha sintaxis, así que es 
# necesario estar familiarizado para aprovechar bien esta lección. 
# Por esta razón lo más lógico y recomendable es leer la lección de fórmulas
# antes de continuar.

# Lo mismo vale también para la lección dedicada a factores. Los factores son
# una representación de datos categóricos, los cuales tienen una notable
# facilidad para ser confundidos con vectores de clase "character".
# En particular las columnas de data.frames que uno puede pensar que son del
# tipo "character" son muchas veces "factor". A veces esta diferencia no importa
# mucho, pero en otras es fundamental no hacer esta confusión.
#==============================================================================#


# La regresión lineal es un modelo estadístico que relaciona funcionalmente dos 
# variables de forma lineal (una recta o, en su versión generalizada, un plano o
# un hyperplano). El caso más simple contiene una variable Y, de respuesta, y
# una variable X, explicativa (a veces llamadas también dependiente e 
# independiente)
# A TENER EN CUENTA: Que exista una relación funcional significativa entre ambas 
# variables no implica una causalidad, pero la puede sugerir 
# (http://es.xkcd.com/strips/correlacion/).

# El modelo estadístico lineal simple se puede escribir como (no correr):
Y = a + b*X + e 
# 'a' y 'b' son los parámetros del modelo.
# a: intercepto, corte en el eje de las ordenadas
# b: pendiente, tasa de cambio de la variable Y por unidad de la variable X
# e: errores del modelo y tienen distribución Normal 

# lm es la función que vamos a utilizar para ajustar un modelo lineal simple o múltiple.
# Para ver como se debe utilizar dicha función se puede ir a la ayuda de R:
?lm

# Como nos muestra la ayuda, el primer argumento de la función es la 'formula'.
# En esta fórmula se debe escribir el modelo estadístico que se desea ajustar.
# El segundo argumento 'data' hace referencia a la base de datos ó data.frame, de 
# donde pretendo que la función obtenga mis datos.

# Con sólo estos dos argumentos ya es posible realizar una regresión lineal.
# Por ejemplo: 
lm1 <- lm(dist ~ speed, data=cars)
# El objeto 'lm1' contiene la regresión simple que está dada por las variables 
# 'dist' y 'speed' y utiliza el data.frame 'cars'. Estas variables pertenecen a 
# una base de datos 'cars' que viene por defecto dentro de R, para más 
# información:
?cars

# ¿Que ocurre cuando ejecutamos el objeto lm1?
lm1
# La salida que nos da el R en la consola es un resumen de información básica,
# donde nos muestra en la primer línea la fórmula que equivaldría a nuestro modelo estadístico.
# En la segunda línea nos da los valores estimados de los parámetros (coeficientes)
# de nuestro modelo, en este caso el intercepto y la pendiente.
# Estos valores nos van a interesar para poder interpretar los resultados.
# Sin embargo, vamos a necesitar más información sobre nuestra regresión para poder
# interpretar la relación entre ambas variables.
# Una de las funciones más útiles para ver esto es a través de la función "summary"
# (la cual sirve para muchas clases de objetos):
summary(lm1)

# Call:
# lm(formula = dist ~ speed, data = cars) # fórmula
# 
# Residuals:  # valores de los cuantiles
#     Min      1Q  Median      3Q     Max 
# -29.069  -9.525  -2.272   9.215  43.201 
# 
# Coefficients: # valores estimados de los coeficientes con su p-valor
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -17.5791     6.7584  -2.601   0.0123 *  
# speed         3.9324     0.4155   9.464 1.49e-12 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 
# 
# Residual standard error: 15.38 on 48 degrees of freedom
# Multiple R-squared: 0.6511,  Adjusted R-squared: 0.6438
# F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12

# De esta salida nos interesan varios datos aparte de los valores estimados de los
# parámetros, intercepto (-17.5791) y pendiente (3.9324).
# 1) el rango de los valores cuantiles. Estos aparecen debajo de la línea que dice
# 'Residuals', y muestran los valores referentes al valor mínimo (-29.069), primer
# cuartil (-9.525), mediana (-2.272), tercer cuartil (9.215), y valor máximo (43.201).
# 2) El p-valor de los valores estimados de cada parámetro, intercepto (0.0123) y 
# pendiente (1.49e-12).
# 3) El R2 ("r cuadrado") que es el coeficiente de determinación, en este caso 0.6438.
# 4) Los grados de libertad y el valor del estadístico F (Fisher) respectivamente,
# F(1, 48) = 89.57.
# 5) El p-valor del modelo (asociado al estadístico F), 1.49e-12 para este caso.


# Otra forma popular, y más completa, de acceder a la información resumida del objeto
# 'lm1' es usando la función "str":
str(lm1)
# List of 12
#  $ coefficients : Named num [1:2] -17.58 3.93
#   ..- attr(*, "names")= chr [1:2] "(Intercept)" "speed"
#  $ residuals    : Named num [1:50] 3.85 11.85 -5.95 12.05 2.12 ...
#   ..- attr(*, "names")= chr [1:50] "1" "2" "3" "4" ...
###  y mucho más...

# "lm1" es una estructura con características de lista, así que contiene muchos objetos
# internos que pueden ser de varias clases. 
# Usando el operador "$" se puede acceder a los mismos, aunque también se pueden usar
# los paréntesis rectos dobles.
# Por ejemplo, para saber cuáles son los parámetros del modelo, se puede ejecutar el
# siguiente comando:
lm1$coefficients # ó
lm1[[1]]
# Son dos formas idénticas de pedir lo mismo, dado que el primer elemento de la lista
# [[1]], son los coeficientes.

# Usando la función "names" se pueden ver los nombres de los objetos incluidos (sólo
# a 1 nivel de profundidad):
names(lm1)
#  [1] "coefficients"  "residuals"     "effects"       "rank"         
#  [5] "fitted.values" "assign"        "qr"            "df.residual"  
#  [9] "xlevels"       "call"          "terms"         "model"

# Algunos de estos objetos tienen complejas series de "atributos", a los cuales se
# puede acceder usando la función "attributes":
attributes(lm1)        # nombres y clase
# Ahora si a la función "attributes" se le especifica uno de los nombres, devuelve
# un objeto tipo lista con un montón de información.
attributes(lm1$terms)

# Existe una amplia gama de funciones creadas especialmente para trabajar con modelos
# o tests estadísticos.
# Algunos ejemplos sencillos son:
fitted(lm1)     # valores ajustados, equivale a lm1$fitted.values
resid(lm1)      # residuos, equivale a lm1$residuals
coef(lm1)       # coeficientes, equivale a lm1$coefficients
confint(lm1)    # intervalos de confianza para dichos coeficientes
vcov(lm1)       # tabla de varianza-covarianza
rstandard(lm1)  # residuos estandarizados (dist. z)
rstudent(lm1)   # residuos "studentized" (dist. t)
logLik(lm1)     # log likelihood
AIC(lm1)        # criterio de información de Akaike
anova(lm1)      # significancia de la influencia de las variables

# Nota: muchas de estas funciones se pueden utilizar con varias clases de objetos,
# incluyendo regresiones no lineales, glm, etc...

# Las funciones de regresión, así como muchas otras que están pensadas para trabajar
# con data.frames, tienen muchas veces la opción "subset" para filtrar los valores
# de las variables:
lm2 <- lm(dist ~ speed, data=cars, subset=dist > 20)
# El argumento 'subset' se utiliza para realizar dicho filtro, en este caso hace la
# regresión pero solo con las observaciones tales que dist > 20

# Ojo!, los dos modelos lm1 y lm2 no son modelos comparables dado que no contienen
# el mismo conjunto de datos, lm2 tiene menos datos que lm1.

# Otra forma de filtrar datos pero de manera más precisa y detallada, es utilizando
# el signo de '-'
lm3 <- lm(dist ~ speed, data=cars[-c(23, 35, 49), ])
# Dentro del paréntesis recto se están eliminando las filas 23, 35 y 49.
# Como no son consecutivas, estas deben concatenarse con la función "c" y el signo
# de menos es para marcar que filas del data.frame cars se van a eliminar.
# Este modelo tampoco es comparable con ninguno de los otros dos anteriores, debido
# a que tienen distintos conjuntos de datos.

# Ahora sí ... un poco de interpretación de la salida (output) de R:
summary(lm1)

# Este modelo presenta una tasa de cambio (pendiente) que nos dice que por cada unidad
# de X que me muevo hacia la derecha, aumenta de manera significativa 3.9324 unidades
# de Y.
# El intercepto cuyo valor es -17.5791, nos dice cuánto vale Y cuando X es
# cero.
# El R2 (cuadrado) nos habla de qué tan bien nuestros datos se ajustan al modelo
# propuesto, en este caso una regresión simple. Es un coeficiente que va de 0 a 1, cuanto
# más cercano a 1 sea este valor, mejor ajuste tienen nuestro datos al modelo lineal
# (en este caso) propuesto.
# También es importante observar cual es la significancia de nuestros parámetros y
# modelo. Para eso nos informamos con el p-valor. 
# Si este es menor a 0.05, estamos en condiciones de rechazar la hipótesis nula del
# modelo que dice que no existe una relación lineal entre X e Y (pendiente = 0) y
# aceptar nuestro modelo y parámetros significativos, no como verdaderos sino como
# alternativos a la hipótesis nula.
# Por último nos entrega el valor del Test F (Fisher) junto con los grado de libertad.
# El valor de F observado se obtiene de la relación entre la media de la suma de los
# cuadrados de los valores observados y la media de la suma de cuadrados de los errores
# estándar. Este valor obtenido es comparado con la distribución F teórica y se
# utiliza una regla de decisión para rechazar o no la hipótesis nula. Dicha regla es
# rechazar la hipótesis nula si mi valor de F observado es mayor al valor de F teórico
# para n - 2 grados de libertad y un alfa=0.05.
# Los grados de libertad se pueden calcular teniendo en cuenta cuantos valores presenta
# mi variable y sustrayéndole la cantidad de parámetros que estoy evaluando en mi
# modelo. En este ejemplo F 1,48 = 89,47, la cantidad de parámetros es 2, a y b, así
# que son n - 2 la cantidad de grados de libertad.


# Nota: la función summary también devuelve un objeto tipo lista el cual puede ser de
# utilidad para utilizar a posteriori. Por ejemplo:
slm1 <- summary(lm1)
str(slm1)

# Esto permite acceder a varios valores, como el R^2 y el R^2 ajustado, usando el
# operador '$' o los dobles corchetes:
slm1$r.squared
slm1$adj.r.squared
slm1[[9]]

# A tener en cuenta...
# En ningún momento hemos evaluado los supuestos del modelo lineal general como ser
# la normalidad de los datos, la homogeneidad de varianza o la distribución de los
# residuales.

# Para finalizar queremos aclarar que la idea de este curso no es enseñar estadística,
# para eso existen un montón de cursos sobre la materia dictados por docentes entendidos
# sobre el tema. Sin embargo, como R es un software para realizar análisis estadísticos,
# por ese motivo no queríamos dejar de lado las interpretaciones mínimas de los análisis
# que pretendemos mostrar. Para mayor profundidad existe una gran diversidad de libros
# sobre R y Estadística, los cuales están a su disposición por parte nuestra si así lo
# desean.
