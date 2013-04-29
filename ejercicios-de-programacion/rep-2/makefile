
all: rep-2.zip

clean: INSTRUCCIONES.Rmd datos.R
	rm -rf rep-2.zip *~ *.swp *.swo

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

rep-2.zip: INSTRUCCIONES.pdf datos.R
	R --vanilla --slave < datos.R
	wait
	zip -r rep-2.zip rep-2


