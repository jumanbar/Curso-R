# ---------------------------------------------------------#
# a <- as.data.frame(state.x77)
# b <- cbind(abb = state.abb, a, div = state.division)
# 
# outAnalf <- b$Illiteracy[s1 <- sample(50, 11)]
# b$Illiteracy[s1] <- NA
# 
# outIngr <- b$Income[s2 <- sample(50, 7)]
# b$Income[s2] <- NA
# 
# str(b)
# summary(b)
# 
# write.table(b, 'usa2.csv', sep = ';')
# x <- read.table('usa.csv', header=T)

##------ Importar ------##  1

usa <- read.table('usa.csv', header = TRUE, row.names = 1)
names(usa) <- c('Abrev', 'Poblacion', 'Ingresos', 'Analf', 'Esp.Vida', 
                'Homicidio', 'Sec.Grad', 'Heladas', 'Area', 'Division')

levels(usa$Division) <- c('Noreste Central', 'Sudeste Central', 
                          'Atlantico Central', 'Montania', 'Nueva Inglaterra', 
                          'Pacifico', 'Atlantico Sur', 'Noroeste Central',
                          'Sudoeste Central')
usa.check <- usa

##------ Arreglar Analf ------##  2

usa2 <- usa
usa.extra <- read.csv2('usa-extra.csv', row.names = 1)
estados <- rownames(usa)[is.na(usa$Analf)]
parche <- usa.extra$Analf[rownames(usa.extra) %in% estados]
usa2$Analf[is.na(usa$Analf)] <- parche

##------ Eliminar NAs de Ingresos ------##  3

usa3 <- subset(usa2, !is.na(Ingresos))
# summary(usa3)
# dim(usa3)

##------ Extra: función para estandarizar ------##  4
# Hacer una función que estandarice valores:

est <- function(x)
  (x - mean(x, na.rm = T)) / sd(x, na.rm = T)

##------ Estandarizar valores ------##  5
# save(est, .z, file = 'est.rda')
load('est.rda')

if ('Ing.Cat' %in% names(usa3))
  usa3 <- usa3[- 11]
datosNumericos <- usa3[-c(1, 10)]
datosTrans <- apply(datosNumericos, 2, est)
datosTrans <- as.data.frame(datosTrans)
usaNorm <- cbind(usa3['Abrev'], datosTrans, usa3['Division'])
##------ Categorías de ingresos ------##  6

usa3$Ing.Cat <- cut(usa3$Ingresos, 4)
tapply(usa3$Poblacion, usa3$Ing.Cat, mean)
tapply(usa3$Analf, usa3$Ing.Cat, summary)
tapply(usa3$Analf, usa3$Division, summary)
boxplot(Poblacion ~ Ing.Cat, usa3)
boxplot(Analf ~ Ing.Cat, usa3)
boxplot(Homicidio ~ Ing.Cat, usa3)
boxplot(Esp.Vida ~ Ing.Cat, usa3)

boxplot(usa3$Poblacion ~ Ing.Cat, usa3)
boxplot(usa3$Analf ~ Ing.Cat, usa3)
boxplot(usa3$Esp.Vida ~ Ing.Cat, usa3)
boxplot(usa3$Homicidio ~ Ing.Cat, usa3)
bp <- boxplot(usa3$Sec.Grad ~ Ing.Cat, usa3)
boxplot(usa3$Poblacion ~ Division, usa3)
boxplot(usa3$Analf ~ Division, usa3)
boxplot(usa3$Esp.Vida ~ Ing.Cat, usa3)
boxplot(usa3$Homicidio ~ Ing.Cat, usa3)

##------ Exportar ------##  7

write.table(usaNorm, file = 'usa-norm.csv', sep = ';', dec = ',')

##------ ------##  8
##------ ------##  9
##------ ------##  10

# Usar otra matriz para sustituir los valores NA de la columna Analf

# s1 <- which(is.na(b$Illiteracy))
# usa.inc <- read.csv('usa-incompleto.csv', row.names = 1)
# usa.inc[,1] <- round(usa.inc[,1] + rnorm(nrow(usa.inc), sd = 0.13), 1)
# usa.inc[,2] <- round(usa.inc[,2] + rnorm(nrow(usa.inc)), 1)
# 
# save(usa.inc, outAnalf, file = 'aux.rda')
# .usainc <- function() {
#   load('aux.rda')
#   n <- is.na(usa.inc$Illiteracy)
#   usa.inc$Illiteracy[n] <- outAnalf + round(rnorm(sum(n), sd = 0.2), 1)
#   write.csv2(usa.inc, file = 'usa-extra.csv')
# }

.usainc <- function() {
#   load('aux')
  load('aux.rda')
  n <- is.na(usa.inc$Analf)
  usa.inc$Analf[n] <- outAnalf + round(rnorm(sum(n), sd = 0.2), 1)
  write.csv2(usa.inc, file = 'usa-extra.csv')
  cat("Nota: ¡Se han cambiado algunos valores del archivo 'usa-extra.csv'!\n")
}

.z <- function(x) (x - mean(x, na.rm = T)) / sd(x, na.rm = T)
est <- function(x) .z(x)
save(.z, est, file = 'est.rda')
if ('Ing.Cat' %in% names(usa3))
  usa3 <- usa3[- 11]
load('usa.inc.rda')
save(usa.check, usa.inc, usa2, usa3, usaNorm, outAnalf,
     file = '~/projects/Curso-R/ejercicios-de-programacion/rep-3/aux')

