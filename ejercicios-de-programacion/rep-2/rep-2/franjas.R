# Instrucciones: siendo cal el vector con las calificaciones de todos los estudiantes, y gen el vector 
# con el género de dichos estudiantes ("V" = varón y "M" = mujer), debe obtener los siguientes valores:
# ctg*: vector con el código en letras (A, B, C y D) creado según la letra del repartido.
# conteo*: vector numérico con el conteo de la cantidad de valores dentro de las 4 franjas A, B, C y D
#          (ver letra del repartido).
# Edite sólo la parte indicada más abajo, entremedio de las dos líneas horizontales (sin cambiar el texto
# de las propias líneas).
# Note además que en la evaluación automática cal y gen serán vectores creados aleatoriamente.
#===== Su código comienza aquí: =====#
n <- length(cal)
ctg <- character(n)
ctg[cal <= 3] <- 'A'
ctg[3 < cal & cal <= 6] <- 'B'
ctg[6 < cal & cal <= 9] <- 'C'
ctg[9 < cal] <- 'D'
conteo <- as.numeric(table(ctg))
# Alternativamente:
#  conteo <- tabulate(as.factor(ctg))
names(conteo) <- c("A", "B", "C", "D")
# Alternativamente:
#  names(conteo) <- LETTERS[1:4]
#====== Aquí finaliza su código =====#
