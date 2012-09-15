# Instrucciones: siendo cal el vector con las calificaciones de todos los
# estudiantes, debe obtener los siguientes valores:
# p.apr*: porcentaje de estudiantes aprobados.
# Edite sólo la pate indicada más abajo, entremedio de las dos líneas horizontales (sin cambiar el texto
# de las propias líneas)s.
# Note además que en la evaluación automática cal y gen serán sustituidos por vectores creados
# aleatoriamente.
#===== Su código comienza aquí: =====#

apr   <- sum(cal >= 5)
p.apr <- 100 * apr / length(cal)

#====== Aquí finaliza su código =====#

