# Rep. VI - ej. 3.b

# Instrucciones:
# Completar el código (dentro de los límites indicados) para que la simulación
# del ómnibus urbano registre correctamente la cantidad de pasajeros que no
# pudieron subir en cada parada, utilizando el vector numérico nosuben.

# Objetivos:
# Utilizar sentencias condicionales para que si pasajeros es un valor muy alto, 
# cambiar su valor por el máximo posible, y además se registre en el vector 
# nosuben la cantidad de personas que 'sobraron'.
# nosuben*: este objeto será evaluado antes y después de correr su código,
#           para determinar es capaz de hacer las acciones que se piden.

paradas <- 50
maximo  <- 60
pasajeros <- rpois(1, 10)
registro  <- numeric(paradas)
nosuben   <- numeric(paradas)
# Se da por descontado que no queda nadie afuera en la primer
# parada del recorrido, por eso nosuben[1] == 0
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
points(nosuben, type = "o", pch = 19, col = 3)
abline(h = c(0, maximo), lty = 3)

