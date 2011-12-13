# a.
plot(lynx)
# La gráfica muetra una secuencia periódica de picos y valles muy marcados en
# la abunancia de linces capturados.

# b.
abline(h = 4200)
# Se observan cuatro momentos en que la gráfica cruza la línea horizontal

# Nota: esto es muy distinto que simplemente contar la cantidad de puntos 
# que ocurren por encima de ese valor. El conteo de puntos se puede hacer así:
sum(lynx > 4200)

# c.
plot(lynx, log='y')
# En esta escala las fluctuaciones no se alejan tanto del valor medio y lo 
# hacen con magnitudes similares hacia valores mayores y menores.



# d.
mlineal <- mean(lynx)
mlog    <- mean(log10(lynx))
mlineal / 10 ^ mlog
# La media lineal es aproximadamente el doble de la potencia de diez de la 
# media logarítmica

# e.
mlineal <- median(lynx)
mlog    <- median(log10(lynx))
mlineal / 10 ^ mlog
# Ambos valores son prácticamente iguales

# f.
qqnorm(log10(lynx))
qqline(log10(lynx), col=2, lwd=2)
# La correspondencia observada indica que es bastante razonable aceptar que 
# la distribución es normal.
