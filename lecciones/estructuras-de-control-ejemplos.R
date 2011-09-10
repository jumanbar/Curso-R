## Ejemplo: usar if + break para detener un loop
## Primero necesito la función para evaluar la serie de Leibniz
leib <- function(n) {
  x <- 0:n
  imp <- 2 * x + 1
  inv <- 1 / imp
  elementos <- inv * (- 1) ^ x
  sum(elementos)
}
 
### Para alcanzar una presición predeterminada
n <- 5          # el n inicial es 5
error <- 0.001  # esta es la presición que queremos
out   <- NULL   # en out vamos a ir pegando lo generado **
for(i in 1:100) {
  x   <- leib(n) * 4  # x es el valor de pi estimado
  dif <- abs(x - pi)  # dif es |x - pi|
  out <- c(out, dif)  # le agrego la diferencia a out
  if(dif < error) {   # Si cumple la condición que interesa...
    break             # ... lo interrumpimos con un break
  }
  n <- n + 1
}
plot(out)
 
## ** Usar NULL es una forma de generar un objeto vacío, al cual luego
## se le van a concatenar elementos. En este caso, en cada iteración se
## le concatena un valor nuevo (dif).
 
## Ejemplo: usar un while para lograr lo mismo, pero sin molestarnos
## en poner un número de iteraciones.
#### Para este caso el while es una opción más conveniente
#### ya que a diferencia del for no tiene un límite de iteraciones
#### predeterminada.
#### Para ejecutar lo mismo haciendo un while:
n <- 5
error <- 0.001
dif <- Inf  # dif tiene que estar definido antes de empezar el while
            # porque es necesario para evaluar la condición entre paréntesis
out <- NULL 
while(dif > error) {  # Cáda vez que empieza el loop, se evalúa 
  x <- leib(n) * 4    # la condición entre paréntesis.
  dif <- abs(x - pi)  # Si no es verdadera, se corta el loop.
  out <- c(out, dif)
  n <- n + 1          # si no pongo esto hace un loop infinito!
}
plot(out)
 
#### Este proceso se puede implementar en una función.
#### Para esto necesitamos algunos argumentos (n, error y show), aunque
#### show lo ponemos simplemente para que haga opcionalmente un gráfico...
estimaPi <- function(n=5, error=0.01, show=TRUE) {
  dif <- Inf
  while(dif > error) {
    x <- leib(n) * 4
    dif <- abs(x - pi)
    out <- c(out, dif)
    n <- n + 1  # si no pongo esto hace un loop infinito!
  }
  if(show) plot(out) ## 
  list(estimacion=x, nfinal=n - 1, error=error, dif=out)
}
## Acá me definió la función, aún no la corrí, para eso:
pi1 <- estimaPi()
str(pi1) # pi1 es una lista
pi1$     # usando la tecla "tab" se pueden ver los objetos contenidos en pi1
abs(pi1$estimacion - pi) ## ¿Qué tan distinto es?
