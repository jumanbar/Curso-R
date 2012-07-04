
paradas <- 25
pasajeros <- 0
##*
registro[1] <- pasajeros
for (i in 1:paradas) {
##*
  if (pasajeros >= 44) {
##*
    registro[i:paradas] <- 44
    cat('Bus lleno!\n')
    break
##*
  registro[i] <- pasajeros
  cat('Parada', i, 'hay', pasajeros, 'pasajeros\n')

}
plot(registro, xlab='Parada', ylab='No. de pasajeros')


pasajeros <- 44
}
registro <- numeric(paradas)
pasajeros <- pasajeros + sample(6, 1)