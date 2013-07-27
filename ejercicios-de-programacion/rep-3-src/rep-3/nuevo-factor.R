# Rep. III - ej. 1.f

# Instrucciones: 
# Crear una nueva variable en la data.frame usa3 llamada 'Ing.Cat' de clase 
# factor, creada con la función cut, la cual debe tener 4 niveles/categorías. 
# Luego se usarán las funciones tapply y boxplot para analizar la relación 
# entre las categorías de ingresos y el analfabetismo. En particular, con 
# tapply se debe ejecutar la función summary sobre los datos de analfabetismo 
# en separando por categoría de ingresos, mientras que con boxplot se debe 
# producir un plot (y un objeto) que muestre esta misma relación en un formato 
# gráfico.

# Objetivos:

# usa3$Ing.Cat*: nueva columna; el factor creado según lo que indica la letra.
# salidaTapply*: la salida de aplicar tapply con summary a la variable "Analf" 
#                para los distintos niveles de "Ing.Cat".
# salidaBoxplot*: la salida de aplicar boxplot a la variable "Analf" para los 
#                 distintos niveles de "Ing.Cat".

# Nota: en la evaluación automatizada se utilizan valores aleatorios para 
# determinar si el código es correcto.

#===== Su código comienza aquí: =====#

usa3$Ing.Cat <- 0 # (factor) Esta será la nueva variable

salidaTapply <- 0 # (list) Salida de tapply

salidaBoxplot <- 0 # (list) Salida de boxplot

#====== Aquí finaliza su código =====#

