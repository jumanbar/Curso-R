##########################################################
## Algunas funciones útiles para administrar la sesión de R. 

# Al enfrentarnos a la interfaz de R, ésta nos va a parecer un poco dura en
# principio. Una de las principales dificultades para el principiante es no 
# saber qué objetos tiene en el área de trabajo, o cómo administrar estos
# objetos. En esta sección vamos a aprender algunos comandos que nos van a ser
# muy útiles para trabajar en la interfase de usuario de R, así como también en
# interfases más amigables como la de RStudio (aunque en este caso el área de
# trabajo tiene su propia pestaña, donde se despliegan los objetos actuales).
# Algunas de las funciones básicas útiles para la administración de objetos en
# R son las siguientes:

ls()         # Lista de objetos actual de la sesión
rm(x, y)     # Borra los objetos x e y
q()          # Salir de R
dir()        # Mirar lo que hay en el directorio de trabajo (ver más abajo)
exists("x")  # ¿Existe el objeto "x" en mi sesion? (debe ir con comillas).

# Un concepto a retener es el de "directorio de trabajo": R siempre está
# trabajando en un directorio (una carpeta) del disco duro. En Windows la
# carpeta por defecto es "Mis Documentos", en GNU/Linux es la carpeta home
# del usuario, por ejemplo "/home/usuario". Cuando se importan o exportan
# archivos el R usa el camino (path) relativo de cada archivo respecto al
# directorio de trabajo del momento.

getwd()  # Ver cuál es el directorio de trabajo
setwd()  # Cambiar el directorio de trabajo

# Por ejemplo, usando la función "writeLines" podemos crear un archivo de
# texto plano en el disco duro, que por defecto va a ser guardado en el
# directorio de trabajo, obtenido por getwd():

writeLines("La respuesta es 42", con="enigma.txt")
dir(pattern="eni")

# Nota: en R las rutas de los archivos se deben escribir con "/" (slash)
# y no con "\" (backslash, usado por Windows).

# Estas funciones son las básicas para administrar los objetos que tenemos en 
# el área de trabajo, así como también para trabajar con archivos desde R. Su
# utilidad se va a ir haciendo más evidente a medida que vayamos avanzando en
# el curso.
