## Importar y exportar datos en R

# La edición de datos desde R puede resultar difícil, en comparación con
# las hojas de cálculo, debido a que no presenta las mismas facilidades de
# visualización de tablas de datos que éstas.  Si bien es posible, como
# ya hemos visto, editar datos como objetos de R (e.g. vectores, matrices,
# data.frames), es relevante sobre este punto aprender a importar datos desde,
# por ejemplo, hojas de cálculo.

# En caso de no utilizar planillas de cálculo u otros programas para analizar 
# los datos, es más recomendable y simple utilizar las funciones save y load 
# para guardar y cargar objetos de nuestra área de trabajo (ver también 
# saveRDS y readRDS).


## Importar datos desde archivos de texto plano

# La opción más rápida y funcional es importar y exportar datos directamente
# desde R. Los archivos de texto plano, tales como los txt o csv, son la opción
# más sencilla para importar datos desde hojas de cálculo. Desde cualquier 
# programa de hojas de cálculo se pueden guardar planillas con estos formatos. 

# Por ejemplo, Excel permite guardar e importar archivos .txt (i.e. texto 
# delimitado por tabulaciones) o .csv (i.e. texto delimitado por comas). 
# Estos archivos, habiendo sido guardados desde Excel, pueden ser leídos desde 
# R, mediante la función 'read.table'.

# Paso previo...
# Antes de importar cualquier tipo de archivo que contenga nuestros datos, 
# debemos conocer el directorio de trabajo en donde estamos trabajando y el 
# directorio de trabajo en donde se encuentran nuestros datos.
# Esto es muy importante a tener en cuenta, dado que muchas veces R trabaja en
# una carpeta por defecto y nuestros datos suelen encontrarse en otras carpetas
# Para resolver estas cuestiones recuerde que existen las funciones 'getwd()' y 
# 'setwd()' (así como opciones de menú en RStudio). La primera nos dice en que 
# directorio de trabajo nos encontramos actualmente y la segunda nos permite
# cambiar dicho directorio.

# Una vez que nos hallamos en la carpeta en donde se encuentran nuestros
# archivos de datos, estamos prontos para importar los mismos al R.

# Para comprender como es que funciona read.table los datos realizaremos un 
# ejemplo. Habiendo descargado el archivo "ejemplo.txt", de esta unidad al 
# directorio de trabajo actual de R, ejecutar:
read.table(file = "ejemplo1.txt", header = TRUE, sep = "\t", dec = ".")

# Nótese que el archivo puede estar en cualquier otro directorio; siempre que 
# usemos el camino absoluto o relativo correcto R lo podrá importar sin 
# problemas.

# Si ud. logró importar correctamente el archivo, deberá ver una data.frame 
# en la consola, en donde la primer col. va de 's1' a 's5', los nombres de las 
# columnas de la 'b' a la 'e' y se encuetran llena de ceros y unos, mientras 
# que la primera ('a'), tiene números con valores decimales. Puede abrir el 
# archivo de texto en un editor de texto plano (como el editor de scripts de 
# RStudio o el notepad) para comparar este objeto con su contraparte en archivo.

