
all: rep-1.zip

clean: INSTRUCCIONES.Rmd datos.R
	rm -rf rep-1.zip *~ *.swp *.swo

INSTRUCCIONES.pdf: INSTRUCCIONES.Rmd
	R --vanilla --slave < make.R
	pandoc -o INSTRUCCIONES.tex -s INSTRUCCIONES.md
	wait
	pdflatex INSTRUCCIONES.tex
	wait
	rm -f NA

rep-1.zip: INSTRUCCIONES.pdf datos.R
	R --vanilla --slave < datos.R
	wait
	zip -r rep-1.zip rep-1


