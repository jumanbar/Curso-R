#### Uso de Paquetes en R
 
## Al instalar R de novo ya vienen existen una serie de paquetes estándar, los cuales tienen una gran cantidad de
## funcionalidades. La lista completa es (del manual, sección FAQ):
# base
#   Base R functions (and datasets before R 2.0.0). 
# datasets
#   Base R datasets (added in R 2.0.0). 
# grDevices
#   Graphics devices for base and grid graphics (added in R 2.0.0). 
# graphics
#   R functions for base graphics. 
# grid
#   A rewrite of the graphics layout capabilities, plus some support for interaction. 
# methods
#   Formally defined methods and classes for R objects, plus other programming tools, as described in the Green Book. 
# splines
#   Regression spline functions and classes. 
# stats
#   R statistical functions. 
# stats4
#   Statistical functions using S4 classes. 
# tcltk
#   Interface and language bindings to Tcl/Tk GUI elements. 
# tools
#   Tools for package development and administration. 
# utils
#   R utility functions.
 
## Para instalar nuevos paquetes hay varias formas... en RStudio existen botones para esto (panel 4, abajo a la
## derecha, bajo la pestaña "tools"). Desde la consola de R se puede usar el comando "install.packages".
 
## Por ejemplo, si me interea instalar el paquete corrgram (para graficar correlogramas), escribo:
install.packages("corrgram") ## Atención a las comillas, mayúsculas y minúsculas en el nombre del paquete.
 
## Esto instala en el disco duro el paquete. Además es posible que instale otros paquetes, en caso de que el
## que queremos instalar los requiera para funcionar (dependencias).
 
## Para que el paquete sea incluido en una sesión de R, hay que usar library:
library(corrgram)
 
## Esto carga el paquete en la sesión actual. Cada vez que se inicie una sesión nueva deberán ejecutar este
## comando para agregar los paquetes necesarios. La función require hace lo mismo pero es un condicional: si no
## se puede cargar el paquete pedido se imprime un aviso de alerta.
require(corrgram)
 
## En RStudio también se puede cargar un paquete en la misma pestaña mencionada anteriormente.
