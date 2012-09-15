# Instrucciones: el valor n tiene asignado un valor de 3 para empezar, pero 
# usted lo deberá cambiar para lograr el objetivo del problema (usando siempre
# valores enteros y positivos).
# Otros objetos:
# e: representa los exponentes de cada término en la fórmula en de la letra (es
# decir, 1, 2, 3, etc.. hasta n).
# s: vector final que se va a usar para la sumatoria
# out: resultado final de la sumatoria.

#===== Su código comienza aquí: =====# 

n <- 20 # El valor correcto es 20
e <- 1:n
s <- 1 / (2 ^ e)
out <- sum(s)

#====== Aquí finaliza su código =====#
