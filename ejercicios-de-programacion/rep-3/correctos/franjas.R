# Instrucciones: siendo cal el vector con las calificaciones de todos los
# estudiantes, y gen el vector con el género de dichos estudiantes ("V" = varón y "M" = mujer), debe 
# obtener los siguientes valores:
# ctg*: vector con el código en letras (A, B, C y D) creado según la letra del repartido.
# conteo*: vector numérico con el conteo de la cantidad de valores dentro de las 4 franjas A, B, C y D
#          (ver letra del repartido).
# Se sugieren los siguientes pasos intermedios:

# m: calificaciones de las estudiantes mujeres
# apr.v: cantidad total de aprovados varones (notas mayores o iguales a 5)
# apr.m: cantidad total de aprovadas mujeres (notas mayores o iguales a 5)
# p.apr.v: porcentaje de estudiantes varones aprobados.
# p.apr.m: porcentaje de estudiantes mujeres aprobadas.
# Edite sólo la parte indicada más abajo, entremedio de las dos líneas horizontales (sin cambiar el texto
# de las propias líneas).
# Note además que en la evaluación automática cal y gen serán vectores creados aleatoriamente.
#===== Su código comienza aquí: =====#

n <- length(cal)
out <- character(n)
out[cal <= 3] <- 'A'
out[3 < cal & cal <= 6] <- 'B'
out[6 < cal & cal <= 9] <- 'C'
out[9 < cal] <- 'D'
ctg <- out
conteo <- as.numeric(table(ctg))
names(conteo) <- LETTERS[1:4]

#====== Aquí finaliza su código =====#

