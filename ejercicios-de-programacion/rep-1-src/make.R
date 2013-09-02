require(knitr)
knit("letra.Rmd", encoding = "UTF-8")
# system("pandoc -o letra.tex -s letra.md; wait; pdflatex letra.tex")

# knit("nuevo.Rmd", encoding = "UTF-8")
# system("pandoc -o nuevo.tex -s nuevo.md; wait; pdflatex nuevo.tex")