# Es importante entender los argumentos de la función 'read.table', los cuales 
# veremos ahora:
# file: es el nombre del archivo que queremos importar. Tenga en cuenta que
#   este debe tener la extensión del archivo, en este caso es un txt. Nótese que 
#   dicho nombre debe ser escrito entre comillas.
# header: es un argumento lógico que cuando es TRUE, como en este caso, nos
#   indica que el nombre de las variables (columnas) está en nuestro archivo de 
#   calculo original, que deben tenerse en cuenta y no forman parte de las
#   filas de la tabla importada (juegue con el argumento cambiando ahora su 
#   valor a FALSE).
# sep: es el argumento que indica como hemos separado los distintos caracteres
#   (columnas) en nuestro archivo de texto. Dependiendo de que formato hayamos
#   elegido para guardarlo será el valor correcto que debemos utilizar para que
#   R reconozca en donde comienza y termina una columna. En el caso de los 
#   archivos txt los separadores suelen ser tabulaciones o incluso espacios en 
#   blanco de ancho variable (siendo esta última la opción por defecto de 
#   read.table). Para especificar la tabulación como separación se utiliza el
#   simbolo '\t', como se puede observar en el ejemplo. Otra forma de guardar un
#   archivo de cálculo es formato csv. En este caso el separador suele ser la
#   coma ',' o el punto y coma ';' (siendo el primer caso lo normal para una 
#   PC configurada para trabajar en inglés, en la que los decimales no se 
#   indican con comas, si no con puntos; el segundo caso es el normal para 
#   programas en español).
#   Nótese la extensión .txt o .csv es sólo un rótulo y no determina de por sí
#   cuál es el separador de campos (i.e.: un .txt puede usar comas para separar
#   campos, a pesar de ir contra la convención).
# dec: es el argumento que indica el símbolo de los decimales de los números 
#   en nuestro archivo de texto. La opción más adecuada depende de la 
#   configuración de idioma del programa con el que se creó el archivo de 
#   texto a importar. Nótese que en el caso de archivos csv pueden darse 
#   confusiones entre separadores de columnas y decimales, por lo que hay que 
#   estar atento a estos detalles.

# Nota: en la experiencia de los profesores del curso hemos visto que OpenOffice o
# LibreOffice suelen mostrar más flexibilidad a la hora de elegir los valores de sep
# y dec, tanto al importar como al exportar planillas (en comparación con Excel).

# Existen otros argumentos en la función 'read.table' como row.names (para
# ponerle nombre a las filas), col.names (para ponerle nombres a las columnas
# si es que nuestra base de datos original no presentaban) y más... para 
# conocer estos argumentos utilice la ayuda o la función args:
?read.table
args(read.table)

# "read.table" importa los datos a un objeto de clase 'dataframe', con las
# mismas propiedades de cualquier objeto de esta clase. Para mantener el
# objeto en el área de trabajo hay que asignarlo:
ej1 <- read.table(file = "ejemplo1.txt", header = TRUE, sep = "\t", dec = ".")

# Ahora importaremos un archivo pero en formato csv. En principio la única 
# diferencia es que el separador es un punto y coma generalmente (si 
# trabajamos con programas de planilla de cálculo en español). Habiendo
# descargado el archivo "ejemplo2.csv" al directorio de trabajo de R,
# se puede ejecutar:
ej2 <- read.table(file = "ejemplo2.csv", header = TRUE, sep = ";", dec = ".")

# Nonta: es posible que el valor de dec deba ser "," en lugar de "."

# Observe que 'ej2' es igual al archivo importado en formato txt 'ej1',
# pero algunos de los argumentos cambian, por lo cuale debe ser cuidadoso y
# prolijo a la hora de elejir.

# Alternativamente puede utilizar las funciones read.csv, read.csv2 y sus 
# contrapartes write.csv y write.csv2. Estas son simplemente una "envoltura" 
# (wrapper en inglés) de read y write .table, es decir, una variante con 
# argumentos por defecto específicos, diseñadas para respetar las convenciones 
# de Excel y por lo tanto ser generalmente más confiables (aunque dichas 
# convenciones muchas veces no se utilizan en bases de datos descargables 
# de la web).

# En particular, write.csv usa "." para el punto decimal y una "," para la 
# separación de columnas, mientras que write.csv2 usa una "," para el punto 
# decimal y el ";" para la separación de columnas. Estos valores no se pueden 
# cambiar como sucede en read.table y es a propósito.

# En el caso de la data.frame ej1, es posible exportarla siguiendo las 
# convenciones de los csv en español (o europea) con:
write.csv2(ej1, file = 'ej1.csv')
# (un poco más abajo veremos más sobre la exportación de data.frames).

# La que a su vez se puede importar con:
read.csv2('ej1.csv', row.names = 1)
# El argumento row.names es necesario aquí, ya que de otra forma se arega una 
# nueva columna a la data.frame. La razón de este comportamiento no es clara 
# (ver: [1])

