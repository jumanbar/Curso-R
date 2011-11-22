# Estadística en R

# Una de las funcionalidades primarias de R es trabajar con datos y realizar
# análisis estadísticos, por esta razón los métodos y funciones existentes en R
# en este campo son inabarcables para cualquier curso. Sin embargo hay ciertos
# elementos comunes a la mayoría de los análisis, sobre todo en los más
# populares o tradicionales. Nos vamos a enfocar en estas características
# extendidas, utilizando algunos ejemplos sencillos de regresión lineal,
# regresión no lineal, glm y anova.

# También se muestra un pequeño ejemplo de análisis de cluster y algunos tests
# estadísticos comunes. Para profundizar en estos temas se pueden encontrar
# recursos y libros muy buenos en la web.

#==============================================================================#
# Pequeña nota de advertencia: Fórmulas y factores

# Para trabajar con modelos en R existen los objetos de clase "formula", los
# cuales tienen una sintaxis muy particular, hecha para facilitar la interacción
# entre el usuario y la función de R que hace el análisis. Sin embargo no es del
# todo intuitiva al principio dicha sintaxis, así que es necesario estar
# familiarizado con la misma antes de proseguir con esta lección. Por esta
# razón lo más lógico y recomendable es leer la lección correspondiente
# antes de proseguir con esta lección.

# Lo mismo vale también para la lección dedicada a factores. Los factores son
# una representación de datos categóricos, los cuales tienen una notable
# facilidad para ser confundidos con vectores de clase "character".
# En particular las columnas de data.frames que uno puede pensar que son del
# tipo "character" son muchas veces "factor". A veces esta diferencia no importa
# mucho, pero a veces es fundamental no hacer esta confusión.
#==============================================================================#
 

# REGRESIÓN LINEAL

# Empezemos con la regresión lineal, una de las tareas más comunes y que sirve
# como referencia para otros análisis en general.
 
# Qsando la sintaxis de las fórmulas (que necesariamente incluyen el "~"), se
# puede hacer un plot entre distintas variables numéricas:
plot(dist ~ speed, data=cars) # cars es una base de datos que viene por
                              # defecto dentro del R y presenta dos variables:
                              # 'dist' y 'speed'
# Exactamente la misma sintaxis se puede usar, pero esta vez con la función
# "lm", para hacer la regresión lineal entre esas variables: 
ml <- lm(dist ~ speed, data=cars)
# El objeto creado contiene toda la información de la regresión lineal
# obtenida. Es importante saber utilizar las facilidades que tiene R para
# acceder y manejar esta información.

# De hecho el mensaje más importante de la lección es aprender a utilizar
# este tipo de objetos. Veremos algunos ejemplos "populares" y algunas reglas
# genéricas.

# Usando la función gráfica llamada "abline" podemos agregar la recta al
# gráfico:
abline(ml) # La función abline no sólo tiene esta funcionalidad, como se
           # puede ver en la lección sobre gráficos.

# Veamos el objeto generado: si escribimos el nombre del mismo en la consola,
# R nos muestra la información más básica del modelo: la fórmula del modelo
# y los coeficientes obtenidos.
ml

# La información que se imprime en la consola está determinada por la
# función print.lm.

# Una de las funciones más útiles para ver de forma rápida el objeto generado es
# "summary" (la cual sirve para muchas clases de objetos):
summary(ml)

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
# Multiple R-squared: 0.6511,	Adjusted R-squared: 0.6438 # R cuadrado
# F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12 


# Otra forma popular, y más completa, de acceder a la información del objeto
# "ml" es usando la función "str":

str(ml)
# List of 12
#  $ coefficients : Named num [1:2] -17.58 3.93
#   ..- attr(*, "names")= chr [1:2] "(Intercept)" "speed"
#  $ residuals    : Named num [1:50] 3.85 11.85 -5.95 12.05 2.12 ...
#   ..- attr(*, "names")= chr [1:50] "1" "2" "3" "4" ...
###  y mucho más...

# "ml" es una estructura con características de lista, así que contiene muchos
# objetos internos que pueden ser de varias clases. Usando el operador "$" se
# puede acceder a los mismos, aunque también se pueden usar los paréntesis
# rectos dobles:
ml$coefficients
ml[[1]]
 
# usando la función "names" (o el autocompletar de RStudio) se pueden ver los
# nombres de los objetos incluidos (sólo a 1 nivel de profundidad):
names(ml)
#  [1] "coefficients"  "residuals"     "effects"       "rank"         
#  [5] "fitted.values" "assign"        "qr"            "df.residual"  
#  [9] "xlevels"       "call"          "terms"         "model"
 
# Algunos de estos objetos tienen complejas series de "atributos", a los cuales
# se puede acceder usando la función "attributes":
attributes(ml)        # nombres y clase
attributes(ml$terms)  # devuelve un objeto tipo lista con un montón de
                      # información
 
