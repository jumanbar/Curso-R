# Rep. VI - ej. 2.a

# Instrucciones:
# Debe utilizar un loop while para determinar el valor de n mínimo tal que 
# 1 - Zn < epsilon. Tenga en cuenta que el script debe funcionar bien sin 
# importar el valor de epsilon que se elija (en la corrección automática 
# epsilon va a ser aleatorio).

# Deberá además colocar estas líneas en ubicaciones adecuadas del script,
# sin límite en la cantidad de veces que las puede usar:
n <- 1
Zn <- sum(1 / (2 ^ (1:n)))

# Objetivos:
# Utilizar el loop while No se permiten for, apply, ni similares.
# n*: número entero el cual debe aumentar de a 1 en cada iteración (tomando
#     los valores 1, 2, 3, 4, ...). Luego de correr el script, debe ser el 
#     valor exacto que cumple la condición antedicha.
# Zn*: enésimo valor de la serie tal como se la describe en la letra.

# Valor de epsilon (puede cambiarlo a placer):
epsilon <- 1e-6

#===== Su código comienza aquí: =====#

while (   ) {
  


  # Esto es para mostrar el progreso en la consola:
  cat("n =", n, "- Zn =", Zn, "\n")
}

#===== Su código termina aquí =======#

