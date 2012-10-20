# Instrucciones: exportar la data.frame usaNorm al archivo "usa-norm.csv" 
# siguiendo los criterios indicados en la letra del repartido. El código 
# generado aquí debe partir de una data.frame llamada 'usaNorm' y debe 
# terminar exportando el archivo de texto plano con el nombre indicado y en la 
# carpeta del repartido ('rep-3').

# Nota: en la evaluación automatizada se utilizan valores aleatorios para 
# determinar si el código es correcto.
#===== Su código comienza aquí: =====#


write.table(usaNorm, file = "usa-norm.csv", sep = ";", eol = "\n", dec = ",", row.names = TRUE, col.names = TRUE)

#====== Aquí finaliza su código =====#

