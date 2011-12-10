# a.
filasActiv <- which(beaver2$activ == 1)
beaver2$time[filasActiv[1]]
# Hora 15:50

# Extra: para poner las horas de la madrugada al final en el gráfico:
madr <- which(beaver2$time < 201)
beaver2$time[madr] <- beaver2$time[madr] + 2400

# b.
colores <- rep('blue', nrow(beaver2))
colores[beaver2$activ == 1] <- 'red'

plot(temp ~ time, beaver2, col=colores)
# Se podría agregar una línea vertical para indicar las 24:00 horas:
abline(v = 2400, lty=3)

# c.
beaver2$factiv <- factor(beaver2$activ)
plot(temp ~ factiv, beaver2)

# d.
aov.castor <- aov(temp ~ factiv, beaver2)
summary(aov.castor)
# El resultado del análisis indica que la actividad efectivametne influye en
# la temperatura corporal del individuo. Esto es concordante con las gráficas 
# anteriores.
