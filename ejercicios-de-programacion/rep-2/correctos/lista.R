# Instrucciones: los objetos cal, gen y ctg ya deben encontrarse en el área de
# trabajo para completar este script. En caso contrario, corra "load('ej2.rda')" 
# para cargar estos objetos ya preparados.
# Objetivos:
# datosCalif: data.frame con las columnas "nota", "genero" y "franja", 
# correspondientes a los vectores "cal", "gen" y "ctg" respectivamente.
# Recuerde que en la corrección los objetos cal y gen son generados nuevamente
# con generadores de números aleatorios.
#===== Su código comienza aquí: =====#

analisisCalif <- list(tabla = datosCalif, conteo = conteo,
                      aprob = list(atot = p.apr, avar = p.apr.v,
                                   amuj = p.apr.m))

#====== Aquí finaliza su código =====#

