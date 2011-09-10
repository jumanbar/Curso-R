## Uso de los corchetes o llaves: { y }
# objeto <- {
#   comando1
#   comando2
#   ...
#   out
# }
# equivale a poner:
# comando1
# comando2
# ...
# objeto <- out
 
## Ejemplo:
 
matriz <- matrix(0, 5, 4)
matriz[,1] <- 1:5
matriz[,2] <- 3
matriz[,3] <- matriz[,2] / matriz[,1]
matriz[,4] <- matriz[,3] ^ 2
colnames(matriz) <- c('x', 'cte', 'inv', 'inv.cuad')
salida1 <- matriz
 
salida2 <- {
	matriz <- matrix(0, 5, 4)
	matriz[,1] <- 1:5
	matriz[,2] <- 3
	matriz[,3] <- matriz[,2] / matriz[,1]
	matriz[,4] <- matriz[,3] ^ 2
	colnames(matriz) <- c('x', 'cte', 'inv', 'inv.cuad')
  matriz
  ## Cuando ponemos el nombre al final indicamos que es el objeto
  ## al que vamos a asignar el nombre de salida2
  ## Este critero funciona igual cuando se crean funciones usando { }
}
 
salida1
#      x cte  inv inv.cuad
# [1,] 1   3 3.00   9.0000
# [2,] 2   3 1.50   2.2500
# [3,] 3   3 1.00   1.0000
# [4,] 4   3 0.75   0.5625
# [5,] 5   3 0.60   0.3600
salida2
#      x cte  inv inv.cuad
# [1,] 1   3 3.00   9.0000
# [2,] 2   3 1.50   2.2500
# [3,] 3   3 1.00   1.0000
# [4,] 4   3 0.75   0.5625
# [5,] 5   3 0.60   0.3600
 
identical(salida1, salida2)
