# Rep. II - ej. 2.c

# Instrucciones:
# Los objetos cal, gen, ctg, p.apr, p.apr.v, p.apr.m y datos.calif ya deben encontrarse en el 
# área de trabajo para correr este script. En caso contrario, corra "load('ej2.RData')" 
# para cargar estos objetos ya preparados.

# Recuerde que la data.frame debe estar ordenada 
# por la variable nota (ej. 2.b).

# Objetivos:
# analisis.calif*: lista con la estructura específicada en el repartido.

# Recuerde además que en la corrección los objetos cal y gen son creados nuevamente 
# con generadores de números aleatorios.
#===== Su código comienza aquí: =====#

# datos.calif <- data.frame (cal, gen, ctg)
# names(datos.calif) <- c("nota","genero","franja")


analisis.calif$tabla <- datos.calif

analisis.calif$conteo <- table (ctg)

atot <- (p.apr)
avar <- (p.apr.v)
amuj <- (p.apr.m)
aprob <- list (atot=p.apr, avar=p.apr.v, amuj=p.apr.m)

analisis.calif$aprob <- list (atot, avar, amuj)


analisis.calif <- list(tabla ,conteo, aprob)

#====== Aquí finaliza su código =====#