# Existe un montón de funciones creadas especialmente para trabajar con modelos
# o tests estadísticos.
# Algunos ejemplos sencillos son:
fitted(ml)     # valores ajustados, equivale a ml$fitted.values
resid(ml)      # residuos, equivale a ml$residuals
coef(ml)       # coeficientes, equivale a ml$coefficients
confint(ml)    # intervalos de confianza para dichos coeficientes
vcov(ml)       # tabla de varianza-covarianza
rstandard(ml)  # residuos estandarizados (dist. z)
rstudent(ml)   # residuos "studentized" (dist. t)
logLik(ml)     # log likelihood
AIC(ml)        # criterio de información de Akaike
anova(ml)      # significancia de la influencia de las variables
 
# Los métodos gráficos para trabajar con modelos de regresión tienen sus
# particularidades:
plot(ml)
# Este comando nos sirve para ver diagnósticos de la regresión, a fin de
# evaluar los supuestos necesarios para validar el modelo (como por ejemplo,
# normalidad en los residuos, homogeneidad de varianza).

# Al igual que con print.lm, plot.lm es la función que especifica el
# comportamiento del comando anterior. Las extensiones en los nombres de las
# funciones (como pueden ser .lm, .data.frame o .ts) indican la función
# específica que sirve para trabajar con la clase indicada.
 
 
# REGRESIONES NO LINEALES, CON MÍNIMOS CUADRADOS

# Para modelos no lineales es necesario trabajar con métodos un poco más
# sofisticados. Uno de los más populares es la regresión no lineal de
# mínimos cuadrados. En R: 
?nls  # non-linear least squares

# Veamos un ejemplo:
mnl <- nls(dist ~ int + a * speed ^ b, data=cars, start=list(int=0, a=1, b=1))
# La fórmula usada aquí incluye una variable, "speed", y dos parámetros "a" y
# "b". A pesar de que en las fórmulas los operadores "*" y "^" tienen
# significados particulares, al usar parámetros (a diferencia de cuando lo
# hacen con variables) funcionan en su sentido aritmético "normal". Por lo
# tanto, en este caso no es necesario usar la función "I" (aunque siempre se
# puede esribir ·dist ~ I(int + a * speed ^ b)", si estamos en duda).
 
# El método de "nls" es iterativo y busca minimizar la suma de los cuadrados de
# los residuos. Por esta razón la elección de los valores iniciales de los
# parámetros tiene influencia en el resultado final, ya que pueden existir
# distintos atractores locales, asociados a otros valores de los coeficientes.
# El argumento "start" indica este punto de partida: es una lista con los
# nombres de los parámetros y sus valores iniciales.
 
# Para examinar el objeto mnl varias funciones se pueden volver a usar, de
# forma similar a lo que ocurría con objetos de clase "lm":
mnl
summary(mnl)
str(mnl)

# Este objeto también tiene propiedades de lista, así que se puede usar el
# operador $ para acceder a sus elementos, aunque hay que tener en cuenta que
# su estructura es bastante diferente a la de un objeto "lm":

mnl$call

predict(mnl)
# Este es un vector, es el resultado de aplicar el modelo ajustado a los valores
# de speed presentes en cars. Utilizando el argumento newdata podemos determinar
# las predicciones del modelo para cualquier valor de entrada:
predict(mnl, newdata=c(speed=3))
speed2 <- data.frame(speed=3:150)
dist2  <- predict(mnl, newdata=speed2)
plot(dist2 ~ speed2[,1], type='l')
# Podemos ver que el modelo predice que, a una velocidad de 150 millas por
# hora (241 km/h) ¡el auto necesita aprox. 2000 pies (610 m) para frenar!

# Puedo usar predict para superponer el modelo a los datos:
plot(cars)
lines(predict(mnl) ~ speed, data=cars, col="red")
# Alternativamente:
p <- coef(mnl)
curve(p['int'] + p['a'] * x ^ p['b'], col=2, add=TRUE, lty=3, lwd=4)
 
# Comparaciones del modelo lineal y el modelo potencial: muchas veces la
# desición por uno u otro modelo debe ser evaluada con criterios bastante
# sofisticados. En R varios de estos métodos ya están implementados, como por
# ejemplo el LogLikelihood:
logLik(ml)
logLik(mnl)
# O el más adecuado "Criterio de Información de Akaike" (si es menor, es
# mejor).
AIC(ml)
AIC(mnl)
 
# Las funciones de regresión, así como muchas otras que están pensadas para
# trabajar con data.frames, tienen muchas veces la opción "subset" para filtrar
# los valores de las variables:
ml2 <- lm(dist ~ speed, data=cars, subset=dist > 20)
# Hace la regresión pero sólo con las observaciones tales que dist > 20


