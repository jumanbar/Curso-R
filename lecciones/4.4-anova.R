
# ANALISIS DE VARIANZA

# El Análisis de Varianza o ANOVA por sus siglas en inglés, es un modelo estadístico
# que evalúa si las medias de distintos grupos son iguales. Su versión más simple es aquella
# en la cual dos grupos distintos son comparados considerando solo los efectos fijos de los
# mismos. Este caso particular es llamado comúnmente Test de t.
# El modelo estadístico clásico del análisis de varianza de efecto fijo es el siguiente (no correr):
y_ij = mu + a_i + e_ij

# donde y_ij es la observación j del grupo i (nótese que cada grupo es un nivel de un 
# factor o 'tratamiento'), 'mu' es la media global poblacional, 'a_i' es la media del 
# grupo i y e_ij es el error aleatorio correspondiente a esta observación.
# Cada 'a_i' evalúa el efecto del i-ésimno nivel de mi factor. Este se puede definir como
# la diferencia entre la media poblacional 'mu' y la media de cada grupo i 'mu_i' (no correr):
a_i = mu - mu_i.

# Para el caso del anova, la hipótesis nula del modelo estadístico es que las medias de
# cada uno de los grupos i son iguales, es decir todos tienen el mismo efecto. Es decir (no correr):
H_0: mu = mu_1 = mu_2 = ... = mu_i = ... = mu_k    # k = número de niveles

# Por lo tanto con que una de las medias sea diferente de las del resto ya se estaría
# rechazando la hipótesis nula.
# Atención: sólo con un ANOVA no es posible conocer cual o cuales medias son diferentes entre sí,
# para eso se deben realizar los llamados test a posteriori y realizar correcciones del tipo 
# Bonferroni o sus derivadas.

# En R la función "aov" es la que viene por defecto para hacer análisis de varianza. Utilice
# la ayuda para ver que argumentos requiere dicha función:
?aov

# Como dijimos el anova evalúa diferencias entre grupos, por ese motivo la fórmula del modelo
# contiene una variable de respuesta continua y la variable explicativa con los distintos grupos i.
# Por ejemplo:
anova1 <- aov(len ~ supp, data=ToothGrowth)
# # El objeto 'anova1' realiza un análisis de varianza utilizando las variables 'len' y 'supp'
# contenidas en el data.frame 'ToothGrowth' (para más información usar '?ToothGrowth')

# Como en la función 'lm', la función 'aov' también requiere como argumentos la fórmula del
# modelo y la base de datos de donde pretendo utilizar los datos.
# En este caso la fórmula es ligeramente diferente:
y ~ grp

# Donde 'y' es la variable de respuesta con distribución Normal(0, sigma2) y 'grp' es la
# variable explicativa, en este caso son los distintos grupos, por lo tanto es una variable
# categórica o factor.

# Para conocer qué tipo de variables estamos relacionado, se puede utilizar la función 'str'
# y consultar la base de datos que estamos analizando:
str(ToothGrowth)

# 'data.frame':  60 obs. of  3 variables:
# $ len : num  4.2 11.5 7.3 5.8 6.4 10 11.2 11.2 5.2 7 ...
# $ supp: Factor w/ 2 levels "OJ","VC": 2 2 2 2 2 2 2 2 2 2 ...
# $ dose: num  0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 0.5 ...

# Como puede verse, lo primero que nos muestra la función es el tipo de clase de objeto que
# es ToothGrowth, un data.frame y nos dice cuantas observaciones (filas) y variables
# (columnas) contiene.
# En las siguientes tres filas se describen cada una de las variables. La variable 'len' es 
# una variable numérica, 'supp' es una variable tipo factor con dos niveles 'OJ' y 'VC' y
# la variable 'dose' es una variable numérica.

# ¿Que ocurre cuando imprimimos el objeto anova1?
anova1
# La salida que nos da el R en la consola es un resumen de información básica, donde nos
# muestra en la primer línea la fórmula que equivaldría a nuestro modelo estadístico.
# En la segunda línea nos da una tabla con distintos términos:
# La suma de cuadrados y los grados de libertad para la variable 'supp' y los residuales.

# Al igual que para la función 'lm' y muchas otras más, podemos utilizar la función summary
# para solicitar más información:
summary(anova1)

#             Df Sum Sq Mean Sq F value Pr(>F)  
# supp         1    205  205.35   3.668 0.0604 .
# Residuals   58   3247   55.98                 
# ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 

# Como se puede observar la información es muy similar a la obtenida anteriormente, sólo que
# está organizada de diferente manera.
# Además de la suma de cuadrados y los grados de libertad para la variable 'supp' y los 
# residuales, también nos da la media de la suma de cuadrados para ambos y el cociente entre
# ellos que equivaldría al valor estadístico F observados para nuestro modelo y con eso es 
# posible obtener la significancia de dicho valor al ser comparado con la distribución teórica
# de F.
# En este caso el '.' nos está indicando que no existen diferencias estadísticamente 
# significativas entre las dos medias evaluadas por encontrarse esta diferencia por encima del
# p-valor 0.05. Esto significa que la hipótesis nula no puede ser rechazada. Sin embargo, si 
# existe una tendencia dado que el p-valor es menor a 0.1, es decir nuestro valor observado se 
# encuentra entra en la distribución teórica de F, por encima del 90% de la distribución de los
# datos.

# La otra forma de acceder a la información del modelo 'anova1' es usando la función "str":
str(anova1)

# En los modelos de análisis de varianza también es posible conocer los distintos objetos 
# presentes dentro de la lista 'anova1'
# Por ejemplo:
anova1[[1]] # Nos da los coeficientes del modelo.
# (Intercept)      suppVC 
#    20.66333    -3.70000 

