################################################################################################################
# Una de las funcionalidades primarias de R es trabajar con estadística, por esta razón los métodos y
# funciones existentes en R en este campo son inabarcables para cualquier curso. Sin embargo hay ciertos
# elementos comunes a la mayoría de los análisis, sobre todo en los más populares o tradicionales. Nos vamos a
# enfocar en estas características extendidas, utilizando algunos ejemplos sencillos de regresión lineal,
# regresión no lineal, glm y anova. También se muestra un pequeño ejemplo de análisis de cluster y algunos tests
# estadísticos comunes.
#
# Para profundizar en estos temas se pueden encontrar recursos y libros muy buenos en la web.
# 
# Para trabajar con modelos en R existen los objetos de clase "formula", los cuales tienen una sintaxis muy
# particular, hecha para facilitar la interacción entre el usuario y la función de R que hace el análisis. Sin
# embargo no es del todo intuitiva al principio dicha sintaxis, así que es necesario estar familiarizado con
# la misma antes de proseguir con esta lección. La lección fórmula está puesta para este fin.
#
# También es muy importante estar familiarizado con la forma en que actúan los factores, así que recomendamos
# ir a la lección homónima antes de continuar. Los factores son una representación de datos categóricos, los
# cuales tienen una notable facilidad para ser confundidos con vectores de clase "character". En particular las
# columnas de data.frames que uno puede pensar que son del tipo "character" son muchas veces "factor". A veces
# esta diferencia no importa mucho... a veces es fundamental no hacer la confusión.
################################################################################################################
 
################################################################################################################
## REGRESIÓN LINEAL
# Empezemos con la regresión lineal, una de las tareas más comunes y que sirve como referencia para otros
# análisis en general.
 
# usando la sintaxis de las fórmulas (que necesariamente incluyen el "~"), se puede hacer un plot entre
# distintas variables:
plot(dist ~ speed, data=cars)
# Exactamente la misma sintaxis se puede usar, pero esta vez con la función "lm", para hacer la regresión
# entre esas variables: 
ml <- lm(dist ~ speed, data=cars)
# usando la función gráfica LL "abline" podemos agregar la recta al gráfico:
abline(ml)
 
# Veamos el objeto generado:
ml # print.lm
 
# Call:
# lm(formula = dist ~ speed, data = cars)
# 
# Coefficients:
# (Intercept)        speed  
#     -17.579        3.932
 
# Una de las funciones más útiles para ver por arriba al objeto es "summary":
summary(ml)
 
# El objeto que devuelve la regresión, en este caso "ml", es de la clase "lm" (linear model). A pesar de la
# poca información que imprime en la consola inicialmente, en verdad es mucho más que eso:
str(ml)
# List of 12
#  $ coefficients : Named num [1:2] -17.58 3.93
#   ..- attr(*, "names")= chr [1:2] "(Intercept)" "speed"
#  $ residuals    : Named num [1:50] 3.85 11.85 -5.95 12.05 2.12 ...
#   ..- attr(*, "names")= chr [1:50] "1" "2" "3" "4" ...
#  y mucho más...
 
# "ml" es una estructura con características de lista, así que contiene muchos objetos internos que pueden
# ser de varias clases. Usando el operador "$" se puede acceder a los mismos, aunque también se pueden usar
# los paréntesis rectos dobles:
ml$coefficients
ml[[1]]
 
# usando la función "names" (o el autocompletar de RStudio) se pueden ver los nombres de los objetos incluidos
# (sólo a 1 nivel de "profundidad"):
names(ml)
#  [1] "coefficients"  "residuals"     "effects"       "rank"         
#  [5] "fitted.values" "assign"        "qr"            "df.residual"  
#  [9] "xlevels"       "call"          "terms"         "model"
 
# Algunos de estos objetos tienen complejas series de "atributos", a los cuales se puede acceder usando la
# función "attributes":
attributes(ml)        # nombres y clase
attributes(ml$terms)  # devuelve un objeto tipo lista con un montón de información
 
