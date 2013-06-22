################################################################################
### NÚMERO DE REPARTIDO!
rdir <- basename(getwd())
nrep <- as.numeric(gsub("[[:alpha:][:punct:]]", "", rdir))
rep.date <- format(Sys.time(), "%Y-%m-%d %H:%M %Z") # Fecha en que se hizo "datos"
url.datos <- "http://goo.gl/xgJ4E" # URL acortada para bajar el archivo datos
if (url.datos == "") stop("FALTA URL.DATOS!")
url.fecha <- "https://www.dropbox.com/s/yupjqgoe33fdu3c/fecha-datos-rep-5.txt"
guardar <- c("guardar", "rdir", "nrep", "rep.date", "url.datos", "url.fecha")
#writeLines(rep.date, paste0("~/Dropbox/IMSER/fecha-datos-", rdir, ".txt"))
writeLines(rep.date, paste0("~/fecha-datos-", rdir, ".txt"))

# Existe ya el subdir?
if (!file.exists(rdir))
  dir.create(rdir)

### BORRAR LOS ARCHIVOS:
unlink(file.path(rdir, dir(rdir)), recursive = TRUE)

### ARCHIVOS AUXILIARES:
aux <- c("../evaluar.R", "datos", "INSTRUCCIONES.pdf", "edu.data.RData", "HandbookSpanish.pdf")

### SCRIPTS DE EJERCICIOS:
# Es importante que un guión separe el número del nombre en sí...
# Formato:
# [1-N].[a-z]-[palabra en minúscula, sólo letras].R
corregir <- c("1-triangulo.R", "2.a-filtroc.R", "2.b-extra-aplicar.R", "2.c-educacion.R", 
              "3.a-cambia.pares.R", "3.b-radio.R", "3.c-extra-distancias.R")
corregir <- sort(corregir)
guardar  <- c(guardar, "corregir", "aux")

### Números de ejercicios
cor.split <- strsplit(corregir, "-")
ejnum <- unlist(cor.split)[grepl("^[0-9]", unlist(cor.split))]

### FUNCIONES AUXILIARES:
source("../auxiliares.R", encoding = "UTF-8")
guardar <- c(guardar, objetos)

### CORRECTORES
source("correctores.R", encoding = "UTF-8")
corAll <- vector("list") # Lista con funciones de corrección
eval(parse(text = paste0("corAll$cor", ejnum, " <- cor", ejnum)))
guardar <- c(guardar, "corAll")

### NOTAS
extras <- ejnum[grep("extra", corregir)]
# extras <- ''
oblg <- sum(!(ejnum %in% extras)) # Cuantos són los obligatorios?
notas <- data.frame(Parte = c(ejnum, 'Total (%)'),
                    Nota=numeric(length(corregir) + 1),
                    Script=c(corregir, '--'))
guardar <- c(guardar, "ejnum", "notas", "extras", "oblg")

### AUXILIAR.RDATA
# source("make-aux.R", encoding = "UTF-8")
# aux <- c(aux, "auxiliar.RData")

## Guardando el código:
codigo <- lapply(corregir, cut.script)
names(codigo) <- corregir
class(codigo) <- "codigo"
guardar <- c(guardar, "codigo")

### El total de los esperados...:
esperados <- c(aux, corregir) # evaluar.R todavía no!!
guardar <- c(guardar, "esperados")

### GUARDAR TODO
guardar <- unique(guardar)
save(list = guardar, file = 'datos')

file.copy(esperados, rdir, recursive = TRUE)

################################################################################
