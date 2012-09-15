# Instrucciones: siguiendo la ecuación 1 de la letra del repartido, los 
# objetos definidos entre las llaves de la función Shannon son:
# n: vector con todos los n_i (="n subíndice i")
# N: cantidad total de objetos en la colección
# p: vector con todos los p_i
# H: índice de Shannon (salida de la función)
# La función debe ser capaz de calcular el índice de Shannon-Wiener de cualquier
# vector que sea utilizado como entrada/input. Esta entrada es el argumento

#===== Su código comienza aquí: =====#
shannon <- function(vect) {
  n <- table(as.factor(vect))
  N <- length(vect)
  p <- n/N
  H <- -p%*%log2(p)
  #==== Aquí finaliza su código =====#
  print(H)
}
