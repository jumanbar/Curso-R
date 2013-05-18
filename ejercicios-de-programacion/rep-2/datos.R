################################################################################
################################################################################


###############################################################
# ATENCIÓN: FALTA TERMINAR DE IMPLEMENTAR LAS NUEVAS FUNCIONES:
# mkmsj.xxx
# objnames
# cut.script
# ADEMÁS SE ESTÁ REESTRUCTURANDO TODO EL SISTEMA DE CORRECCIÓN!
###############################################################

# make.datos.R <- function() {

## NÚMERO DE REPARTIDO!
#   nrep <- 2
#   rdir <- paste0('rep-', nrep)
rdir <- basename(getwd())
nrep <- gsub("[[:alpha:][:punct:]]", "", repdir)
rep.date <- format(Sys.time(), "%Y-%m-%d %H:%M") # Fecha en que se hizo "datos"
url.desc <- "http://goo.gl/b4l9D" # URL acortada para bajar el archivo datos

# Existe ya el subdir?
if (!file.exists(rdir))
  dir.create(rdir)

# Borrar todos los contenidos:
unlink(file.path(rdir, dir(rdir)), recursive = TRUE)


### FUNCIONES AUXILIARES:
source("../auxiliares.R", local = TRUE)
source("correctores.R")
clist <- vector("list") # Lista con funciones de corrección
txt <- paste0("clist$cor", ejnum, " <- cor", ejnum)
eval(parse(text = txt))
guardar <- c(objetos$generales, objetos[[gsub("-", ".", rdir)]], "clist")
save(guardar, file = "auxiliar.RData")

## ARCHIVOS AUXILIARES:
aux <- c("info.RData", "auxiliar.RData", "INSTRUCCIONES.pdf", "calificaciones.R", "ej2.RData")

## SCRIPTS DE EJERCICIOS:
# Es importante que un guión separe el número del nombre en sí...
corregir <- c("1.a-aprobados.R", "1.b-aprobados2.R", "1.c-mejorcitos.R", "1.d-franjas.R", 
              "2.a-data.frame.R", "2.b-ordenacion.R", "2.c-lista.R", "2.d-extra-print.listaCalif.R")
corregir <- sort(corregir)

## El total de los esperados...:
esperados <- c(aux, corregir)

## Guardando el código:
codigo <- lapply(corregir, cut.script)
names(codigo) <- corregir
class(codigo) <- "codigo"

## Números de ejercicios
cor.split <- strsplit(corregir, "-")
# ejnum <- unlist(cor.split)[1:length(cor.split) %% 2 == 1]
ejnum <- unlist(cor.split)[grep("^[0-9]", unlist(cor.split))]
# ejnum <- c('1.a', '1.b', '1.c', '1.d', '2.a', '2.b', '2.c', '2.d')

notas <- data.frame(Parte = c(ejnum, 'Total (%)'),
                    Nota=numeric(length(corregir) + 1),
                    Script=c(corregir, '--'))
write.csv2(notas, file='notas.csv', row.names=FALSE)
# extras <- '2.d'
extras  <- ejnum[grep("extra", corregir)] 
ob.sum <- sum(!(ejnum %in% extras)) # Cuantos són los obligatorios?

info <- list(nrep      = nrep, 
             rdir      = rdir,
             url.desc  = url.desc,
             rep.date  = rep.date, 
             aux       = aux,
             corregir  = corregir,
             esperados = esperados, 
             ejnum     = ejnum,
             extras    = extras,
             ob.sum    = ob.sum,
             notas     = notas,
             codigo    = codigo)
save(info, file = "info.RData")
             
### Copiar archivos en el subdirectorio rdir:
file.copy(esperados, rdir, recursive = TRUE)
file.copy("../evaluar.R", rdir, recursive = TRUE)

################################################################################

### GUARDAR TODO
# guardar <- unique(guardar)
# save(list = guardar, file = 'datos')

### REINICIAR EL DIRECTORIO Y ZIP FILE

# file.copy(esperados, rdir, recursive = TRUE)
# file.copy("../evaluar.R", rdir, recursive = TRUE)
# zipfile <- paste(rdir, 'zip', sep = '.')
# unlink(zipfile)
# zip(zipfile, paste(rdir, '/', sep=''))

### Compilar las instrucciones ...?
# require(knitr)
# knit("INSTRUCCIONES.Rmd", encoding = "UTF-8")
