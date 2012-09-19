hipot <- function(cat.ad , cat.op) {
# Calcula la hipotenusa de un triángulo rectángulo a partir de los valores de
# los catetos, cat.ad y cat.op.
  out <- sqrt(cat.ad ** 2 + cat.op ** 2)
  out
}

#===== Su código comienza aquí: =====#

area <- function(ca=0, co=0) {
# Acepta como argumentos los valores de los dos catetos.
area.valor<-(ca*co)/2
# cat(): concatenar objetos (para agregar texto, etc.)
#cat("El area del triangulo es:", area.valor, "u.m.","^2", "\n")
print(area.valor)
}

co <- function(ca=1,hip=1) {
# Acepta como argumentos el valor del cateto adyacente y de la hipotenusa (¡en ese orden!)
valor.co<-sqrt((hip**2)-(ca**2))
#cat("El cateto opuesto vale:", valor.co, "u.m.", "\n")
print(valor.co)
}

#===== Su código termina aquí =======#

# Comentario: intenté con el comando cat para generar una salida más amigable
# pero evidentemente no estaba incluido esto en el archivo evaluar.r;
# por eso figura comentario en ambos casos
