## Importar y exportar datos en R
 
# La edición de datos desde R puede resultar difícil, en comparación con las hojas de cálculo,
# debido a que no presenta las mismas facilidades de visualización de tablas de datos que éstas.
# Si bien es posible, como ya hemos visto, editar datos como objetos de R (e.g. vectores,
# matrices, dataframes), es relevante sobre este punto aprender a importar datos desde,
# por ejemplo, hojas de cálculo.
 
# Existen paquetes de R diseñados para comunicarse con hojas de cálculo que permiten
# entre otras cosas ejecutar funciones de R desde las mismas, importar y exportar datos y
# salidas de análisis.
# El más notorio de estos paquetes es RExcel (http://www.statconn.com/; 
# http://cran.r-project.org/web/packages/RExcelInstaller/index.html), que funciona como un plug-in
# instalado directamente en Excel como herramientas y opciones de menú.
# Estos paquetes facilitan la edición de datos, ya que los podemos editar en la hoja
# de cálculo, seleccionarlos y enviarlos a R con un simple click.
# Sin embargo, su instalación muchas veces no es sencilla para cualquier usuario:
# el mencionado RExcel requiere la instalación de tres paquetes en R (rscproxy, rcom, RExcelInstaller)
# y la posterior descarga e instalación (desde R) de un plug-in y su configuración desde Excel
 
## Importar datos desde archivos de texto
 
# La opción más rápida y funcional es importar y exportar datos directamente desde R.
# Los archivos de texto plano son la opción más sencilla para importar datos desde hojas de cálculo.
# Desde cualquier hoja de cálculo se pueden guardar planillas en formatos de texto básico.
# Por ejemplo, Excel permite guardar e importar archivos .txt (i.e. texto delimitado por tabulaciones)
# o .csv (i.e. texto delimitado por comas).
# Estos archivos, habiendo sido guardados desde Excel, pueden ser leídos desde R, 
# mediante la función 'read.table'. Habiendo descargado el archivo "ejemplo.txt", de este módulo al
# directorio de trabajo de R, ejecutar:
read.table (file = "ejemplo.txt", header = TRUE, row.names = 1, sep = "\t", dec = ".")
# (ver ayuda para los argumentos)
 
# En forma similar, en lugar de guardar los datos a un archivo los podemos copiar al portapapeles.
# Podemos abrir el archivo anterior con una hoja de cálculo o el bloc de notas y copiar el contenido.
# Para levantarlos en R sustituimos el nombre o ruta al archivo por "clipboard":
read.table (file = "clipboard", header = TRUE, row.names = 1, sep = "\t", dec = ".")
 
# "read.table" importa los datos a un objeto de clase 'dataframe', con las mismas propiedades 
# de cualquier objeto de esta clase. Para mantener el objeto en el área de trabajo hay 
# que asignarlo. Ej:
ejemplo <- read.table (file = "clipboard", header = TRUE, row.names = 1, sep = "\t", dec = ".")
 
## Importar datos en RStudio
 
# En RStudio, en el área de trabajo (cuadrante "Workspace") existe el botón "Import Dataset",
# que ofrece las opciones de importar datos desde un archivo de texto o desde una URL.
# Podemos cargar el mismo archivo "ejemplo.txt" utilizando esta opción, pero tal
# vez tengamos que corregir los títulos de las filas posteriormente.
 
## Exportar desde R
 
# De la misma manera que importamos datos desde hojas de cálculo, nos interesa también exportar
# datos en formatos que puedan ser levantados desde las mismas, ya sea como resultados de análisis 
# o para visualizar y editar matrices de datos.
# La función en este caso es 'write.table'. Ej:
write.table (ejemplo, file = "ejemplo2.txt", quote = FALSE, sep = "\t", eol = "\n", dec = ".", row.names = TRUE, col.names = TRUE)
 
# El primer argumento es el nombre del objeto que queremos guardar. Va sin comillas. Para el
# resto de los argumentos, ir a la ayuda de la función.
# Este comando produce un archivo del formato indicado, o coloca la información en el 
# portapapeles (file = "clipboard") para pegarlo en una hoja de cálculo, o incluso 
# en otra sesión de R si así lo deseamos.
 
## Datos guardados en otros paquetes estadísticos
 
# El paquete "foreign" consiste en funciones para compatibilizar el formato de otros
# paquetes estadísticos y bases de datos (e.g. S, SAS, SPSS, Stata, dBase) para importar 
# y exportar datos desde R.
