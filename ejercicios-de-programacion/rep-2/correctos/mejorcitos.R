# Instrucciones: siendo cal el vector con las calificaciones de todos los
# estudiantes, y gen el vector con el género de dichos estudiantes ("V" = varón y "M" = mujer), debe 
# obtener los siguientes valores:
# i*: posición a partir de la cual tomar los valores de ord
# mejores*: vector con las notas del 25% mejor calificado del grupo de
# estudiantes.
# Se sugiere crear el siguente objeto intermedio:
# ord: vector con los valores ordenados de menor a mayor de cal
# Edite sólo la parte indicada más abajo, entremedio de las dos líneas horizontales (sin cambiar el texto
# de las propias líneas).
# Note además que en la evaluación automática cal será un vector creado aleatoriamente.
#===== Su código comienza aquí: =====#

n <- length(cal)
ord <- sort(cal)
i <- ceiling(n * 0.75)
mejores <- ord[i:n]

#====== Aquí finaliza su código =====#

