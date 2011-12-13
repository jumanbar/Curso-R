## Parcial II, diciembre 2011

# Ejercicio 3
#
#  a)
#
  Plot(lynx)
  ## Sobra una mayúscula, seguramente es por el procesador de texto
#
#	- La funcion crece y decrece, alternandose picos y valles bien marcados. 
#
  ## 1x
#  b)
#
	mayores<-function(lynx){
	total=0
	c<-length(lynx)
	for (i in c){
  ## Debería decir 1:c
	if lynx[c]>4200
  ## 1. Debería ser i en lugar de c.
  ## 2. Debería tener paréntesis alrededor de la desigualdad.
		total=total+1}
    ## El uso de la indentación y las llaves es un poco confuso.
	resultado<-paste(“Hay”, total,”valores mayores a 4200”)
	print(resultado)
	}
  ## Está bien ir sumando 1 al total en cada iteración. De todas formas, hay un
  ## problema con esto, y es que estás contabilizando un valor ligeramente
  ## distinto al que se pide... (ver notas en las soluciones a los ejercicios).
#
  ## 0.4x
# c)
#	
	lynxlog<-log10(lynx)
	plot(lynxlog)
#
#	- La nueva curva tiene una amplitud menor y es mas plana, teniendo tambien menor 
#	diferencia entre los maximos y los minimos.
#
  ## 1x
# d)
	a<-mean(lynx)
	b<-mean(lynxlog)
	comparaciond<-a/b
	comparaciond
	529,6817
# 	La media de la serie lineal es casi 530 veces mayor que la media de la serie logaritmica.
  ## La comparación no es con b en sí (que por estar en escala logarítmica
  ## siempre va a ser mucho menor que la media lineal). La comparación es entre
  ## a y 10 ^ b
#
  ## 0.1x
# e)
	d<-median(lynx)
	e<-median(lynxlog)
	comparacione<-d/e
	comparacione
	267,0599
# 	La mediana de la serie lineal es casi 267 veces mayor que la mediana de la serie logaritmica.
  ## Aplica lo mismo que en el caso anterior
#
  ## 0.1x
# f)
	qqnorm(lynxlog)
#	
#	Si la distribucion fuera perfectamente normal, el comando qqnorm nos entregaria una recta a #	45°, en nuestro caso, como lo q nos entrega es bastante aprocimado/aproximado, podemos decir q la 
#	distribucion es casi normal.
#
  ## 1x
# g)
#	Para comparar en este caso ejecuto
	qqnorm(lynxlog); qqline(lynxlog)
#	De la observacion de lo q me entrega la ejecucion de dicho comando puedo inferir q la 
#	distribucion es normal en la mayor parte de la serie, alejandose un poco en los extremos de
#	la misma.  	
  ## Es preferible no usar el ';'
#
  ## 1x
#
#
# Ejercicio 4
#
# a)
#	Suponiendo q el estado 1 significa q el individuo esta activo, la actividad de este comienza a 
#	la hora 15:50.
  ## ¿Usó algún/os comando/s para encontrar este valor?
  ## 0.8x
#
# b)
#	Voy a crear una nueva matriz castor, q va a ser identica a beaver2, con el objetivo de 
#	modificar en ella la columna horas, sumandole 2400 a partir de las 0hs, con el objetivo de q #	cuando grafique los ptos del nuevo dia, me queden a continuacion de los del dia anterior. En
#	adelante, voy a realizar lo q pide el ejercicio dobre la matriz castor
	castor<-beaver2
	hora<-castor[,2]
	hora1<-hora[1:87]
	hora2<-hora[88:100]
	hora3<-hora2+2400
	horas<-c(hora1,hora3)
	castor[,2]<-horas
	castoresa<-castor[1:38,]
 	castoresb<-castor[39:100,]
  ## La letra pide que se pongan todos los puntos en una misma gráfica, en
  ## lugar de hacer gráficas separadas.
 	xa<-castoresa[,2]
 	ya<-castoresa[,3]
	plot(xa,ya, col="blue", main="Temperatura Corporal del Castor a lo largo del dia", xlab="Hora", ylab="Temperatura")
  ## En verdad no es necesario separar los vectores que se van a graficar en 
  ## nuevos objetos. Esto además es impráctico debido a la gran cantidad de
  ## objetos que empiezan a poblar el área de trabajo. Ver solución propuesta
  ## para alternativas.
	xb<-castoresb[,2]
	yb<-castoresb[,3]
	plot(xb,yb,freq="FALSE", add="TRUE", col="red")
  ## Argumento freq no existe para un plot
  ## 0.4
# c)
	actividad1<-castor[,4]
	actividad<-as.factor(actividad1)
#	 
	z<-castor[,4]
	y<-castor[,3]
	plot(z,y)
  ## Aternativa más sintética:
  ## plot(temp ~ actividad, castor)
  ## 1x
#
#
# d)
	 var(ya)
	[1] 0.0431357
 	var(yb)
	[1] 0.04676259
	 summary(ya)
   	Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  	36.58   36.97   37.10   37.10   37.17   37.64 
 	summary(yb)
   	Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  	37.41   37.76   37.92   37.90   38.06   38.35 
#
#	Del analisis de los datos anteriores, observo una variacion de alrededor 
#	de un grado entre la temp en reposo y en actividad.

  ## No podés concluir eso tan livianamente sólo mirando las varianzas.
  ## Para este ejercicio es necesario hacer un análisis de varianza con 'aov'
  ## (ver lección de estadística).
  ## 0x
