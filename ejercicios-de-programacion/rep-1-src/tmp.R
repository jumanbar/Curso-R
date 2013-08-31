require(knitr)
knit("nuevo.Rmd"); system("pandoc -o nuevo.tex -s nuevo.md; wait; pdflatex nuevo.tex")

