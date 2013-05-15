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

source("../auxiliares.R")

save(.z, est, file = 'est.RData')
usa.inc <- read.csv2('usa-extra.csv', row.names = 1)

## GUARDAR TODO:

save(usa.check, usa.inc, usa2, usa3, usa3a, usaNorm, outAnalf, .usainc, sacarComentarios, salidaTapply, salidaBoxplot, 
     file = 'auxiliar.RData')
guardar <- c(guardar, 'usa.check', 'usa.inc', 'usa2', 'usa3', 
             'usa3a', 'usaNorm', 'outAnalf', '.usainc', 'mkmsj', 'mkmsj.v', 
             'mkmsj.df', 'mkmsj.m', 'sacarComentarios', 'salidaTapply',
             'salidaBoxplot') 

