# Rep. V - ej. 3.a

# Instrucciones: 
# Arreglar la función cambia.pares para que ejecute correctamente
# sus cometidos. Hay 4 errores para corregir.

# Argumentos:
# - x: vector numérico o character
# - subs: valores a usar para sustituir los valores de x en las
#         posiciones pares.

# Salida:
# Un vector numérico o character con los valores de x en las
# posiciones impares y los de subs en las pares.

#===== Su código comienza aquí: =====#

cambia.pares <- functon(x, subs=0) {
  # Cambia los valores originales de "x" por los valores
  # de "subs" en las posiciones pares.
  out <- x
  len <- length(x)
  pares <- seq(1, len, by=2)
  out[pares,] <- sub
  return(out)
}

#===== Su código termina aquí =======#

