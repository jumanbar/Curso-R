################################################################################
################################################################################


## NÚMERO DE REPARTIDO!
rdir <- basename(getwd())
nrep <- as.numeric(gsub("[[:alpha:][:punct:]]", "", rdir))
rep.date <- format(Sys.time(), "%Y-%m-%d %H:%M") # Fecha en que se hizo "datos"
url.datos <- "http://goo.gl/ZbJA0" # URL acortada para bajar el archivo datos
guardar <- c("guardar", "rdir", "nrep", "rep.date", "url.datos")


# Existe ya el subdir?
if (!file.exists(rdir))
  dir.create(rdir)

# Borrar todos los contenidos:
unlink(file.path(rdir, dir(rdir)), recursive = TRUE)

## ARCHIVOS AUXILIARES (evaluar.R NO VA ACÁ):
aux <- c("datos", "INSTRUCCIONES.pdf", "hacemagia.R")

## SCRIPTS DE EJERCICIOS:
# Es importante que un guión separe el número del nombre en sí...
corregir <- c("1.a-sexo.R", "1.b-hist.R")
corregir <- sort(corregir)

## El total de los esperados...:
esperados <- c(aux, corregir)

## Números de ejercicios
cor.split <- strsplit(corregir, "-")
ejnum <- unlist(cor.split)[grepl("^[0-9]", unlist(cor.split))]
# xx <- unlist(cor.split)[!grepl("^[0-9]", unlist(cor.split))]
# xx <- xx[-8]
# file.copy(xx, corregir)

### FUNCIONES AUXILIARES:
source("../auxiliares.R")
source("correctores.R")
clist <- vector("list") # Lista con funciones de corrección
txt <- paste0("clist$cor", ejnum, " <- cor", ejnum)
eval(parse(text = txt))
guardar <- c(objetos$generales, objetos[[gsub("-", ".", rdir)]], "clist")
save(list = guardar, file = "auxiliar.RData")

notas <- data.frame(Parte = c(ejnum, 'Total (%)'),
                    Nota=numeric(length(corregir) + 1),
                    Script=c(corregir, '--'))
# class(notas) <- "notas"
# write.csv2(notas, file='notas.csv', row.names=FALSE)
# extras <- '2.d'
extras <- ejnum[grep("extra", corregir)]
ob.sum <- sum(!(ejnum %in% extras)) # Cuantos són los obligatorios?

## Guardando el código:
codigo <- lapply(corregir, cut.script)
names(codigo) <- corregir
class(codigo) <- "codigo"

info <- list(nrep = nrep,
             rdir = rdir,
             url.desc = url.desc,
             rep.date = rep.date,
             aux = aux,
             corregir = corregir,
             esperados = esperados,
             ejnum = ejnum,
             extras = extras,
             ob.sum = ob.sum,
             notas = notas,
             codigo = codigo)
save(info, file = "info.RData")

##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################
##########################################################################################################

## NÚMERO DE REPARTIDO!
# nrep <- X
# rdir <- paste('rep', nrep, sep='-')
rdir <- basename(getwd())

esperados <- c("datos", "notas.csv", "INSTRUCCIONES.pdf",
               "est.RData", "usa.xls", "usa-extra.csv")
# Los archivos de los ejercicios deben est
# correcto (para el menú de 'evaluar'):
corregir <- c("importar.R", "parche.R", "filtrado.R", "est.R", 
              "transformar.R", "nuevo-factor.R", "exportar.R")
esperados <- c(esperados, corregir)
codigo <- lapply(corregir, readLines, encoding = "UTF-8")
names(codigo) <- corregir
ejnum  <- c('1.a', '1.b', '1.c', '1.d', '1.e', '1.f', '1.g')
notas <- data.frame(Parte = c(ejnum, 'Total (%)'),
                    Nota=numeric(length(corregir) + 1),
                    Script=c(corregir, '--'))
write.csv2(notas, file='notas.csv', row.names=FALSE)
extras <- c('1.d', '1.f')
oblg   <- sum(!(ejnum %in% extras))
guardar <- c('esperados', 'corregir', 'extras', 'oblg', 'ejnum', 'guardar', 'reload',
             'notas', 'codigo', 'corAll')

source("../auxiliares.R")

a <- readLines("tmp.R", encoding = "UTF-8")
a <- a[a != ""]
a <- sacar.comentarios(a)
pline <- a[grep("plot", a)]
cortado <- strsplit(pline, ",")[[1]]
cortado <- gsub(" +$", "", cortado)
parg <- cortado[1]
cortado <- gsub(")$", "", cortado)
main <- cortado[grep("main", cortado)]
# main.text <- strsplit(main, "[\",']")[[1]][2]
main.text <- strsplit(main, "=")[[1]][2]
main.text <- eval(parse(text = main.text))
xlab <- cortado[grep("xlab", cortado)]
# xlab.text <- strsplit(xlab, "[\",']")[[1]][2]
xlab.text <- strsplit(xlab, "=")[[1]][2]
xlab.text <- eval(parse(text = xlab.text))
ylab <- cortado[grep("ylab", cortado)]
# ylab.text <- strsplit(ylab, "[\",']")[[1]][2]
ylab.text <- strsplit(ylab, "=")[[1]][2]
ylab.text <- eval(parse(text = ylab.text))
xxx <- cortado[grep("xxx", cortado)]
length(xxx) == 0

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
