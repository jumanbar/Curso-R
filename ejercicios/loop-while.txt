================================================================================

¿Cuál es la diferencia entre los dos códigos siguientes? (marcar todos los correctos)
I.
i <- 1
while (i < 21) {
  print(i ** 2)
  i <- i + 1
}

II.
for (i in 1:20)
  print (i ^ 2)

a. Ambos son iguales en su resultado, si bien tienen diferencias de forma. # ok
b. En el primero se hace una multiplicación, mientras que en el segundo se hace
   una operación de potencia.
c. En el segundo caso el valor i resultante es menor al del primer caso. # ok
d. No existen diferencias de resultado, pero las velocidades de ejecución serán
   notoriamente diferentes.
e. Ambos podrían ser iguales, pero en el segundo caso se comete el error de
   omitir las llaves ({, }).

================================================================================

Rellenar en el espacio "___"

p <- 20 # inicia en cero
while (abs(p) < 10) { # abs(p) = valor absoluto de p
  p <- p + sample(c(-1, 1), 1)
  posicion <- c(posicion, p)
}
plot(posicion, type="o", xlab="Iteración", ylab="Posición")
================================================================================
================================================================================
================================================================================
================================================================================
================================================================================