# De manera similar a cómo funcionan read.csv y read.csv2, las funciones 
# read.delim y read.delim2 sirven para importar archivos de texto, pero en 
# este caso con variables separadas por tabulaciones ('\t'), usando puntos y 
# comas respectivamente para indicar decimales.


# Importar datos en RStudio

# En RStudio, en el área de trabajo (cuadrante "Workspace") existe el botón
# "Import Dataset", que ofrece las opciones de importar datos desde un archivo
# de texto o desde una URL.  Podemos cargar el mismo archivo "ejemplo.txt"
# utilizando esta opción, pero tal vez tengamos que corregir los títulos de
# las filas posteriormente, elejir si queremos encabezar (header) y como vamos
# a separar los caracteres y decimales. Un menú emergente permite ajustar 
# estos argumentos, aunque a veces hay detalles que no se pueden ajustar (como 
# el número de líneas a saltear del archivo, argumento 'skip').


## Exportar desde R

# De la misma manera que importamos datos desde hojas de cálculo, nos interesa
# también exportar datos en formatos que puedan ser levantados desde las mismas,
# ya sea como resultados de análisis o para visualizar y editar matrices
# de datos. La función en este caso es 'write.table'. Utilizando el mismo
# ejemplo:
write.table(ejemplo1, file = "ejemplo3.txt", sep = "\t", eol = "\n", dec = ".", 
            row.names = TRUE, col.names = TRUE)

# El primer argumento es el nombre del objeto que queremos guardar, VA SIN
# COMILLAS. Observe que el archivo exportado será guardado en la carpeta de 
# directorio en donde ud. se encuentra trabajando actualmente, a menos que 
# utilice un camino absoluto o relativo adecuado.
# file: es el archivo que queremos crear, en este caso SI VA CON COMILLAS y la 
#   extensión debe ser incluida. Nótese que dicha extensión no afecta a las 
#   opciones de sep, eol, dec ni ningún otro argumento.
# sep: es lo mismo que para 'read.table'.
# eol: es un caracter especial que indica
#   el final de línea (nota: también se utiliza con la función cat). Suele ser 
#   importante cuando trabajamos con varias computadoras con diferentes sistemas 
#   operativos, como pueden ser Windows y aquellos basados en Unix.
# dec: idem que para 'read.table'.
# row.names: es una opción lógica que indica si los nombres de las filas se 
#   escriben en el archivo exportado.
# col.names: opción lógica o vector con nombres de columnas. En el primer caso 
#   se guardan en el archivo los nombres de las columnas del archivo, mientras 
#   que el segundo simplemente asigna los nombres dados por el usuario en el 
#   momento de exportar.

# Este comando produce un archivo de texto plano, o coloca la información
# en el portapapeles (usando file = "clipboard") para pegarlo en una hoja de 
# cálculo, o incluso en otra sesión de R si así lo deseamos.

# Para más información a cerca de la función, consulte la ayuda de R:
?write.table


## Resumen

# El importar datos en R es el primer paso en general para poder realizar nuestros
# análsis. Por lo tanto, es importante comprender como estos son ingresados y
# como el R los reconoce, de lo contrario nos puede no solo traer errores que
# nos impidan realizar los análsis sino también obtener resultados erróneos.

# En general el importar y exportar datos se hace necesario cuando trabajamos 
# con varios programas. Sin embargo, en caso de trabajar únicamente con R, lo 
# más recomendable es utilizar los archivos nativos de datos de R (.RData o 
# .rda), los cuales se guardan con save y se cargan con load.


# Nota extra:

# El paquete "foreign" incluye funciones para compatibilizar el formato
# de otros paquetes estadísticos y bases de datos (e.g. S, SAS, SPSS, Stata,
# dBase) para importar y exportar datos desde R.


# [1]: Pregunta en Stack Overflow, respecto a los detalles de read.csv y write.csv:
browseURL('http://stackoverflow.com/questions/12512062/why-write-csv-and-read-csv-are-not-consistent')