# MODELOS LINEALES GENERALIZADOS (REGRESIÓN LOGIT)
 
# Los modelos lineales generalizados en R se implementan (por defecto) con la
# función "glm", usando la estructura básica:
 
modelo <- glm(mi.forumla, family=una.familia, data=mi.data.frame)
 
# Es decir, usamos una fórmula, como hemos visto ya, y además especificamos la
# familia a la que pertenece el modelo que nos interesa. Se pueden ver las
# posibles familias en el documento de ayuda:
?family
# Allí se muestran estas famlias:

# Family            Variance          Link
#-------------------------------------------------------
# gaussian          gaussian          identity
# binomial          binomial          logit, probit or cloglog
# poisson           poisson           log, identity or sqrt
# Gamma             Gamma             inverse, identity or log
# inverse.gaussian  inverse.gaussian  1/mu^2
# quasi             user-defined      user-defined
 
# (fuente http://data.princeton.edu/R/glms.html)
 
# En esta lección nos vamos a limitar a la familia "binomial", usando la función
# link de conexión "logit"
# (ver http://en.wikipedia.org/wiki/Logit, por ejemplo).
 
# Para hacer un ejemplo de glm binomial-logit, vamos a usar el ejemplo planteado
# en esta página:
# http://www.ats.ucla.edu/stat/r/dae/logit.htm
 
# Para ingresar la tabla a R pueden usar este comando (con conexión a internet):
candidatos <- read.csv(url("http://www.ats.ucla.edu/stat/r/dae/binary.csv"))
# Si no pueden importar la tabla "candidatos.csv" dispuesta en el EVA
 
names(candidatos)  # Estas son las variables
 
# La tabla tiene una variable binaria, "admit", la cual muestra la admisión
# (o no) de los candidatos a entrar a una determinada escuela de graduados.
# Esta será la variable dependiente o de respuesta, mientras que GRE (Graduate
# Record Exam; puntaje en un examen de postuación (?)), GPA (Grade Point Average;
# escolaridad) son las variables explicativas o independientes y rank (prestigio
# de la universidad en donde se graduó: 1 es el máximo)
 
head(candidatos)
 
# Se puede ver que gre y gpa son variables continuas (numéricas), mientras que
# rank es categórica.
 
# Para mirar un poco los datos:
summary(candidatos$gre)
summary(candidatos$gpa)
table(candidatos$rank)
table(candidatos$rank, candidatos$admit)
 
# ¿Hay algún dato faltante?
any(is.na(candidatos))  # FALSE
 
# La regresión logística de todas las variables se puede hacer así: 
milogit <- glm(admit ~ gre + gpa + as.factor(rank), family=binomial("logit"),
               na.action=na.pass, data=candidatos)
# Notas:
# - en family se puede poner simplemente "binomial", ya que "logit" es la
# opción por defecto --"na.action=na.pass" indica, en caso de que hubieran
# datos faltanes (NA), qué acción debe efectuarse, en este caso es una función
# llamada "na.pass"-- as.factor(rank) se usa para especificar que "rank" debe
# ser tratado como una variable categórica.
 
milogit
summary(milogit)
# En la lista de coeficientes aparece:
# as.factor(rank)2
# as.factor(rank)3
# as.factor(rank)4
 
# Pero no está el valor 1 ... esto es porque la variable rank es categórica,
# por lo que se toma como valor por defecto el primer nivel. Los coeficientes
# para los demás niveles muestran cuanto cambia la probabilidad de admisión al
# cambiar el valor de rank (por mayor detalle en la interpretación de los
# coeficientes, ver un libro sobre el tema, como Hosmer & Lemeshow 2004).
# Nótese que el valor negativo de estos coeficientes es consistente con lo que
# esperamos de antemano (cuanto menor prestigio, menor probabilidad de
# admisión).
 
# Al igual que antes, el objeto creado es una estructura con varios niveles y
# muchas funciones siguen aplicando para este caso:
str(milogit)
coef(milogit)    # milogit$coefficients
confint(milogit)
vcov(milogit)
anova(milogit)
AIC(milogit)     # milogit$aic
logLik(milogit)
 
 

## ANALISIS DE VARIANZA
 
# En R la función "aov" es la que viene por defecto para hacer análisis de
# varianza.
 
# Primero que nada vamos a importar la tabla de ejemplo "anova-ej.csv" subida
# a la página del curso:
tabla <- read.csv("anova-ej.csv")  # la tabla debe estar en el directorio de
                                   # trabajo...
 
# En este caso se trata de un experimento factorial de dos vías (factores
# ortogonales) inventado para el ejemplo. Los dos factores están en las primeras
# dos columnas. Las clases de ambos no necesariamente tienen que ser "factor",
# pero con ser variables categóricas es suficiente:
class(tabla$factor1)  # "factor"
class(tabla$factor2)  # "integer"
 
