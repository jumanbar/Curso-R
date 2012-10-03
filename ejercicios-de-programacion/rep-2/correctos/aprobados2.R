# Instrucciones: siendo cal el vector con las calificaciones de todos los
# estudiantes, y gen el vector con el género de dichos estudiantes ("V" = varón y "M" = mujer), debe 
# obtener los siguientes valores:
# p.apr.v*: porcentaje de estudiantes varones aprobados (en relación al total 
#   de varones).
# p.apr.m*: porcentaje de estudiantes mujeres aprobadas (en relación al total 
#   de mujeres).
# Se sugiere crear y usar los siguientes objetos:
# v: calificacinones de los estudiantes varones
# m: calificaciones de las estudiantes mujeres
# apr.v: cantidad total de aprovados varones (notas mayores o iguales a 5)
# apr.m: cantidad total de aprovadas mujeres (notas mayores o iguales a 5)
# Edite sólo la pate indicada más abajo, entremedio de las dos líneas horizontales (sin cambiar el texto
# de las propias líneas).
# Note además que en la evaluación automática cal y gen serán sustituidos por vectores creados
# aleatoriamente.
#===== Su código comienza aquí: =====#
v <- cal[gen == 'V']
m <- cal[gen == 'M']
apr.v <- sum(v >= 5)
apr.m <- sum(m >= 5)
p.apr.v <- 100 * apr.v / length(v)
p.apr.m <- 100 * apr.m / length(m)
#====== Aquí finaliza su código =====#

