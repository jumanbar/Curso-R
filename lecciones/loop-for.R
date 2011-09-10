# Loops (for & while):
# Sirven para ejecutar una tarea n veces. Para repetir una rutina, logrando
# en segundos lo que manualmente llevaría horas o días (o sería simplemente
# demasiado).
# Para ver la ayuda de R al respecto se pueden usar los comandos:
?Control
?"for" ## En este caso hay que poner comillas, ya que es un comando especial

## Estructura básica:
## Si nos interesa hacer 1 sólo comando:
for(variable in secuencia) comando
## Con este código, R ejecuta este comando n veces (n = length(secuencia)),
## y en cada iteración el valor de "variable" va cambiando, recorriendo los
## valores de "secuencia"
 
## Ejemplo: la secuencia va a ser 1:10
for(variable in 1:10) print(variable)
## variable va tomando los valores 1, 2, 3 etc... en orden
variable ## es 10
 
## Ejemplo: Quiero hacer una secuencia de 100 números que vayan aumentando de a
## 3, empezando por el 0
## La variable será "i"
## La secuencia será 1:99
## Nótese que termina en el 99, debido a la forma en que voy a escribir el comando (abajo)
## Para guardar los números creados, antes de ejecutar el loop debo crear un
## vector en donde voy a poner estos valores.
out <- numeric(100) ## Crea un vector con 100 ceros, luego los voy a ir
                    ## sustituyendo (excepto al primero).
for(i in 1:99) out[i + 1] <- out[i] + 3
## Sustituye, en cada iteración, (i + 1)ésimo valor de out (que es un cero
## inicialmente) por la suma del iésimo valor de out + 3
out
plot(out)
i ## es 99
 
## Ejemplo: interés en el banco.
## Si la tasa de interés es "t":
## f(n + 1) = f( n ) * t
plata.inicial <- 500    ## ¿cuánto hay?
tasa.interes  <- 0.05   ## 5%
out <- numeric(10)      ## 10 años de interés
out[1] <- plata.inicial ## Hay que ingresar "manualmente" el valor inicial
                        ## *antes* del loop
for(i in 1:9) out[i + 1] <- out[i] + out[i] * tasa.interes
 
### Hasta ahora hicimos for con un sólo comando, vamos a ver cómo
### hacer cosas un poco más elaboradas.
 
## Si queremos hacer varios comandos en cada iteración usamos { }. Esto es
## lo que se conoce como bloque de código: tódo lo que está entre { y } se
## ejecuta como si fuera una misma línea de comando. Esto implica que hasta
## que no se pone el último } en la consola de R no se ejecuta ninguno de
## los comandos internos.
## Estructura:
for(variable in secuencia) {
   comando1
   comando2
   ...etc
}
 
## Ejemplo:
for(i in 1:10) { ## Es buena práctica poner el { inicial aquí
   print('Extremos:')         ## Es deseable, por un tema de facilidad de
                              ## lectura, que los comandos interiores a los
                              ## {} estén adelantados una distancia fija,
   print(paste(0 - i, 0 + i)) ## por ejemplo un "tab" (a esto se le llama
                              ## "indentación").
} ## Es buena práctica poner el } final aquí
 
## Ejemplo: serie de Fibonacci, la cual es así
## 1 1 2 3 5 8 13 21 34 55 89 ...
## Es decir:
## f(n + 2) = f(n + 1) + f( n )
out <- numeric(20)
out[1:2] <- 1 ## Los dos primeros valores debemos agregarlos nosotros (nótese
head(out)     ## que haciendo: "out <- numeric(20) + 1" evitamos este paso...
for(i in 1:18) { ## En vez de "1:18" ¿podría usar "1 : (length(out) - 2)"?¿y "1:length(out) - 2"?
   n1 <- out[i]
   n2 <- out[i + 1]
   out[i + 2] <- n1 + n2
}
out
plot(out)
plot(out, log='y')
 
### loops anidados
## Aunque suene horrible, no es otra cosa que más de lo mismo:
mat <- matrix(1:20, 4, 5)
for(i in 1:4) {        # i será el índice de las filas de mat
   for(j in 1:5) {     # j será el índice de las columnas de mat
      print(mat[i, j]) # Nótese que se usan letras distintas, para evitar
   }                   # confusiones. También se ajusta la indentación
}                      # respetando los blóques de código.
 
## Ejemplo: supongamos que x e y son longitud y latutid de sitios:
x <- rnorm(5)
y <- rnorm(5)
coords <- cbind(x, y) ## Lista de coordenadas
## Quiero calcular las distancias euclidianas entre todos los pares de
## puntos y guardarlos en una matriz M (5x5), en donde M[i,j] = dist.
## entre los puntos i y j...
M <- matrix(0, 5, 5)  ## Una matriz en donde guardar los valores
for(i in 1:5) {
   for(j in 1:5) {
      x0 <- coords[i, 1]
      x1 <- coords[j, 1]
      y0 <- coords[i, 2]
      y1 <- coords[j, 2]
      M[i, j] <- sqrt((x1 - x0) ^ 2 + (y1 - y0) ^ 2)
   }
} ## (hay formas más "elegantes" y eficientes de hacerlo)
M ## La diagonal de M son ceros
diag(M)
