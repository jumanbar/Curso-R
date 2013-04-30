
all: rep-?.zip

clean: INSTRUCCIONES.Rmd datos.R
	rm -rf rep-?.zip *~ *.swp *.swo .RData .Rhistory

INSTRUCCIONES.pdf: INSTRUCCIONES.Rmd
	R --vanilla --slave < make.R
	wait
	pandoc -o INSTRUCCIONES.tex -s INSTRUCCIONES.md
	wait
	pdflatex INSTRUCCIONES.tex
	wait
	rm -f NA
	wait
	rm -rf figure

rep-1.zip: INSTRUCCIONES.pdf datos.R
	R --vanilla --slave < datos.R
	wait
	zip -r rep-?.zip rep-?