# Como interpretar esto...
# El intercepto del modelo hace referencia a uno de los grupos evaluados por el modelo, en este
# caso el grupo 'OJ'. El valor del coeficiente es la media de dicho grupo. En este caso 'OJ' 
# estaría siendo como la media global mu, en nuestro modelo genérico arriba, es el grupo de 
# referencia. R utiliza un criterio alfabético para elegir al grupo de referencia, por este 
# motivo en este caso es 'OJ'. 
# El otro coeficiente es el a_i, es decir, es la diferencia entre mu y mu_i, la media global y
# la media del grupo i, en este caso la media del grupo 'VC'.
# Para conocer cuál es la media del grupo 'VC' se le resta a la media del grupo 'OJ'(20.66) el
# valor de a_i(3.7), esto nos da un valor de 16.96.

# Otra forma de conocer las medias de mis dos grupos sin tener que realizar cuentas es haciendo
# que el modelo no tenga intercepto:
anova2 <- aov(len ~ supp - 1, data=ToothGrowth)

coef(anova2) # Observe que aquí utilicé otro comando para obtener los coeficientes de mi modelo

# suppOJ   suppVC 
# 20.66333 16.96333 


# En esencia el modelo estadístico del análisis de varianza es una regresión lineal, en donde 
# cada variable categórica b está asociada a una matriz X de diseño:

Y = b_0 + b_1*X_1 + b_2*X_2 + e ---> Y = b %*% X + e

# b_0 corresponde a la media global o grupo de referencia, al igual que mu en un modelo anova y 
# X es la matriz con las variables como columnas (siendo la primer columna compuesta por una 
# repetición de unos, que multiplican a b_0).
# Cada 'b_k' es el parámetro a estimar para el grupo k y se define como la diferencia entre la
# media poblacional y la media del dicho grupo (en otras palabras b_i = a_i para todo i >= 0).

# Utilizando nuestro modelo de anova1 realizaremos el mismo modelo pero ahora con la función 'lm':

anova3 <- lm(len ~ supp, data=ToothGrowth) # Lo único que se modifico es la función que se utiliza...

# ¿Que ocurre cuando imprimimos el objeto anova3?
anova3

# Obtenemos una salida muy similar a la del objeto 'anova1'

# Nos brinda la fórmula los coeficientes del modelo, mientras que para el otro caso nos brindaba
#la suma de cuadrados para el grupo 'supp' y los residuales...

# Ahora si utilizamos la función summary:
summary(anova3)
# y comparando con el summary(anova1), observamos que la salida de la regresión no solo nos
# da el valor de F y su significancia, sino que también nos da el valor estimado de los 
# coeficiente con su significancia, el valor del R2 y la significancia del modelo.

# Los invitamos a comparar los valores y ver si estos son iguales o difieren...

# Si a nuestro modelo lineal le sacamos el intercepto, el valor de los coeficientes van a ser
# las medias de cada grupo y no vamos a tener que realizar ninguna cuenta para obtenerlas, al 
# igual que vimos arriba...

anova4 <- lm(len ~ supp - 1, data=ToothGrowth)
summary(anova4)

# Como se pudo observar, el análisis de varianza no es más que una regresión lineal dentro de un
# modelo lineal general y no un modelo totalmente diferente y sin conexión ninguna. Esto nos 
# facilita mucho a la hora de tener que pensar en los modelos y como interpretarlos, si son 
# parte de lo mismo, va a ser más sencillo.

# A modo de información el test de t es un caso particular para el ANOVA de una Vía, en donde 
# solo se comparan las medias de dos grupos. En todos los demás casos de ANOVA de una Vía para
# tres o dos grupos o para más de una sola Vía el nombre que se utiliza para denominar el 
# análisis es ANOVA.


# A modo de conclusión:

# El análisis de varianza se puede hacer de la siguiente manera siguiendo el ejemplo genérico:
x <- aov(medida ~ factor1 * factor2, data=tabla)
# Para cuando queremos evaluar si hay interacción entre factores.
# Según la fórmula que usemos va a cambiar el resultado, ojo con esto...
x <- aov(medida ~ (factor1 + factor2) ^ 2, data=tabla)  # este es igual que el anterior
x <- aov(medida ~ factor1 + factor2 + factor1:factor2, data=tabla)  # y este también
x <- aov(medida ~ factor1 + factor2, data=tabla)  # pero en este caso se ignora el término de interacción...
x <- aov(medida ~ factor2, data=tabla)  # en este caso sólo toma el factor2

# Recuerde que la función 'aov' puede ser sustituida por la función 'lm' y obtendrá el mismo resultado.

# Algo que siempre se aconseja, pero que a veces los diseños de muestreo no lo permite por
# distintos motivos, es que los tratamientos estén balanceaos. Es decir, que exista la misma
# cantidad de datos para cada uno de los diferentes grupos.

# Para ver si los tratamientos están balanceados se puede hacer un examen visual, o si no hay
# varias opciones. Para el caso más sencillo (ANOVA de una sola vía) se puede usar table para
# contar la cantidad de réplicas por nivel del factor:
table(ToothGrowth$supp) # Están balanceados

# En casos sofisticados, la función replications es más útil. En caso de que los datos estén
# balanceados, devuelve un vector, como en el caso siguiente:
replications(len ~ supp, data = ToothGrowth)

tg2 <- ToothGrowth # Una copia de la data.frame para no modificarla
tg2$len[12] <- NA  # Convierto un dato bueno en "faltante"
replications(len ~ supp, data = tg2)

# Nótese la diferencia de salida de los dos llamados a replications. Puede usarse la siguiente 
# línea como test para determinar si se trata de tratamientos balanceados o no:
!is.list(replications(len ~ supp, data = tg2))

# Para más información consulte en la ayuda:
?replications