# Existe un montón de funciones creadas especialmente para trabajar con modelos o tests estadísticos, algunos
# nombres son: fitted, predict, resid, coef, rstandard, rstudent, logLik, deviance, formula, anova, coef, confint, vcov
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
 
# Así como summary puede trabajar con varias clases de objeto, plot también es una función genérica, que sirve
# con "lm" también:
plot(ml)
# Tira diagnósticos de la regresión, sirve para ver si se cumplen supuestos del análisis. Con otros tipos de
# objetos, como análisis de varianza, también se puede usar plot.
 
# ¿Qué es lo que está haciendo? Dado que
class(ml)  # es "lm"
# Entonces puedo consultar:
?plot.lm  # el sufijo indica que es la variante de plot que trabaja con
          # objetos de clase "lm"
# Lo mismo ocurre con las funciones print y summary (y muchas más)
 
 
################################################################################################################
## REGRESIONES NO LINEALES, CON MÍNIMOS CUADRADOS
 
?nls  # non-linear least squares
 
mnl <- nls(dist ~ int + a * speed ^ b, data=cars, start=list(int=0, a=1, b=1))
# La fórmula usada aquí incluye una variable, "speed", y dos parámetros "a" y "b". A pesar de que en las
# fórmulas los operadores "*" y "^" tienen significados particulares al trabajar con variables, al usar
# parámetros funcionan en su sentido aritmético "normal". Por lo tanto, en este caso no es necesario usar la
# función "I".
 
# El método de "nls" es iterativo y busca minimizar la suma de los cuadrados de los residuos ("least squares").
# Por esta razón la elección de los valores iniciales de los parámetros tiene influencia en el resultado final,
# ya que pueden existir distintos atractores locales para el método. El argumento "start" es una lista con
# los nombres de los parámetros y sus valores iniciales.
 
# Para examinar el objeto mnl varias funciones se pueden volver a usar:
mnl
summary(mnl)
str(mnl)
mnl$
# También tiene propiedades de lista...
 
predict(mnl)  # Este es un vector, es el resultado de aplicar el modelo ajustado
              # a los valores de speed presentes en cars
 
# Puedo usar predict para hacer el plot
plot(cars)
lines(predict(mnl) ~ speed, data=cars, col="red")
abline(mnl, col='blue')  # ¿Porqué no sirve abline en este caso?
 
# También puedo usar otras formas de superponer el modelo al plot
int <- coef(mnl)[1]
a   <- coef(mnl)[2]
b   <- coef(mnl)[3]
curve(int + a * x ^ b, add=TRUE, col="blue", lty=3, lwd=4)
# agregando add=TRUE agrega la curva al gráfico
 
# comparaciones del modelo lineal y el modelo potencial
logLik(ml)
logLik(mnl)
AIC(ml)
AIC(mnl)
 
# Las funciones de regresión, así como muchas otras que están pensadas para trabajar con data.frames, tienen
# muchas veces la opción "subset" para filtrar los valores de las variables:
ml2 <- lm(dist ~ speed, data=cars, subset=dist > 20)
# Hace la regresión pero sólo con las observaciones tales que dist > 20
 
 
################################################################################################################
## MODELOS LINEALES GENERALIZADOS (REGRESIÓN LOGIT)
 
# Los modelos lineales generalizados en R se implementan (por defecto) con la función "glm", usando la
# estructura básica:
 
modelo <- glm(mi.forumla, family=una.familia)
 
# Es decir, usamos una fórmula, como hemos visto ya, y además especificamos la familia a la que pertenece
# el modelo que nos interesa. Se pueden ver las posibles familias en el documento de ayuda:
?family
 
# Resumiendo:
# Family            Variance	        Link
#-------------------------------------------------------
# gaussian          gaussian	        identity
# binomial          binomial	        logit, probit or cloglog
# poisson           poisson           log, identity or sqrt
# Gamma             Gamma             inverse, identity or log
# inverse.gaussian	inverse.gaussian	1/mu^2
# quasi             user-defined      user-defined
 
# (de http://data.princeton.edu/R/glms.html)
 
