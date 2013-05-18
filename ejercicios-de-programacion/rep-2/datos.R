################################################################################
################################################################################


###############################################################
# ATENCIÓN: FALTA TERMINAR DE IMPLEMENTAR LAS NUEVAS FUNCIONES:
# mkmsj.xxx
# objnames
# cut.script
# ADEMÁS SE ESTÁ REESTRUCTURANDO TODO EL SISTEMA DE CORRECCIÓN!
###############################################################

## NÚMERO DE REPARTIDO!
nrep <- 2
rdir <- paste0('rep-', nrep)
rep.date <- format(Sys.time(), "%Y-%m-%d %H:%M") # Fecha en que se hizo "datos"
url.desc <- "http://goo.gl/b4l9D" # URL acortada para bajar el archivo datos

### FUNCIONES AUXILIARES:

source("../auxiliares.R")

info <- vector("list")
info$aux <- c("datos", "notas.csv", "INSTRUCCIONES.pdf", "calificaciones.R")
# Los archivos de los ejercicios deben estar en el orden 
# correcto (para el menú de 'evaluar'):
info$corregir <- c("aprobados.R", "aprobados2.R", "mejorcitos.R", "franjas.R", 
                   "data.frame.R", "ordenacion.R", "lista.R", "print.listaCalif.R")
info$esperados <- c(aux, corregir)
codigo <- lapply(info$corregir, cut.script)
names(codigo) <- corregir
ejnum  <- c('1.a', '1.b', '1.c', '1.d', '2.a', '2.b', '2.c', '2.d')
notas <- data.frame(Parte = c(ejnum, 'Total (%)'),
                    Nota=numeric(length(corregir) + 1),
                    Script=c(corregir, '--'))
write.csv2(notas, file='notas.csv', row.names=FALSE)
extras <- '2.d'
oblg   <- sum(!(ejnum %in% extras))
guardar <- c('nrep', 'rep.date', 'esperados', 'corregir', 'extras', 'oblg', 'ejnum', 'guardar', 'reload',
             'notas', 'codigo', 'corAll')


source("../auxiliares.R")
guardar <- c(guardar, objetos)

esperados <- c(esperados, "ej2.RData")

guardar <- c(guardar, 'Print.listaCalif', 'cl', 'gn', 'ct')


################################################################################

### GUARDAR TODO
guardar <- unique(guardar)
save(list = guardar, file = 'datos')

### REINICIAR EL DIRECTORIO Y ZIP FILE

if (!file.exists(rdir))
  dir.create(rdir)
borrar <- dir(rdir)
borrar <- file.path(rdir, borrar)
unlink(borrar, recursive = TRUE)

file.copy(esperados, rdir, recursive = TRUE)
file.copy("../evaluar.R", rdir, recursive = TRUE)
# zipfile <- paste(rdir, 'zip', sep = '.')
# unlink(zipfile)
# zip(zipfile, paste(rdir, '/', sep=''))
