# Instrucciones: generar un código que pueda calcular el valor de una serie 
# geométrica para valores arbitrarios de n y z.
# Objetos:
# n: número entero positivo; el número de términos de la serie.
# z: número real; el denominador de la fórmula de la serie S_n
# e: representa los exponentes de cada término de la serie. Nótese que la
# sumatoria empieza en i=0 y termina en el i=n.
# s: vector resultante de aplicar la fórmula del "término de la sumatoria" a los 
# números del 0 al n.
# out: resultado final de la sumatoria.

#===== Su código comienza aquí: =====#  

n <- 20

z <- 0.4

e <- seq(from=0,to=n,by=1)

s <- 1/(z**e)

out <-sum(s)

#====== Aquí finaliza su código =====#

# Código usado para resolver:

#out<-function(n,z){
#  valor.z <- function(z){
#    if(abs(z)<=1){
#      cat("z debe ser tal que |z|>1")
#    } else {cat("OK")}
#  }
#  e <- seq(from=0,to=n,by=1)
#  s <- 1/(z**e)  
#  print(sum(s))
#}

