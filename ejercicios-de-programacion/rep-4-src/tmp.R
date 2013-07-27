# Rep. IV - ej. 1.b

# Instrucciones: 
# El objetivo es lograr un gráfico similar al de la figura 4. El código está
# hecho, sólo falta ajustar los parámetros gráficos para que quede bien

# Objetivos:

# hist.m*: salida de la función hist aplicada a las alturas de las
#          mujeres.
# hist.h*: salida de la función hist aplicada a las alturas de los
#          hombres.

# Nota: una nueva data.frame magic es creada internamente en cada corrección.

#===== Su código comienza aquí: =====#

# src("hacemagia.R")

cols <- c("seagreen", colors()[330], "orangered")
pchs <- c(16, 19, 17)
xlim <- range(magic$peso)
ylim <- range(magic$altura ^ 2)
ltys <- c(2, 1)
sbs.muj  <- magic$genero == "mujer"
sbs.peso <- magic$peso >= 95
sbs.hom  <- magic$genero == "hombre"

plot(altura ^ 2 ~ peso, magic, subset = sbs.muj, pch = pchs[1], xlim = xlim, 
     ylim = ylim, col = cols[1], cex  = 1.5)
points(altura ^ 2 ~ peso, magic, subset = sbs.peso, pch = pchs[2], 
       col = cols[2], cex = 3)
points(altura ^ 2 ~ peso, magic, subset = sbs.hom, pch = pchs[3], 
       col = cols[3], cex  = 1.5)
abline(v = 95, lty = ltys[1], lwd = 1.5)
abline(reg.b,  lty = ltys[2], lwd = 1.5, col = "grey")

#====== Aquí finaliza su código =====#

