# El siguiente código genera de forma aleatoria las coordenadas de los
# arbustos:
arb.x <- runif(20)
arb.y <- runif(20)

# Puede visualizar el mapa, junto con el panal de coordenadas (0.431, 0.587), 
# con los comandos:
plot(arb.x, arb.y, xlim = 0:1, ylim = 0:1)
points(0.431, 0.587, pch=19)

# Nota: si prefiere "apagar" estas líneas de código, agregue un # al inicio 
#       de las mismas.

# Instrucciones:
# Para lograr el objetivo, debe seguir los siguentes pasos:
# 1. Determinar los catetos de los triángulos rectángulos imaginarios (cat.ad 
#    y cat.op).
# 2. Con la fórmula de la hipotenusa hallar las distancias del panal a los 
#    arbustos (dst).
# 3. Con la función which.xxx encontrar las posiciones del mínimo (i) y el 
#    máximo (j) dentro del vector dst.
# 4. Utilizar estas posiciones para extraer las coordenadas correspondientes a 
#    los arbustos más cercano (arb.cerca) y lejano (arb.lejos) del panal.

# Objetivos:
# cat.ad y cat.op: los "catetos" de todos los triángulos rectángulos formados con 
#                  el central y los demás puntos.
# dst*: un vector con distancias entre el panal (0.431, 0.587) y todos los arbustos.
# i*: posición de dst en el que se encuentra el mínimo de distancia
# j*: posición de dst en el que se encuentra el máximo de distancia
# arb.cerca*: coordenadas del punto más cercano (vector de dos valores)
# arb.lejos*: coordenadas del punto más lejano  (vector de dos valores)

#===== Su código comienza aquí: =====#

cat.ad <- 0

cat.op <- 0

dst <- 0

i <- 0

j <- 0

arb.cerca <- c(0, 0)

arb.lejos <- c(0, 0)

#====== Aquí finaliza su código =====#

