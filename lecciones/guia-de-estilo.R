## Reglas de estilo en R
 
# Hemos visto que en R la estructura no es demasiado exigente en cuanto a 
# la organización de los scripts o de reglas nomenclaturales, siempre que se
# respeten las básicas del lenguaje. Existen sin embargo una serie de 
# reglas formales de estilo, creadas para facilitar la comunicación entre
# desarrolladores, como forma de poder identificar fácilmente los elementos
# en las funciones, pero que a su vez, facilitan mucho la interpretación de
# los programas propios, si se aplican regularmente.

# En este caso vamos a mostar las reglas que utilizan los empleados de la
# empresa google para trabajar con scripts de R. Notarán que en nuestro curso
# seguimos la mayoría de ellas, si bien no todas. Lo importante, más allá de
# seguir una u otra regla, es mantener una coherencia en el estilo de cada
# uno, o el del equipo de trabajo.
 
## Notación y nombres
 
# Nombres de archivo
 
# Los nombres de archivo en R llevan la extensión '.R'. Siempre.
# Es importante que además tengan sentido.
# INCORRECTO: coso.R
# CORRECTO: datos_muestreo_2005.R

# Identificadores

# No usar guión bajo (_) ni común (-) en identificadores.
# Las variables se escriben en minúscula y las palabras se separan mediante 
# puntos(.).
# Los nombres de funciones inician en mayúscula y sin puntos.
# Las constantes se nombran como las funciones pero iniciando con una 'k'.
# Ejemplos:
 
# Variables
# INCORRECTO: avg_Clicks, avgClicks
# CORRECTO: avg.clicks
 
# Funciones
# INCORRECTO: calculate_avg_clicks, calculateAvgClicks
# CORRECTO: CalculateAvgClicks
 
# Constantes:
# CORRECTO: kNombreDeConstante
 
## Sintaxis
 
# Longitud de la línea
 
# La longitud de línea máxima son 80 caracteres (a veces es difícil...)
 
# Indentación
 
# Cuando introducimos un condicional o función en varias líneas y necesitamos 
# indentar lo que va dentro, usar dos espacios, no tabulaciones, ni mezclar 
# tabulaciones con espacios.
# La excepción es cuando cerramos un paréntesis en la siguiente línea, donde
# la indentación va a la altura en que se abrió el paréntesis en la línea
# anterior. Ej:
# función(argumento1, argumento2,
#         argumento3, etc...)
 
# Espaciado
 
# Poner espacios alrededor de cada operador binario (=, +, -, <-, etc.)
# La excepción: es opcional poner espacios en torno a '=' al definir los
# argumentos para ejecutar una función.
# No se ponen espacios antes de una coma, pero siempre va uno después de ésta.
 
# INCORRECTO: 
tabPrior <- table(df[df$daysFromOpt<0, "campaignid"])
tabPrior <- table(df[df$daysFromOpt < 0,"campaignid"])
tabPrior<- table(df[df$daysFromOpt < 0, "campaignid"])
tabPrior<-table(df[df$daysFromOpt < 0, "campaignid"])
total <- sum(x[,1])
total <- sum(x[ ,1])
 
# CORRECTO:
tabPrior <- table(df[df$daysFromOpt < 0, "campaignid"])
total <- sum(x[, 1])
total <- sum(x[1, ])
 
# Usar espacios antes de abrir un paréntesis, excepto al llamar una función
 
# INCORRECTO:
if(debug)
# CORRECTO:
if (debug)
 
# Espacio extra están bien si sirven para alinear signos similares
 
plot(x    = xCoord,
     y    = dataMat[, makeColName(metric, ptiles[1], "roiOpt")],
     ylim = ylim,
     xlab = "dates",
     ylab = metric,
     main = (paste(metric, " for 3 samples ", sep="")))  
 
# No poner espacios entre paréntesis alrededor de código
# Excepción: siempre va espacio después de una coma
 
# INCORRECTO:
if ( debug )
x[1,]
 
# CORRECTO:
if (debug)
x[1, ]  
 
# Llaves
 
