
paradas <- 25
pasajeros <- 0
registro <- numeric(paradas)
registro[1] <- pasajeros
for (i in 1:paradas) {
  pasajeros <- pasajeros + sample(0:6, 1)
  if (pasajeros >= 44) {
    pasajeros <- 44
    registro[i:paradas] <- 44
    cat('Bus lleno!\n')
    break
  }
  registro[i] <- pasajeros
  cat('Parada', i, 'hay', pasajeros, 'pasajeros\n')
}
plot(registro, xlab='Parada', ylab='No. de pasajeros', type='s')