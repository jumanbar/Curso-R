# El vector de muestra "coleccion" 
coleccion <- c(9, 6, 3, 3, 6, 1, 5, 5, 5, 3, 2, 7, 2, 1)

# Instrucciones: siguiendo la ecuación 1 de la letra del repartido, los 
# siguientes objetos son:
# n: vector con todos los n_i (="n subíndice i")
# N: cantidad total de objetos en la colección
# p: vector con todos los p_i
# H: índice de Shannon
# Usted deberá calcular el valor de H pero evitando usar la función "sum" y en
# cambio utilizando el producto interno o escalar, denotado por el operador %*%.
# Reuerde que las funciones "table" y "length" le pueden ser de mucha ayuda.
#===== Su código comienza aquí: =====#

n <- table(coleccion)
N <- length(coleccion)
p <- n / N
H <- - (p %*% log2(p))

#===== Aquí finaliza su código =====#
