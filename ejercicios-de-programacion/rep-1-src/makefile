
all: rep-?.zip

clean: letra.Rmd datos.R
	rm -rf rep-?.zip *~ *.swp *.swo .RData .Rhistory

letra.pdf: letra.Rmd
	R --vanilla --slave < make.R
	wait
	pandoc -o letra.tex -s letra.md
	wait
	pdflatex letra.tex
	wait
	rm -f NA
	wait
	rm -rf figure

rep-1.zip: letra.pdf datos.R
	R --vanilla --slave < datos.R
	wait
	zip -r rep-?.zip rep-?


