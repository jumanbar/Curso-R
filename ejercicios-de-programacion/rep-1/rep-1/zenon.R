# Instrucciones: el valor n tiene asignado un valor de 3 para empezar, pero 
# usted lo deberá cambiar para lograr el objetivo del problema (usando siempre
# valores enteros y positivos).
# Otros objetos:
# e: representa los exponentes de cada término en la fórmula en de la letra (es
# decir, 1, 2, 3, etc.. hasta n).
# s: vector final que se va a usar para la sumatoria
# out: resultado final de la sumatoria.

#===== Su código comienza aquí: =====# 

n <- 20

e <- 1:n

s <- 1/(2**e)

out <- sum(s)

#plot(cumsum(s), type = "o", main="Verificacion: paradoja de Zenon", xlab = "n", ylab = expression(Z[n]))

#====== Aquí finaliza su código =====#

# Código que adjunto y que evaluar() lo pone como incorrecto:
# (nos ayudó a hallar el valor de n correcto, n=20)
#out <- function(n=2,s){
#  e <- (1:n) #seq(from=1,to=n,by=1)
#  s <- 1/(2**e)
#  dif<-(1-sum(s))
#  if(dif>(1e-06)) {
#    cat("    Suma", "Epsilon", "\n")
#    print(c(sum(s), dif))
#    cat("Seguir probando con un n mayor")
#  } else {
#    cat("    Suma", "Epsilon", "\n")
#    print(c(sum(s), dif))
#    cat("El n que alcanza la cota es: ", n)
#  }
#}
