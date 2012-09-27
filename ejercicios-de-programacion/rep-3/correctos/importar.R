# Instrucciones: debe crearse un archivo de texto plano (txt o csv), 
# utilizando excel, libreoffice u otro programa, con los datos de usa.xls. 
# Dicho archivo debe guardarse en la carpeta del repartido (rep-3). En el 
# código de este script deben estar los comandos necesarios para importar 
# dichos datos y crear la data.frame usa, el cual será el único objeto 
# evaluado.
# usa*: data.frame con los datos importados desde el archivo "usa.xls". Ver la 
#   letra del repartido para consultar los detalles de dicho objeto.
#===== Su código comienza aquí: =====#

usa <- read.table('usa.csv', header = TRUE, row.names = 1)
names(usa)[c(1:8, 10)] <- c('Abrev', 'Poblacion', 'Ingresos', 'Analf', 'Esp.Vida',
                            'Homicidio', 'Sec.Grad', 'Heladas', 'Division')

levels(usa$Division) <- c('Nueva Inglaterra', 'Atlantico Central', 'Atlantico Sur',
                          'Sudeste Central', 'Sudoeste Central', 'Noreste Central',
                          'Noroeste Central', 'Montania', 'Pacifico')

#====== Aquí finaliza su código =====#