# Una llave de apertura nunca va en su propia línea. 
# Una llave de cierre siempre va en su propia línea.
# Se pueden omitir las llaves si hay una sola instrucción, sin embargo, se
# deben usar consistentemente, llaves o no, con instrucciones simples.
# NOTA: siempre iniciar un bloque de instrucciones en una línea nueva.
 
# INCORRECTO:
if (is.null(ylim)) ylim <- c(0, 0.06)
if (is.null(ylim)) {ylim <- c(0, 0.06)}
 
# CORRECTO:
if (is.null(ylim)) {
  ylim <- c(0, 0.06)
}
# ó
if (is.null(ylim))
  ylim <- c(0, 0.06)
 
# Asignación
 
# Usar '<-' para asignar, no '='.
 
# INCORRECTO:
x = 5
 
# CORRECTO:
x <- 5
 
# Punto y coma
 
# No usar punto y coma (;) para separar comandos o terminar líneas
 
## Organización
 
# Diseño general y orden
 
# Si todos usamos el mismo criterio de orden, es más fácil compartir, e inter-
# pretar el trabajo de los colegas. Algunos criterios para compartir funciones.
 
# 1- Comentarios acerca de derechos
# 2- Comentarios del autor
# 3- Comentarios sobre el archivo, incluyendo propósitos, entradas, salidas
# 4- Comentarios sobre datos y paquetes requeridos
# 5- Definición de las funciones
# 6- Comentarios acerca de la ejecución de prints o plots
 
# Ejemplos y tests deben ir en un archivo separado.
 
# Comentarios
 
# Es importante comentar lo que vamos escribiendo en los scripts, ya que nos
# puede pasar dejar algo a medio hacer un tiempo y luego tener que andar estu-
# diando todo el script para acordarse de qué era lo que hacía. O ni siquiera
# a medio hacer...
 
# Las líneas dedicadas a comentarios (como esta) deben empezar con un '#' y un
# espacio.
# Comentarios cortos se pueden colocar luego de los comandos, precedidos de 
# dos espacios, '#' y otro espacio.
 
# Definición de funciones y llamadas
 
# En las definiciones de funciones deben listarse primero los argumentos sin 
# valores por defecto, y luego aquellos que tienen valores por omisión.
# Tanto en la definición como en la llamada a funciones, se pueden utilizar
# varias líneas. Se pasa a la siguiente línea entre argumentos.
 
# INCORRECTO: 
PredictCTR <- function(query, property, numDays, showPlot =
                       TRUE)
 
# CORRECTO:
PredictCTR <- function(query, property, numDays,
                       showPlot = TRUE)
 
# Documentación de funciones
 
# Las funciones deben contener una sección de comentarios inmediatamente a
# continuación de la línea en que se definen. Esta consiste en una descripción
# en una frase de la función, una lista de los argumentos (Args) con una
# breve descripción de cada uno, y una descripción de la salida (Returns).
# Este comentario debe ser tan descriptivo que un usuario pueda utilizar la 
# función sin necesidad de leer el código.
 
# Función de Ejemplo:
 
CalculateSampleCovariance <- function(x, y, verbose = TRUE) {
  # Computes the sample covariance between two vectors.
  #
  # Args:
  #   x: One of two vectors whose sample covariance is to be calculated.
  #   y: The other vector. x and y must have the same length, greater than one,
  #      with no missing values.
  #   verbose: If TRUE, prints sample covariance; if not, not. Default is TRUE.
  #
  # Returns:
  #   The sample covariance between x and y.
  n <- length(x)
  # Error handling
  if (n <= 1 || n != length(y)) {
    stop("Arguments x and y have invalid lengths: ",
         length(x), " and ", length(y), ".")
  }
  if (TRUE %in% is.na(x) || TRUE %in% is.na(y)) {
    stop(" Arguments x and y must not have missing values.")
  }
  covariance <- var(x, y)
  if (verbose)
    cat("Covariance = ", round(covariance, 4), ".\n", sep = "")
  return(covariance)
}
 
## Finalizando
 
# Este documento es una traducción simplificada de 'Google's R Style Guide'
# (http://google-styleguide.googlecode.com/svn/trunk/google-r-style.html)
# Alguna documentación extra se puede encontrar en 'R Coding Conventions'
# (http://www.maths.lth.se/help/R/RCC/).
