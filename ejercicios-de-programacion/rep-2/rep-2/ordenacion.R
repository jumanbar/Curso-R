# Instrucciones: los objetos cal, gen y ctg ya deben encontrarse en el área de trabajo para correr este 
# script. En caso contrario, corra "load('ej2.rda')" para cargar estos objetos ya preparados.
# Objetivos:
# datosCalif (ordenada)*: data.frame con las filas ordenadas en función del crecimient de nota.
# Edite sólo la parte indicada más abajo, entremedio de las dos líneas horizontales (sin cambiar el texto
# de las propias líneas).
# Recuerde que en la corrección los objetos cal y gen son creados nuevamente con generadores de números
# aleatorios.
#===== Su código comienza aquí: =====#
i <- order(datosCalif$nota)
datosCalif <- datosCalif[i,]
#====== Aquí finaliza su código =====#

