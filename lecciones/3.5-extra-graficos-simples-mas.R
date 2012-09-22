
## EXTRA

# Algunos gráficos avanzados que también nos dan una idea general de como
# se relacionan nuestros datos los podemos realizar utilizando los paquetes
# 'MASS' y 'lattice'.

# Por ejemplo, utilizando el paquete 'lattice'. (recuerde para utilizar una
# función específica de un paquete, ud. deberá cargarlo previamente: 
# install.packages("lattice") por si no lo han instalado y library(lattice)
# para cargarlo posteriormente).

xyplot(Sepal.Length ~ Sepal.Width | Species, data=iris)

# Es un gráfico 'similar' al primero que vimos, sólo que más sofisticado en
# cuanto a los comandos que requiere y a la imagen que devuelve.  Además es
# específico para las dos variables que le especificamos y a su vez nos separa
# los gráficos según los grupos.

xyplot(Sepal.Length ~ Sepal.Width | Species, data=iris, panel=function (x,y){
  panel.xyplot(x, y, col=1, cex=1.2, pch=1) panel.lmline(x, y, col=3, lwd=3,
  lty=2) panel.loess(x,y, col=2, lwd=1.5) })

# Es igual sólo que agrega el modelo teórico en línea verde rayada y la
# curva suavizada en linea roja continua.
