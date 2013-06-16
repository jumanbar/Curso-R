# Rep. IV - ej. 1.e

# Instrucciones: 
# El objetivo es lograr un gráfico similar al de la figura 4. El código está
# hecho, sólo falta ajustar los parámetros gráficos para que quede bien.

# La mayoría de los parámetros se pueden consultar con ?par, mientras que
# ?subset sirve para los últimos tres vectores.

# Las líneas posteriores a la marca ##! no están en el orden correcto, usted
# debe ordenarlas para producir correctamente la figura.

# Objetivos:

# cols*: vector integer o character con tres valores diferentes.
# pchs*: vector integer o character con tres valores diferentes.
# xlim*: vector numérico de dos elementos con el rango de valores correcto 
#        para que en el gráfico final no queden afuera observaciones.
# ylim*: vector numérico de dos elementos con el rango de valores correcto 
#        para que en el gráfico final no queden afuera observaciones.
# ltys*: tipos de líneas para las dos rectas que van en la figura. La vertical
#        no debe ser continua, pero la inclinada sí.
# sbs.xxx*: vectores lógicos con las condiciones adecuadas para que en cada
#           uso se grafiquen diferentes subconjuntos de las observaciones, 
#           diferenciando hombres, mujeres y outliers (peso >= 95).

# Notas: 

# 1. una nueva data.frame magic es creada internamente en cada corrección.
# 2. los objetos cols, pchs y ltys pueden usar valores ingresados directamente
#    por el usuario, mientras que los demás deben ser deducidos de las premisas
#    y presentar soluciones genéricas.

# Si no hizo el ejercicio 1.d-regresion.R:

if (!exists("reg.b"))
  load("auxiliar.RData")

#===== Su código comienza aquí: =====#

# cols <- c(1, 1, 1)
# pchs <- c(1, 1, 1)
# ltys <- c(NA, NA)
# xlim <- c(0, 0)
# ylim <- c(0, 0)
# sbs.muj  <- !logical(nrow(magic))
# sbs.peso <- !logical(nrow(magic))
# sbs.hom  <- !logical(nrow(magic))
cols <- c('green',"grey","red")
pchs <- c(20, 19,17)
ltys <- c(2, 1)
xlim <- c(min(magic$peso),max(magic$peso))
ylim <- c(min(magic$altura)^2, max(magic$altura)^2)

sbm<-magic$genero=="mujer"
sbp<-(magic$peso>=95)
sbh<-magic$genero=="hombre"
sbs.muj  <-as.logical(sbm)
sbs.peso <- as.logical(sbp)
sbs.hom  <- as.logical(sbh)



##!

points(altura ^ 2 ~ peso, magic, subset = sbs.peso, pch = pchs[2], 
       col = cols[2], cex = 3)

abline(v = 95, lty = ltys[1], lwd = 1.5)

plot(altura ^ 2 ~ peso, magic, subset = sbs.muj, pch = pchs[1], xlim = xlim, 
     ylim = ylim, col = cols[1], cex = 2)

points(altura ^ 2 ~ peso, magic, subset = sbs.hom, pch = pchs[3], 
       col = cols[3], cex  = 2) 

abline(reg.b,  lty = ltys[2], lwd = 1.5, col = "grey")

#====== Aquí finaliza su código =====#

