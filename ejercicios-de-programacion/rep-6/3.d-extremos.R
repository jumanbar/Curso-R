# Rep. VI - ej. 3.d

# Instrucciones:
# Completar el código (dentro de los límites indicados) para que la simulación
# del ómnibus urbano incorpore las nuevas reglas descriptas en la letra.

# Objetivos:
# Utilizar sentencias condicionales de forma que se cumplan:
# - Bajadas: sólo pueden haber bajadas si el bus se encuentra de la quinta
#            en adelante.
# - Subidas: no pueden haber subidas luego de pasar la parada 45.

paradas <- 50
maximo  <- 60
pasajeros <- rpois(1, 10)
registro  <- numeric(paradas)
nosuben   <- numeric(paradas)
# Se da por descontado que no queda nadie afuera en la primer
# parada del recorrido, por eso nosuben[1] == 0
registro[1] <- pasajeros
for (i in 2:paradas) {
#================ Su código comienza aquí: ================#
  # Bajan:



  # Suben:
  


  # Límites: (no es importante esta parte en este ejercicio)



#================ Su código termina aquí ==================#
  registro[i] <- pasajeros # Actualiza registro
}
plot(registro, type = "o", pch = 19, xlab='Parada', 
     ylab='No. de pasajeros', ylim = c(0, max(registro)))
points(nosuben, type = "o", pch = 19, col = 3)
abline(h = c(0, maximo), lty = 3)
abline(v = c(14.5, 35.5, 32.5), lty = 3, col = c(2, 2, 4))

