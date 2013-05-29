
# ejercicio: anova
# age: vector aleatorio compuesto por numeros enteros positivos entre 18 y 35 aprox. (este rango puede tener cierta 
# exibilidad). Nota: debe ser generado con una funcion creadora de valores aleatorios, y se deben
# permitir ocurrencias repetidas del mismo valor.
# magic: data.frame previamente importado. En este caso debe además agregar la variable age al data.frame.
# sex: variable del data.frame magic que debe ser transformada a factor
# peso.sexo: resultado del anova con la variable de respuesta peso y la variable explicativa
# sexo
# peso.hombre: objeto creado a pertir de los valores esperados para el sexo hombre, según los resultados del modelo peso.sexo
# peso.mujer: objeto creado a pertir de los valores esperados para el sexo hombre, según los resultados del modelo peso.sexo
# ====== Aqui comienza su código ======

age <-0

magic <-0

sex <-0

peso.sexo <-0

peso.hombre <-0

peso.mujer <- 0

# ====== Aqui finaliza su código ======
# 
# ejercicio: regresion
# 
# altura.peso <- regresion lineal entre las variables altura ^ 2 ~ peso sin
# intercepto. 
# altura.peso2: regresion lineal entre las variables altura ^ 2 ~ peso sin
# intercepto, pero esta vez excluyendo a los outliers de peso (es decir, aquellos
# tales que peso > 120 Kg).
# ae: utilizando los coecientes obtenidos del modelo altura.peso2, determine la
# altura esperada para la secuencia de pesos: p <- seq(40, 120, by = 0.5)
# r2: valor del R cuadrado (no ajustado) del modelo altura.peso2
# IMC <- agregar el indice correspondiente a cada participante, calculado como: IMC = Peso(Kg) / Altura ^ 2(m)
# al data.frame magic
# 
# ====== Aqui comienza su código ======

altura.peso <-0

altura.peso2 <-0

ae <-0

r2 <-0

IMC <-0

magic <-0


# ====== Aqui finaliza su código ======
# 
# 
# ejercicio: graficos
# 
# boxplot_1: diagrama de cajas del peso en funcion de sexo. Debe tener las etiquetas "Sexo", "Peso (Kg)" en los ejes correspondientes, asi como el titulo: "Peso en funcion del sexo".
# 
# regresion_2: gráfica de dispersión del modelo de regresión simple de las variables altura ^ 2 en funcion del peso.
# 
# linea_modelo: linea de regresión correspondiente al gráfico regresion_2
# 
# linea_verical: linea vertical indicando el valor 120 en el eje del peso; utilice
# un estilo de linea diferente al anterior (con color y/o trazo diferente).
# 
# outliers: puntos de los outliers agregados al gráfico regresion_2 junto también con las lineas, utilizando
# un simbolo diferente (y opcionalmente, un color distinto).
# 
# 
# ====== Aqui comienza su código ======

boxplot_1 <-0

regresion_2 <-0

linea_modelo <-0

linea_verical <-0

outliers <-0

# ====== Aqui finaliza su código ======



# Ideas tomadas de lm para sacar ciertos valores...
a <- parsed[grep("plot", arch)]
mf <- match.call(lm, call = a)
#   m <- match(c("formula", "data", "subset", "xlim", "ylim", "col"), names(mf))
m <- match(c("formula", "data", "subset"), names(mf))
mf <- mf[c(1L, m)]
mf[[1L]] <- as.name("model.frame")
mf <- eval(mf, parent.frame())




