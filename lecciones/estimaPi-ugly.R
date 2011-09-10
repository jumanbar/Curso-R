le<-function(x){ a<-0:x
b<-(1/(2*a+1))*(-1)^a
sum(b)}

## Los nombres no son informativos, primer comando en la primer línea, no
## hay comentarios para ayudar al lector, no se describe el objetivo de la
## función, no tiene indentación, no usa espacios/líneas en blanco para
## facilitar la lectura

epi<-function(x,e,s=T){
d<-Inf;o<-NULL
while(d>e)
{
a<-le(x)*4;d<-abs(a-pi)
o<-c(o,d);x<-x+1
}
if(s==T)plot(o)}

## Los nombres no son informativos, primer comando en la primer línea, no
## hay comentarios para ayudar al lector, no se describe el objetivo de la
## función, no tiene indentación, no usa espacios/líneas en blanco para
## facilitar la lectura, muchos comandos en una sóla línea, uso de s==T
## cuando es redundante, no deja espacio luego del paréntesis del if...

## Ambas funciones trabajan correctamente, sin embargo se hace mucho más
## trabajoso entender qué hacen debido al pobre uso de las reglas de
## estilo.
