# Rep. IV - ej. 1.d

# Instrucciones: 
# Hacer dos regresiones lineales con la función lm y la data.frame magic. Luego
# con el segundo modelo debe 1. predecir valores de altura, dados valores de peso
# y 2. obtener el coeficiente de determinación (R^2).

# Objetivos:

# reg.a*: salida de la función lm; una regresión lineal con peso como variable
#         explicativa y el cuadrado de la altura como variable de respuesta, sin
#         intercepto.
# reg.b*: salida de la función lm; una regresión lineal con peso como variable
#         explicativa y el cuadrado de la altura como variable de respuesta, sin
#         intercepto. Se deben eliminar las observaciones tal que peso >= 95 Kg.
# ae*: vector con los valores esperados de altura correspondientes a los valores
#      de peso (en Kg) contenidos en el vector p.
# s: objeto sugerido, la salida de summary aplicado a la reg.b
# r2*: valor del coeficiente de determinación (R^2) para reg.b

# Nota: una nueva data.frame magic es creada internamente en cada corrección.

#===== Su código comienza aquí: =====#

reg.a <- 0

reg.b <- 0

p <- runif(40, 55, 100) # Genera un p aleatorio; no modifique esta línea

ae <- 0

s <- 0

r2 <- 0

#====== Aquí finaliza su código =====#

