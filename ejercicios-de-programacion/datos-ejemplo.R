################################################################################
## Creación del archivo 'datos' necesario para el repartido de Ejercicios de
## Programación IV: Estructuras de Control
################################################################################
esperados <- c("fibonacci.R", "funcionFibonacci.R", "evaluar.R", "datos", "notas.csv")
corregir  <- c("fibonacci.R", "funcionFibonacci.R")
notas <- data.frame(No.ej=c('1a', '1b', 'Total (%)'), Script=c(corregir, '--'),
                    Nota=numeric(length(corregir) + 1))
write.csv2(notas, file='notas.csv', row.names=FALSE)
oblg  <- 2

fb <- function(n) {
  f <- numeric(n) + 1
  f[1] <- 0
  for (i in 3:n) f[i] <- sum(f[(i - 1):(i - 2)])
  f
}

### FUNCIONES DE CORRECCIÓN:

cor_fibonacci <- function(a) {
  source('fibonacci.R')
  identical(fibo, fb(20)) * 1
}

cor_funcionFibonacci <- function(a) {
  source('funcionFibonacci.R')
  r <- 1
#   n <- sample(10:50, 15, replace=!0)
  for (i in 3:80) {
    r <- r * identical(funcionFibonacci(i), fb(i))
    if (!r)
      break
  }
  r
}

################################################################################
guardar <- c('esperados', 'corregir', 'oblg', 'fb', 'guardar', 'cor_fibonacci',
             'cor_funcionFibonacci')
save(list=guardar, file='datos')
