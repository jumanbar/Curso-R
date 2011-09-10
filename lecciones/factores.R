### factores
 
## Los objetos "factor" están pensados para trabajar dentro de fórmulas en R ("formula" es
## otra clase de objetos en R). Una forma de comprender el concepto de factor es pensando
## en su uso dentro del diseño experimental: un factor es una variable cuyo efecto se busca
## entender; en un experimento se crean distintos tratamientos, cada uno con un nivel determinado
## para dicho factor.

## Ejemplo: efecto del nitrógeno en el crecimiento de un cultivo. Un tratamiento puede ser
## sin N y otro con N. Entonces tenemos un factor ("N") con dos niveles (que pueden ser
## denominados 0 y 1, o de cualquier otra forma).
 
## Crear un factor con tres niveles, cinco casos de cada uno:
clasif <- rep(c('N1', 'N2', 'N3'), 5)
x <- factor(clasif)
 
# Alternativamente
?gl
x <- gl(3, 5, labels=c('N1', 'N2', 'N3'))
 
## Niveles (rótulos)
levels(x) # salida de clase "character"
# [1] "N1" "N2" "N3"

## Para obtener simplemente los rótulos de todas las observaciones, se
## puede cohercionar el factor en un "character":
as.character(x)
as.vector(x)
 
## ¿Cuántos niveles tiene el factor? fácil:
nlevels(x)
# [1] 3
 
## Para quitarle los rótulos:
y <- unclass(x)
## Ahora lo puedo transformar en numeric:
as.numeric(y)
## Nótese que los números de este nuevo vector no tienen por qué
## guardar relación alguna con los valores de los rótulos originales del
## factor.

## Si los nombres de los rótulos son números, entonces se puede
## convertir el factor en un numeric (con los valores de los rótulos),
## usando:
f <- gl(2, 3)
as.numeric(levels(f))[f]

## Nota final: no es nada raro confundir un objeto factor con uno
## character, sobre todo cuando uno está aprendiendo R (y en particular
## luego de importar matrices o data.frames). Por esto se recomienda
## estar atento a la salida que R imprime en la consola (si es un factor
## se imprimen los "Levels:..." al final. En el caso de importación de
## datos, la opción por defecto es que las columnas con texto se interpetan
## como factores. Esto se puede evitar usando "stringsAsFactor=FALSE"
