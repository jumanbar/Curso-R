# Instrucciones: debe crearse un archivo de texto plano (txt o csv), 
# utilizando excel, libreoffice u otro programa, con los datos de usa.xls. 
# Dicho archivo debe guardarse en la carpeta del repartido (rep-3). En el 
# código de este script deben estar los comandos necesarios para importar 
# dichos datos y crear la data.frame usa, el cual será el único objeto 
# evaluado.
# usa*: data.frame con los datos importados desde el archivo "usa.xls". Ver la 
#   letra del repartido para consultar los detalles de dicho objeto.
#===== Su código comienza aquí: =====#

usa <- read.table(file = "usa.csv", header = TRUE, sep = ",", dec = ".", row.names = 1)
names(usa) <- c("Abrev", "Poblacion", "Ingresos", "Analf", "Esp.Vida", "Homocidio", "Sec.Grad", "Heladas", "Area", "Division")
levels(usa$Division) <- c('Noreste Central', 'Sudeste Central', 'Atlantico Central', 'Montania', 'Nueva Inglaterra', 'Pacifico', 'Atlantico Sur', 'Noroeste Central', 'Sudoeste Central')

#====== Aquí finaliza su código =====#