# En esta lección nos vamos a limitar a la familia "binomial", usando la función link "logit"
# (ver http://en.wikipedia.org/wiki/Logit, por ejemplo).
 
# Para hacer un ejemplo de glm binomial-logit, vamos a usar el ejemplo planteado en esta página:
# http://www.ats.ucla.edu/stat/r/dae/logit.htm
 
# Para ingresar la tabla a R pueden usar este comando (con conexión a internet):
candidatos <- read.csv(url("http://www.ats.ucla.edu/stat/r/dae/binary.csv"))
# Si no pueden importar la tabla "candidatos.csv" dispuesta en el EVA
 
names(candidatos)  # Estas son las variables
 
# La tabla tiene una variable binaria, "admit", la cual muestra la admisión (o no) de los candidatos a entrar
# a una determinada escuela de graduados. Esta será la variable dependiente o de respuesta, mientras que
# GRE (Graduate Record Exam; puntaje en un examen de postuación (?)), GPA (Grade Point Average; escolaridad)
# son las variables explicativas o independientes y rank (prestigio de la universidad en donde se graduó: 1 es
# el máximo)
 
head(candidatos)
#   admit gre  gpa rank
# 1     0 380 3.61    3
# 2     1 660 3.67    3
# 3     1 800 4.00    1
# 4     1 640 3.19    4
# 5     0 520 2.93    4
# 6     1 760 3.00    2
 
# Se puede ver que gre y gpa son variables continuas (numéricas), mientras que rank es categórica.
 
# Para mirar un poco los datos:
with(candidatos, {
  print(summary(gre))
  print(summary(gpa))
  print(table(rank))
  print(table(rank, admit))
  })

# Se usa "print" para poder ver la salida de estos comandos
 
# ¿Hay algún dato faltante?
any(is.na(candidatos))  # FALSE
 
# La regresión logística de todas las variables se puede hacer así: 
milogit <- glm(admit ~ gre + gpa + as.factor(rank), family=binomial("logit"), na.action=na.pass, data=candidatos)
# Notas:
# - en family se puede poner simplemente "binomial", ya que "logit" es la opción por defecto
# - "na.action=na.pass" indica que en caso de que hubieran datos faltanes (NA) qué acción debe efectuarse, en
#    este caso es una función llamada "na.pass"
# - as.factor(rank) se usa para especificar que "rank" debe ser tratado como una variable categórica
 
milogit  # print.glm
summary(milogit)
# En la lista de coeficientes aparece
# as.factor(rank)2
# as.factor(rank)3
# as.factor(rank)4
 
# Pero no está el valor 1 ... esto es porque al ser categórica se toma como valor por defecto el primer nivel.
# Los coeficientes para los demás niveles muestran cuanto cambia la probabilidad de admisión al cambiar el
# valor de rank (por mayor detalle en la interpretación de los coeficientes, ver un libro sobre el tema).
# Nótese que el valor negativo de estos coeficientes es consistente con lo que esperamos de antemano (cuanto
# menor prestigio, menor probabilidad de admisión).
 
# Al igual que antes, el objeto creado es una estructura con varios niveles y muchas funciones siguen aplicando
# para este caso:
str(milogit)
coef(milogit)    # milogit$coefficients
confint(milogit)
vcov(milogit)
anova(milogit)
AIC(milogit)     # milogit$aic
logLik(milogit)
 
 
################################################################################################################
## ANALISIS DE VARIANZA
 
# En R la función "aov" es la que viene por defecto para hacer análisis de varianza.
 
# Primero que nada vamos a importar la tabla de ejemplo "anova-ej.csv" subida al EVA:
tabla <- read.csv("anova-ej.csv")  # la tabla debe estar en el directorio de trabajo...
 
# En este caso se trata de un experimento factorial de dos vías (factores ortogonales) inventado para el
# ejemplo. Los dos factores están en las primeras dos columnas. Las clases de ambos no necesariamente tienen
# que ser "factor", pero con ser variables categóricas es suficiente:
class(tabla$factor1)  # "factor"
class(tabla$factor2)  # "integer"
 
