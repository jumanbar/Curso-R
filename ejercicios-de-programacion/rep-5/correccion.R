zenon1 <- function(n, epsilon) {
  eps <- 1
  if ((1 - sum(1/2^(1:n))) <= epsilon) 
		out <- c("el valor de n provisto es suficiente")
  else {
    while (eps > epsilon) {
      e <- 1:n
      suma <- sum(1/2^e)
      eps <- 1 - suma
      n <- n + 1
    }
    out <- list(suma = suma, n = n)
  }
  out
}

correc <- function() {
  # Primero se cargan el archivo 'datos'
  load('datos')

  # Aquí­ cargo el script (crea en este ambiente la función "educacion" según como la
  # definió el estudiante):
  source('zenon.R', local = TRUE)

  # Aquí­ tomo los nombres de los argumentos de la función:
  fnames1 <- sort(names(formals(zenon)))

  # y aquí­ tomo los nombres de los argumentos de la función correcta ("edu", 
	# la función auxiliar definida al principio).
  fnames2 <- sort(names(formals(zenon1)))

  # Ejecuto 'zenon1' y la función 'zenon' del estudiante con valores de n y
  # epsilon que den error.
  out1 <- zenon(5, 0.5)
  out2 <- zenon1(5, 0.5)
  # Comparo si la salida de ambas es la misma
  if (out1 != out2)
    stop("la salida para un n suficientemente alto es incorrecta")

  # Ejecuto 'zenon' y guardo el resultado en el objeto 'out1'.
  out1 <- zenon(n = 1, epsilon = 0.1)
  # Ejecuto 'zenon1' y guardo el resultado en el objeto 'out2':
  out2 <- zenon1(n = 1, epsilon = 0.1)

  # 1. Evaluación de los nombres de los argumentos de la función:
  if (!all(fnames1 == fnames2))
    stop("los nombres de los argumentos no son los indicados por la letra")

  # 2. Â¿Es la salida de clase lista?
  if (!is.list(out1))
    stop("la salida no es una lista", call. = FALSE)

  # 3. Evaluación de los nombres de dicha lista:
  if (!all(names(out1) == names(out2)))
    stop("los nombres del objeto de salida no coinciden con los esperados", call. = FALSE)

  # 4. Evaluación de los valores contendos en 2 objetos: suma y n:
  if (!all(out1$suma == out2$suma))
    stop("los valores de las sumatorias no son correctos", call. = FALSE)
  if (!all(out1$n == out2$n))
    stop("los valores de n no son correctos", call. = FALSE)

  # Finalmente, si todos los if de arriba se evaluaron como FALSE, entonces la 
	# función devuelve un simple TRUE:
  TRUE
}

