# Instrucciones: utilizar la función apply y la función est para transformar 
# (normalizar) los datos de la data.frame usa3. No es necesario haber 
# completado el ejercicio 1.d (función est) para hacer esta parte. Las 
# siguientes líneas sirven para cargar una función est alternativa en estos 
# casos:

if (!exists('est')) {
  load('est.rda')
}

# Objetos:
# datosNumericos: matriz o data.frame con las columnas de usa3 de clase 
#   numeric. Nótese que si usted ha completado los ejercicios anteriores, no 
#   todas las variables de dicho objeto son de esta clase.
# datosTrans*: variables numéricas de usa3 transformadas con la función est. 
#   Este objeto, como se indica abajo, *debe ser creado con la función apply*. 
#   Es importante notar que debido al modo de funcionamiento de apply, 
#   datosTrans deberá ser un objeto de clase "matrix".
# usaNorm*: data.frame basada en el usa3, cuyas variables numéricas están 
#   estandarizadas por la función est. Nótese que debe ser un objeto de clase 
#   data.frame, debe contener los mismos nombres (y en el mismo orden) de filas 
#   y columnas que el objeto inicial, así como las variables no numéricas.

# Nota: en la evaluación automatizada se utilizan valores aleatorios para 
# determinar si el código es correcto.
#===== Su código comienza aquí: =====#

datosNumericos <- usa3[, -c(1, 10)]
datosTrans <- apply(datosNumericos, 2, est)
datosTrans <- as.data.frame(datosTrans)
usaNorm <- cbind(Abrev = usa3$Abrev, datosTrans, Division = usa3$Division)

#====== Aquí finaliza su código =====#
