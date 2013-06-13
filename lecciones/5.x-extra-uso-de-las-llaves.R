## Uso de las llaves: { y }
 
# Las llaves se utilizan cuando se necesita ejecutar un set de varios comandos
# para obtener una determinada respuesta. De este modo:
 
# objeto <- {
#   comando1
#   comando2
#   ...
#   salida
# }
 
# equivale a poner:
 
# comando1
# comando2
# ...
# objeto <- out

# Las llaves indican el principio y el fin de un "bloque" de comandos. R sola-
# mente ejecuta este bloque una vez que el usuario lo indica con la llave de
# cierre "}"

# Ejemplo: Una secuencia de comandos para crear y modificar una matriz:
# INICIO #
matriz <- matrix(0, 5, 4)
matriz[,1] <- 1:5
matriz[,2] <- 3
matriz[,3] <- matriz[,2] / matriz[,1]
matriz[,4] <- matriz[,3] ^ 2
colnames(matriz) <- c('x', 'cte', 'inv', 'inv.cuad')
salida1 <- matriz
# FIN #

# Esto equivale a:
# INICIO #
salida2 <- {
  matriz <- matrix(0, 5, 4)
  matriz[,1] <- 1:5
  matriz[,2] <- 3
  matriz[,3] <- matriz[,2] / matriz[,1]
  matriz[,4] <- matriz[,3] ^ 2
  colnames(matriz) <- c('x', 'cte', 'inv', 'inv.cuad')
  matriz
  # Cuando ponemos el nombre al final indicamos que es el objeto
  # al que vamos a asignar el nombre de salida2
  # Este criterio funciona igual cuando se crean funciones usando { }
}
# FIN #

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
 
identical(salida1, salida2) # TRUE

# Un ejemplo en el que la funcionalidad de las llaves es sumamente importante
# es cuando necesitamos ejecutar varias instrucciones dentro de un loop o
# condicional (ver más adelante) y sólo nos interesa el resultado final de todo
# el proceso, sin necesidad de ir guardando los pasos intermedios como objetos.
# Otro uso común es en combinación con la función 'with', la que veremos en el
# módulo de trabajo con datos.