# Para ver si los tratamientos están balanceados se puede hacer un examen visual, o si no:
replications(tabla)  # aviso de alerta: factor2 y medida no son "factor"
 
# Esto se puede corregir:
tabla <- within(tabla, factor2 <- as.factor(factor2))
class(tabla$factor2)
# [1] "factor"
replications(tabla)  # medida no es "factor"
# También se puede usar una fórmula como argumento principal:
replications(medida ~ ., data=tabla)  # aquí el "." indica "todas las variables menos la dependiente"
 
# Para visualizar los efectos de los tratamientos:
plot(medida ~ factor1, data=tabla)
plot(medida ~ factor2, data=tabla)
 
# Se obtiene (casi) el mismo resultado con boxplot()
boxplot(medida ~ factor2, data=tabla)
 
# El análisis de varianza se puede hacer así:
x <- aov(medida ~ factor1 * factor2, data=tabla)
# Según la fórmula que usemos va a cambiar el resultado, ojo con esto...
x <- aov(medida ~ (factor1 + factor2) ^ 2, data=tabla)  # este es igual que el anterior
x <- aov(medida ~ factor1 + factor2 + factor1:factor2, data=tabla)  # y este también
x <- aov(medida ~ factor1 + factor2, data=tabla)  # pero en este caso se ignora el término de interacción...
x <- aov(medida ~ factor2, data=tabla)  # en este caso sólo toma el factor2
summary(x)  # devuelve una tabla de anova
anova(x)  # ídem
 
x          # print.aov
class(x)   # es "aov", pero también es un modelo lineal ("lm").
str(x)
coef(x)
confint(x)
# ... y muchas otras funciones ya mencionadas en "lm"
 
 
 
## Algunos test estadísticos comunes:

# t.test
x <- t.test(1:10, y=7:20)  # El test de Student
class(x)
summary(x)
names(x)
str(x)
 
################################################################################################################

# chisq.test
?chisq.test  # Test de chi cuadrado
 
# Ejemplo de la ayuda (se puede correr con "example(chisq.test)":
M <- as.table(rbind(c(762, 327, 468), c(484,239,477)))
dimnames(M) <- list(gender=c("M","F"), party=c("Democrat","Independent", "Republican"))
 
Xsq <- chisq.test(M)
Xsq            # Prints test summary
Xsq$observed   # observed counts (same as M) 
Xsq$expected   # expected counts under the null
Xsq$residuals  # Pearson residuals
Xsq$stdres     # standardized residuals
 
################################################################################################################

# fisher.test
??fischer
?fisher.test
ftest <- fisher.test(M)
ftest
names(ftest)
str(ftest)
 
################################################################################################################

# ACF
# Trabaja con series de tiempo ("ts")
?lh       # luteinizing hormone
plot(lh)
class(lh)
x <- acf(lh)
y <- pacf(lh)
names(x)
names(y)
 
################################################################################################################
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
# el argumento "method" sirve para definir el tipo de distancia computado entre vectores (cada vector es una
# columna de la data frame)
class(dista)
# Es un objeto de clase "dist", una matriz de distancia (pero no es de clase "matrix"...). Se puede convertir en
# matriz con "as.matrix"
 
# Para ver los atributos de este objeto, se puede usar: 
attributes(dista)
 
# Existen varios métodos de aglomeración para crear el cluster (ver ayuda de hclust)
hcArrests  <- hclust(dista, method='average')
 
hcArrests2 <- hclust(dista, method='complete')
 
# La salida de hclust es una lista
is.list(hcArrests)  # TRUE
str(hcArrests)
hcArrests$  # + tab para autocompletar
 
# Para visualizarlo
plot(hcArrests)
plot(hcArrests2)
 
 
################################################################################################################
## NOTA FINAL: como se mencionaba al principio de esta lección, hay una infinidad de funciones y paquetes de R
## para trabajar con estadística, muchas variantes de la forma de usar estas funciones y de las funciones en sí.
################################################################################################################
