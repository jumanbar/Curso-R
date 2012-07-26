
## LOOPS OBLIGADOS (O NO)
# En el caso anterior, no era necesario utilizar un loop, ya que el comando
# "seq" puede realizar la misma tarea e incluso con mayor eficiencia. No es
# raro que se utilicen loops existiendo otros comandos que hacen lo mismo,
# debido a la cantidad de funciones que existen en R.

# Sin embargo hay ocasiones en que es realmente necesario utilizar un loop. Un
# caso paradigmático es cuando "el valor siguiente depende del anterior". Por
# ejemplo, si consideramos el aumento de un depósito bancaro bajo una tasa de
# interés determinada.

# Si la tasa de interés es "t" y la cantidad depositada es "d":
# d( n + 1 ) = d( n ) + d( n ) * t

# (Se indica entre paréntesis el año).
# En este caso, para calcular d( n + 1 ) necesito saber cuanto es d( n ), para
# lo cual debo conocer d( n - 1 ), etc... Por lo tanto, lo que necesito es
# saber el valor inicial d( 0 ).

# Entonces, para calcular d( n ) a partir de un depósito inicial podemos usar
# el siguiente código:
plata.inicial <- 500         # depósito inicial
tasa.interes  <- 0.05        # tasa de interés, 5%
deposito <- numeric(10)      # 10 años/iteraciones
deposito[1] <- plata.inicial # Hay que ingresar "manualmente" el valor inicial
                             # *antes* del loop
for (i in 1:9) {
  plata <- deposito[i] + deposito[i] * tasa.interes
  deposito[i + 1] <- plata
}
 
 
# Otro ejemplo: serie de Fibonacci
# La serie de Fibonacci empieza con dos 1 y se calcula cada valor siguiente
# sumando los dos anteriores.

# Es decir, si f( n ) es el enésimo valor de la serie, una forma de describir
# la serie es (empezando por n=3):
# f( n ) = f(n - 1) + f(n - 2)

# Los primeros valores son:
# 1 1 2 3 5 8 13 21 34 55 89 ...

# Calculemos los primeros 20 elementos de la serie:

fibo <- numeric(20) + 1
# "fibo" es un vector para rellenar.
for (n in 3:20) {
  fibo[n] <- fibo[n - 1] + fibo[n - 2]
  # Esta viene a ser la ecuación de más arriba...
}
fibo
plot(fibo)
plot(fibo, log='y', type='o')
