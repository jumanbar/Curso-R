fibonacci <- function(n = 20) {
  # Esta función debe ser capaz de calcular los n primeros números de la secuencia
  # de fibonacci (con n = 20 por defecto), siendo n un número entero positivo a
  # elección del usuario.
  # La salida debe ser un vector con dichos números.

  ### Su código comienza aquí:  ###
  # Instrucciones:
  # Agregue en este espacio el loop creado en el ejercicio 1a, el cual debería
  # encontrarse en el archivo fibonacc.R.
  # Posteriormente modifique las líneas que sean necesarias para que la función
  # pueda crear la secuencia de fibonacci dado un n arbitrario.
  fibo <- numeric(n)
  fibo[2] <- 1
  for (i in 3:n) {
    fibo[i] <- fibo[i - 1] + fibo[i - 2]
  }
  fibo
  ### Fin de su código aquí   ###
}