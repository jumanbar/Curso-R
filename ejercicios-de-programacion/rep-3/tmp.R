usa <- read.table('usa.csv', header = TRUE, row.names = 1)
names (usa) <- c ("Abrev", "Poblacion", "Ingresos", "Analf", "Esp.Vida", "Homicidio", "Sec.Grad",
"Heladas", "Area", "Division")
levels(usa$Division) <- c("Noreste Central", "Sudeste Central", "Atlantico Central", "Montania",
"Nueva Inglaterra", "Pacifico", "Atlantico Sur", "Noroeste Central",
"Sudoeste Central")

