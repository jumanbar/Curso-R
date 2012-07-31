# Objetos iniciales: fibo es un vector en el que se almacenarán los primeros 20 
# números de la secuencia de fibonacci, empezando por el 0 y el 1.
fibo <- numeric(20)
fibo[2] <- 1

### Su código comienza aquí ###
# Instrucciones:
# Deberá programar el loop adecuado que para calcular los 20 primeros números de
# la secuencia de fibonacci. El loop debe rellenar un elemento nuevo del vector
# 'fibo" en cada paso. Recuerde que los dos primeros elementos de dicho vector
# ya están agregados.





### Fin de su código aquí   ###

# Para ver gráficamente el crecimiento de la secuencia:
i <- 0:19
plot(fibo ~ i, main="Secuencia de Fibonacci", ylab=expression(S[i]), xlab="i")