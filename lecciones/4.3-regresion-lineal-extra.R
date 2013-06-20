
# REGRESIÓN LINEAL MÚLTIPLE 

# Ahora veremos que ocurre cuando nuestro modelo estadístico tiene más de una variable explicativa.

Y = a + b1*X1 + b2*X2 + b3*X3 + e
# En donde cada Xn es una pendiente 'parcial' del modelo.
# Dicha pendiente parcial indica la tasa de cambio de la variable Y cuando las demás X's son constantes.
# La hipótesis nula de la regresión múltiple establece que no existe relación entre las variables Xn e Y. 

# A modo de ejemplo usaremos otra base de datos que tiene por defecto R, trees:
?trees

lmm1 <- lm(Volume ~ Girth + Height, data=trees)
summary(lmm1)

# Call:
# lm(formula = Volume ~ Girth + Height, data = trees)

# Residuals:
#  Min      1Q  Median      3Q     Max 
# -6.4065 -2.6493 -0.2876  2.2003  8.4847 

# Coefficients:
#  Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -57.9877     8.6382  -6.713 2.75e-07 ***
#  Girth         4.7082     0.2643  17.816  < 2e-16 ***
#  Height        0.3393     0.1302   2.607   0.0145 *  
#  ---
#  Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 

# Residual standard error: 3.882 on 28 degrees of freedom
# Multiple R-squared: 0.948,  Adjusted R-squared: 0.9442 
# F-statistic:   255 on 2 and 28 DF,  p-value: < 2.2e-16

# En este caso tenemos tres parámetros estimados en total, dos pendientes y un intercepto.

# Otra forma de ver cuáles son los coeficientes, como vimos en la lección anterior, es con el comando coef:
coef(lmm1)

# (Intercept)       Girth      Height 
# -57.9876589   4.7081605   0.3392512 

# Si queremos saber cuáles son los residuales del modelo, utilizo la función residuals:
  
residuals(lmm1)

# La interpretación de la salida es similar a la de la regresión simple, salvo que en este caso hay dos pendientes y no solo una.
summary(lmm1)
# Ahora cada parámetro obtenido (excepto el intercepto) es una pendiente parcial, que debe ser interpretada como:
# cuanto cambia la variable de respuesta cuando me muevo una unidad de mi pendiente Xi manteniendo a mis otras pendientes constantes. En este caso como no hay interacción entre las variables solo se está evaluando el efecto directo de cada una de ellas sobre la variable respuesta y estamos dejando de lados los efectos indirectos.


# En el caso de la regresión múltiple, la relación funcional está dada entre una variable de respuesta y k-variables explicativas. En este sentido, debemos tener en cuenta la correlación entre las distintas variables independientes, la interacción entre ellas y cuidar que el modelo no quede sobreajustado.



