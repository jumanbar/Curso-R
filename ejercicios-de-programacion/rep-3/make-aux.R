usa <- read.table('usa.csv', header = TRUE, row.names = 1, sep=',')
names(usa) <- c('Abrev', 'Poblacion', 'Ingresos', 'Analf', 'Esp.Vida', 
                'Homicidio', 'Sec.Grad', 'Heladas', 'Area', 'Division')

levels(usa$Division) <- c('Noreste Central', 'Sudeste Central', 
                          'Atlantico Central', 'Montania', 'Nueva Inglaterra', 
                          'Pacifico', 'Atlantico Sur', 'Noroeste Central',
                          'Sudoeste Central')

usa.check <- usa
outAnalf <- state.x77[,'Illiteracy'][which(is.na(usa.check$Analf))]
usa2 <- usa
usa.extra <- read.csv2('usa-extra.csv', row.names = 1)
estados <- rownames(usa)[is.na(usa$Analf)]
parche <- usa.extra$Analf[rownames(usa.extra) %in% estados]
usa2$Analf[is.na(usa$Analf)] <- parche
# usa2[estados, "Analf"] <- parche
usa3 <- subset(usa2, !is.na(Ingresos))
est <- function(x)
  (x - mean(x, na.rm = T)) / sd(x, na.rm = T)
datosNumericos <- usa3[-c(1, 10)]
datosTrans <- apply(datosNumericos, 2, est)
datosTrans <- as.data.frame(datosTrans)
usaNorm <- cbind(usa3['Abrev'], datosTrans, usa3['Division'])
# write.table(usaNorm, file = 'usa-norm.csv', sep = ';', dec = ',', header = TRUE, row.names = 1)
write.table(usaNorm, file = 'usa-norm.csv', row.names = TRUE, col.names = TRUE, sep = ";", dec = ",")
write.table(usaNorm[sample(nrow(usaNorm), 10),], file = 'usa-norm-ejemplo.csv', row.names = TRUE, 
            col.names = TRUE, sep = ";", dec = ",")
esperados <- c('usa-norm-ejemplo.csv', esperados)

usa3a <- usa3
usa3a$Ing.Cat <- cut(usa3$Ingresos, 4)
levels(usa3a$Ing.Cat) <- c("D", "C", "B", "A")
salidaTapply <- tapply(usa3a$Analf, usa3a$Ing.Cat, summary)
salidaBoxplot <- boxplot(Analf ~ Ing.Cat, usa3a)

# .usainc <- function() {
#   load('aux.rda')
#   n <- is.na(usa.inc$Analf)
#   usa.inc$Analf[n] <- outAnalf + round(rnorm(sum(n), sd = 0.2), 1)
#   write.csv2(usa.inc, file = 'usa-extra.csv')
#   cat("Nota: ¡Se han cambiado algunos valores del archivo 'usa-extra.csv'!\n")
# }

.usainc <- function() {
  load('datos')
  n <- is.na(usa.inc$Analf)
  #   usa.inc$Analf[n] <- outAnalf + sample(c(-0.1, 0.1), sum(n), replace = TRUE)
  usa.inc$Analf[n] <- outAnalf + round(runif(sum(n), -0.1, 0.1), 1)
  write.csv2(usa.inc, file = 'usa-extra.csv')
  warning("Como parte de la correción, se han cambiado algunos valores del archivo 'usa-extra.csv'\n", call. = FALSE)
}

.z <- function(x) (x - mean(x, na.rm = T)) / sd(x, na.rm = T)
est <- function(x) .z(x)
save(.z, est, file = 'est.RData')
usa.inc <- read.csv2('usa-extra.csv', row.names = 1)

mkmsj.v <- function(msj.base = "", vec.obs, vec.esp) {
  # msj.base: mensaje indicando en qué objeto está el error,
  #           ej.: El vector XXX no coincide con lo esperado
  #           nota: se agrega una coma y un \n al final.
  # vec.obs, vec.esp: vectores observado y esperado respect.
  donde <- which(vec.obs != vec.esp)
  output <- cbind(vec.obs[donde], vec.esp[donde])
  if (is.factor(vec.obs))
    output <- cbind(as.character(vec.obs[donde]), as.character(vec.esp[donde]))
  colnames(output) <- c("Valor observado", "Valor esperado")
  if (is.null(names(vec.obs)))
    rownames(output) <- paste("Posición ", donde, ":", sep = "")
  output <- capture.output(print(output))
  mensaje <- c(paste(msj.base, ",\n", sep=""),
               "las diferencias observadas son las siguientes:\n\n", 
               paste("  ", output, "\n", sep = ""))
  mensaje
}

mkmsj.df <- function(msj.base = "", df.obs, df.esp) {
  # msj.base: mensaje indicando en qué objeto está el error,
  #           ej.: La data.frame XXX no coincide con lo esperado
  #           nota: se agrega una coma y un \n al final.
  # df.obs, df.esp: data.frames observadas y esperadas respect.
  donde <- which(df.obs != df.esp, arr.ind = TRUE)
  output <- cbind(donde, df.obs[donde], df.esp[donde])
  output[,2] <- colnames(usa)[as.numeric(output[,2])]
  colnames(output) <- c("Fila", "Columna", "Valor observado", "Valore esperado")
  output <- capture.output(print(output))
  mensaje <- c(paste(msj.base, ",\n", sep=""),
               "las diferencias observadas son las siguientes:\n\n", 
               paste("  ", output, "\n", sep = ""))
  mensaje
}

mkmsj.m <- function(msj.base = "", m.obs, m.esp) {
  # msj.base: mensaje indicando en qué objeto está el error,
  #           ej.: La matriz XXX no coincide con lo esperado
  #           nota: se agrega una coma y un \n al final.
  # m.obs, m.esp: matrices observadas y esperadas respect.
  donde <- which(m.obs != m.esp, arr.ind = TRUE)
  output <- cbind(donde, m.obs[donde], m.esp[donde])
  colnames(output) <- c("Fila", "Columna", "Valor observado", "Valore esperado")
  output <- capture.output(print(output))
  mensaje <- c(paste(msj.base, ",\n", sep=""),
               "las diferencias observadas son las siguientes:\n\n", 
               paste("  ", output, "\n", sep = ""))
  mensaje
}

sacarComentarios <- function(s) {
  # Saca comentarios en un vector character, el cual se supone
  # que contiene líneas de código R (cada elemento de s = una
  # línea de código).
  # i.e.: saca todo lo que viene después del # en cada línea
  s <- s[s != ""] # Saco líneas en blanco
  splited <- strsplit(s, "#") # Corta las líneas en los #
  for (i in 1:length(s)) {
    s[i] <- splited[[i]][1]
  }
  gsub(" +$", "", s) # Borra espacios al final de las líneas
}

## GUARDAR TODO:

save(usa.check, usa.inc, usa2, usa3, usa3a, usaNorm, outAnalf, .usainc, sacarComentarios, salidaTapply, salidaBoxplot, 
     file = 'auxiliar.RData')
guardar <- c(guardar, 'usa.check', 'usa.inc', 'usa2', 'usa3', 
             'usa3a', 'usaNorm', 'outAnalf', '.usainc', 'mkmsj.v', 
             'mkmsj.df', 'mkmsj.m', 'sacarComentarios', 'salidaTapply',
             'salidaBoxplot') 

