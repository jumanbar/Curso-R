usa <- read.table('usa.csv', header = TRUE, row.names = 1)
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
usa3 <- subset(usa2, !is.na(Ingresos))
est <- function(x)
  (x - mean(x, na.rm = T)) / sd(x, na.rm = T)
datosNumericos <- usa3[-c(1, 10)]
datosTrans <- apply(datosNumericos, 2, est)
datosTrans <- as.data.frame(datosTrans)
usaNorm <- cbind(usa3['Abrev'], datosTrans, usa3['Division'])
write.table(usaNorm, file = 'usa-norm.csv', sep = ';', dec = ',')

.usainc <- function() {
  load('aux.rda')
  n <- is.na(usa.inc$Analf)
  usa.inc$Analf[n] <- outAnalf + round(rnorm(sum(n), sd = 0.2), 1)
  write.csv2(usa.inc, file = 'usa-extra.csv')
  cat("Nota: ¡Se han cambiado algunos valores del archivo 'usa-extra.csv'!\n")
}

.z <- function(x) (x - mean(x, na.rm = T)) / sd(x, na.rm = T)
est <- function(x) .z(x)
save(.z, est, file = 'est.rda')
usa.inc <- read.csv2('usa-extra.csv', row.names = 1)
save(usa.check, usa.inc, usa2, usa3, usaNorm, outAnalf,
     file = '~/projects/Curso-R/ejercicios-de-programacion/rep-3/aux')
