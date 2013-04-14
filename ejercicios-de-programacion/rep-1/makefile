
all: rep-1.zip

clean: INSTRUCCIONES.md datos.R
	rm -rf rep-1.zip

INSTRUCCIONES.pdf: INSTRUCCIONES.md
	pandoc -o INSTRUCCIONES.tex -s INSTRUCCIONES.md
	wait
	pdflatex INSTRUCCIONES.tex
	wait
	rm -f NA

rep-1.zip: INSTRUCCIONES.pdf datos.R
	R --vanilla --slave < datos.R
	wait
	zip -r rep-1.zip rep-1 


