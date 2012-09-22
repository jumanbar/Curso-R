# ---------------------------------------------------------#
plot(iris)

pairs(iris, panel = panel.smooth)

# ---------------------------------------------------------#

# gráfico de dispersión para dos variables, condicionales de 
# una tercer variable
coplot(Sepal.Length ~ Sepal.Width | Species, data=iris)
coplot(lat ~ long | depth, data = quakes)
co.intervals(quakes$depth)

# ---------------------------------------------------------#

boxplot(Sepal.Width ~ Species, data=iris)
plot(weight ~ group, PlantGrowth)

# ---------------------------------------------------------#

hist(iris$Sepal.Length)
hist(iris$Sepal.Length, breaks = 15, freq=F)
lines(density(iris$Sepal.Length))

# ---------------------------------------------------------#
