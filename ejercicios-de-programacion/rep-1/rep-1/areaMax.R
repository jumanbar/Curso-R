# Iniciación: es recomendable que usted comprenda las siguientes operaciones y
# las estructuras de los vectores cat.ad, cat.op y a, resultantes de ejecutar
# las siguientes líneas:
hip <- 10 # Hipotenusa
cat.ad <- seq(0.001, hip - 0.001, by = 0.1)  # Valores del cateto adyacente
cat.op <- co(cat.ad, hip)                    # Cálculo de los catetos opuestos
a <- area(cat.ad, cat.op)                    # Cálculo de las áreas

# Instrucciones: deberá usar which o which.max para encontrar la posición dentro
# del vector a en el que se encuentra el valor máximo de area.
# i: posición en la que se encuentra el máximo de a 
# sol: valor de cateto adyacente para el que ocurre este máximo
# amax: valor máximo de área calculado ("i-ésimo valor de a ...")

#===== Su código comienza aquí: =====#

i    <-

sol  <-

amax <-

#====== Aquí finaliza su código =====#

# Código opcional, para confirmar su solución:
# (Nótese que este código da error si usted no ha definido aún el objeto i)
plot(cat.ad, a, type='l', ylab="Área", main="Área máxima: línea roja")
abline(v=cat.ad[i], col='red', lwd=2)
