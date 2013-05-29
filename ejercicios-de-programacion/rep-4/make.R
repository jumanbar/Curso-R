source("datos.R", encoding = "UTF-8")

require(knitr)

knit("INSTRUCCIONES.Rmd", encoding = "UTF-8")

system("pandoc -o INSTRUCCIONES.tex -s INSTRUCCIONES.md")

inst <- readLines("INSTRUCCIONES.tex", encoding = "UTF-8")
hyph <- readLines("../hifenacion.tex", encoding = "UTF-8")
hyph <- gsub("\\\\hyph", "\\hyph", hyph)
inst <- c(inst[1], hyph, inst[-1])
writeLines(inst, "INSTRUCCIONES.tex", useBytes = TRUE)

system("pdflatex INSTRUCCIONES.tex")

cat("\nSÓLO QUEDA HACER EL rep-x.zip!!!!\n\n")