# Para ver si los tratamientos están balanceados se puede hacer un examen
# visual, o si no:
replications(tabla)  # aviso de alerta: factor2 y medida no son "factor"
 
# Esto se puede corregir:
tabla <- within(tabla, factor2 <- as.factor(factor2))
class(tabla$factor2)
# [1] "factor"
replications(tabla)  # medida no es "factor"
# También se puede usar una fórmula como argumento principal:
replications(medida ~ ., data=tabla)  # aquí el "." indica "todas las variables
                                      # menos la dependiente"
 
# Para visualizar los efectos de los tratamientos:
plot(medida ~ factor1, data=tabla)
plot(medida ~ factor2, data=tabla)
 
# Se obtiene (casi) el mismo resultado con boxplot()
boxplot(medida ~ factor2, data=tabla)
 
# El análisis de varianza se puede hacer así:
x <- aov(medida ~ factor1 * factor2, data=tabla)
# Según la fórmula que usemos va a cambiar el resultado, ojo con esto...
x <- aov(medida ~ (factor1 + factor2) ^ 2, data=tabla)  # este es igual que el
                                                        # anterior
x <- aov(medida ~ factor1 + factor2 + factor1:factor2, data=tabla)  # y este
                                                                    # también
x <- aov(medida ~ factor1 + factor2, data=tabla)  # pero en este caso se ignora
                                                  # el término de interacción...
x <- aov(medida ~ factor2, data=tabla)  # en este caso sólo toma el factor2
summary(x)  # devuelve una tabla de anova
anova(x)  # ídem
 
x
class(x)   # es "aov", pero también es un modelo lineal ("lm").
str(x)
coef(x)
confint(x)
# ... y muchas otras funciones ya mencionadas en "lm"
 


# EXTRAS
# En esta sección se muestran algunos tests estadísticos comunes y un método
# de ordenamiento sencillo y bastante popular: análisis de cluster jerárquico. 

# Algunos test estadísticos comunes: vamos a mirar ahora, de forma muy
# superficial, los comandos que tiene R por defecto para hacer varios tests
# populares:
 
# t.test
x <- t.test(1:10, y=7:20)  # El test de Student
class(x)
summary(x)
names(x)
str(x)
 
 
# chisq.test
?chisq.test  # Test de chi cuadrado
 
# Ejemplo de la ayuda (se puede correr con "example(chisq.test)":
M <- as.table(rbind(c(762, 327, 468), c(484,239,477)))
dimnames(M) <- list(gender=c("M","F"), party=c("Democrat","Independent",
"Republican"))
 
Xsq <- chisq.test(M)
Xsq            # Prints test summary
Xsq$observed   # observed counts (same as M) 
Xsq$expected   # expected counts under the null
Xsq$residuals  # Pearson residuals
Xsq$stdres     # standardized residuals
 
 
# fisher.test
??fischer
?fisher.test
ftest <- fisher.test(M)
ftest
names(ftest)
str(ftest)
 

# ACF
# Trabaja con series de tiempo ("ts")
?lh       # luteinizing hormone
plot(lh)
class(lh)
x <- acf(lh)
y <- pacf(lh)
names(x)
names(y)
 


## ANÁLISIS DE CLUSTER JERÁRQUICO
 
# El R básico tiene la función hclust (paquete "stats")
?hclust
 
# Necesita como entrada un objeto de clase "dist", que se genera con la
# función homónima:
?dist
 
# El ejemplo de la documentación
head(USArrests)
?USArrests
 
# Para crear una matriz de distancia (usando distancia euclidiana por defecto)
dista <- dist(USArrests)
# "dist" tiene varios argumentos:
args(dist)
# el argumento "method" sirve para definir el tipo de distancia computado entre
# vectores (cada vector es una columna de la data frame)
class(dista)
# Es un objeto de clase "dist", una matriz de distancia (pero no es de clase
# "matrix"...). Se puede convertir en matriz con "as.matrix"
 
# Para ver los atributos de este objeto, se puede usar: 
attributes(dista)
 
# Existen varios métodos de aglomeración para crear el cluster (ver ayuda de
# hclust)
hcArrests  <- hclust(dista, method='average')
 
hcArrests2 <- hclust(dista, method='complete')
 
# La salida de hclust es una lista
is.list(hcArrests)  # TRUE
str(hcArrests)
hcArrests$  # + tab para autocompletar
 
# Para visualizarlo
plot(hcArrests)
plot(hcArrests2)
 
 
################################################################################
# NOTA FINAL: como se mencionaba al principio de esta lección, hay una
# infinidad de funciones y paquetes de R para trabajar con estadística, muchas
# variantes de la forma de usar estas funciones y de las funciones en sí.
################################################################################
