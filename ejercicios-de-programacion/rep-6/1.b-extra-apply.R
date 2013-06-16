# Rep. VI - ej. 1.b

# Instrucciones: 


#===== Su código comienza aquí: =====#

f <- 0   # f debe ser una función

out <- 0 # Aquí debe usar la función apply

# Solución ...
apply(datos, 1, function(x) sum(is.na(x)))


#===== Su código termina aquí =======#

