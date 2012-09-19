
# Importar y exportar datos en R

# La edición de datos desde R puede resultar difícil, en comparación con las hojas de cálculo,
# debido a que no presenta las mismas facilidades de visualización de tablas de datos que éstas.
# Si bien es posible, como ya hemos visto, editar datos como objetos de R (e.g. vectores,
# matrices, dataframes), es relevante sobre este punto aprender a importar datos desde,
# por ejemplo, hojas de cálculo.

# Importar datos desde archivos de texto

# La opción más rápida y funcional es importar y exportar datos directamente desde R.
# Los archivos de texto plano son la opción más sencilla para importar datos desde hojas de cálculo.
# Desde cualquier hoja de cálculo se pueden guardar planillas en formatos de texto básico.
# Por ejemplo, Excel permite guardar e importar archivos .txt (i.e. texto delimitado por tabulaciones)
# o .csv (i.e. texto delimitado por comas).
# Estos archivos, habiendo sido guardados desde Excel, pueden ser leídos desde R, mediante la función 'read.table'.

# Paso previo...
# Antes de importar cualquier tipo de archivo que contenga nuestros datos, debemos conocer el directorio de trabajo en donde estamos trabajando y el directorio de trabajo en donde se encuentran nuestros datos.
# Esto es muy importante a tener en cuenta, dado que muchas veces R trabaja en una carpeta por defecto y nuestros datos se pueden encontrar en otra carpeta generada por nosotros.
# Para resolver estas cuestiones recuerde que existen las funciones 'getwd()' y 'setwd()'. La primera nos dice en que directorio de trabajo nos encontramos actualmente y la segunda nos permite cambiar dicho directorio.

# Una vez que nos hallamos en la carpeta en donde se encuentran nuestros archivos de datos, estamos prontos para importar los mismos al R.

# Para comprender un poco mejor como es que funciona la función para importar los datos realizaremos un ejemplo.
# Habiendo descargado el archivo "ejemplo.txt", de esta unidad al directorio de trabajo de R, ejecutar:
read.table (file = "ejemplo1.txt", header = TRUE, sep = "\t", dec = ".")

# Si uds. logró importar correctamente el archivo, deberá ver una matriz o tabla donde las filas van de 's1' a 's5', las columnas de la 'a' a la 'e' y se encuetra llena de 0's y 1's.

# Es importante entender los argumentos de la función 'read.table'
# 'file' es el nombre del archivo que queremos importar. Tenga en cuenta que este debe tener la extensión del archivo, en este caso es un txt, pero R también acepta otros como xls o csv...
# Observe que el nombre del archivo a importar, debe ser escrito entre comillas!!!
# 'header' es un argumento lógico que cuando es TRUE, como en este caso, nos indica que el nombre de las variables (columnas) en nuestro archivo de calculo original, sino que deben tenerse en cuenta y no forman parte de las filas de la tabla importada.
# (juegue con el argumento cambiando ahora su valor a FALSE)
# 'sep' es el argumento que indica como hemos separado los distintos caracteres (columnas) en nuestro archivo de calculo. 
# Este paso es muy importante, dado que dependiendo de que formato hayamos elejido para guardar nuestro archivo de cálculo, R reconocerá los distintos simbolos para interpretar en donde comienza y termina una columna.
# En el archivo de cálculo al guardar los datos ya sea en formato txt o en formato csv, se debe especificar cual separados se desea utilizar.
# En un archivo txt el separador es la tabulación y el R comprende dicha separación a través de el simbolo '\t', como se puede observar en el ejemplo.
# Otra forma de guardar un archivo de cálculo es formato csv. En este caso el separador debe ser la coma ',' o el punto y coma ';'. 
# 'dec' es el argumento que indica que simbolo utilizamos en nuestro archivo de cálculo para separar los decimales. Es altamente recomendable que el separador de los decimales sea el punto '.', así se evitarán confuciones a la hora de importar los datos al R.
# A tener en cuenta, es muy importante no confundir los separadores ya sea de caracteres como dedecimales, se debe ser muy prolijo, dado que si cometemos algún tipo de error, esto puede traer problemas a la hora de importar y reconocer los datos en el R.
# Por último, existen otros argumentos en la función 'read.table' como row.names (para ponerle nombre a las filas), col.names (para ponerle nombres a las columnas si es que nuestra base de datos original no presentaban) y más... 
# para eso utilice la ayuda:
?read.table

# "read.table" importa los datos a un objeto de clase 'dataframe', con las mismas propiedades de cualquier objeto de esta clase.
# Para mantener el objeto en el área de trabajo hay que asignarlo:
ejemplo1 <- read.table (file = "ejemplo1.txt", header = TRUE, sep = "\t", dec = ".")

# Ahora importaremos un archivo pero en formato csv.
# Habiendo descargado el archivo "ejemplo2.csv", de esta unidad al directorio de trabajo de R, ejecutar:
ejemplo2 <- read.table (file = "ejemplo2.csv", header = TRUE, sep = ";", dec = ".")

# Observe que 'ejemplo2' es igual al archivo importado en formato txt 'ejemplo1', pero algunos de los argumentos cambian, por lo cuale debe ser cuidadoso y prolijo a la hora de elejir.

## Importar datos en RStudio

# En RStudio, en el área de trabajo (cuadrante "Workspace") existe el botón "Import Dataset",
# que ofrece las opciones de importar datos desde un archivo de texto o desde una URL.
# Podemos cargar el mismo archivo "ejemplo.txt" utilizando esta opción, pero tal
# vez tengamos que corregir los títulos de las filas posteriormente, elejir si queremos encabezar(header) y como vamos a separar los caracteres y decimales.

# Exportar desde R

# De la misma manera que importamos datos desde hojas de cálculo, nos interesa también exportar datos en formatos que puedan ser levantados desde las mismas, ya sea como resultados de análisis o para visualizar y editar matrices de datos.
# La función en este caso es 'write.table'. 
# Utilizando el mismo ejemplo:
exportar_ejemplo <- write.table (ejemplo1, file = "ejemplo3.txt", sep = "\t", eol = "\n", dec = ".", row.names = TRUE, col.names = TRUE)

# El primer argumento es el nombre del objeto que queremos guardar y VA SIN COMILLAS. Observe que el archivo exportado será guardado en la carpeta de directorio en donde ud. se encuentra trabajando actualmente.
# 'file' es el archivo que queremos exportar, en este caso SI VA CON COMILLAS.
# 'sep' es lo mismo que para 'read.table'.
# 'eol' es el caracter que indica el final de línea.
# 'dec' es los mismo que para 'read.table'.
# 'row.names' es una opción lógica que indica si los nombres de las filas se escriben en el archivo exportado.
# 'col.names'

# Este comando produce un archivo del formato indicado, o coloca la información en el 
# portapapeles (file = "clipboard") para pegarlo en una hoja de cálculo, o incluso 
# en otra sesión de R si así lo deseamos.

# Para más información a cerca de la función, consulte la ayuda de R:
?write.table

# El importar datos en R es el primer pado para poder realizar nuestros análsis. Porlo tanto, es importante comprender como estos son ingresados y como el R los reconoce, de lo contrario nos puede no solo traer errores que nos impidan realizar los análsis sino también obtener resultados no deseados.


# EXTRA

# Datos guardados en otros paquetes estadísticos

# El paquete "foreign" consiste en funciones para compatibilizar el formato de otros
# paquetes estadísticos y bases de datos (e.g. S, SAS, SPSS, Stata, dBase) para importar 
# y exportar datos desde R.

