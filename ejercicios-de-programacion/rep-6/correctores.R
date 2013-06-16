
out <- numeric(nrow(datos))
for (i in 1:nrow(datos)) {
  out[i] <- sum(is.na(datos[i, ]))
}

# Solución alternativa:
apply(datos, 1, function(x) sum(is.na(x)))
