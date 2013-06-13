# EXTRA
# RStudio viene con la función manipulate, que sirve para hacer gráficos
# más interactivos. Es necesario cargar el paquete homónimo primero...
library(manipulate)
?manipulate
 
# Trabaja con tres funciones llamadas "slider", "picker" y "checkbox"
# que sirven para variables continuas, listas de opciones y cajas de chequeo
manipulate(
	curve(sin(a * x) * x, from=-5, to=5),
 	a = slider(1, 15)
)
 
# Para ver cómo funcionan:
?slider
?picker
?checkbox
 
# Si me interesa puedo agregar otro parámetro para manipular,
# se agrega con comas.
manipulate(
	curve(sin(a * x) * x, from=-5, to=5, n=b), # Atención a las comas y
 	a = slider(1, 30),                         # paréntesis
 	b = slider(101, 3001) # Acá no va coma...
)
 
# Ejemplo con picker
manipulate(
	curve(dnorm(x, sd=a), from=-20, to=20, col=b),
 	a = slider(1, 10),
 	b = picker(2, 3, 'blue')
)
 
# Ejemplo con checkbox
x <- rnorm(1e4)
manipulate(
	hist(x, breaks=a, freq=b),
 	a = slider(10, 100),
 	b = checkbox(FALSE)
)
