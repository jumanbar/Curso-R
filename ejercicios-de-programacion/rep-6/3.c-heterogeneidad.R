# Rep. VI - ej. 3.a

# Instrucciones:
# Completar el código (dentro de los límites indicados) para que la simulación
# del ómnibus urbano respete los límites físicos respecto a la cantidad de 
# pasajeros que puede contener el vehículo.

# Objetivos:
# Utilizar sentencias condicionales para que si:
# - pasajeros es un valor muy alto, cambiar su valor por el máximo posible
# - pasajeros es un valor muy bajo, cambiar su valor por el mínimo posible

paradas <- 50
maximo  <- 60
pasajeros <- rpois(1, 10)
registro  <- numeric(paradas)
registro[1] <- pasajeros
for (i in 2:paradas) {
  # Bajan:
  pasajeros <- pasajeros - rpois(1, 2)
  
  # Suben:
  pasajeros <- pasajeros + rpois(1, 3)

#================ Su código comienza aquí: ================#
  # Límites:


  
  
  
#================ Su código termina aquí ==================#
  registro[i] <- pasajeros # Actualiza registro
}
plot(registro, type = "o", pch = 19, xlab='Parada', 
     ylab='No. de pasajeros', ylim = c(0, max(registro)))
abline(h = c(0, maximo), lty = 3)

