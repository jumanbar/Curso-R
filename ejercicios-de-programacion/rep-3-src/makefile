NREP=3

all: rep-$(NREP).zip

clean: INSTRUCCIONES.Rmd datos.R make-aux.R
	rm -rf rep-$(NREP).zip *~ *.swp *.swo

INSTRUCCIONES.pdf: INSTRUCCIONES.Rmd
	R --vanilla --slave < make.R
	wait
	pandoc -o INSTRUCCIONES.tex -s INSTRUCCIONES.md
	wait
	sh hifenar.sh
	wait
	pdflatex INSTRUCCIONES.tex
	wait
	rm -f NA
	wait
	rm -rf figure

rep-$(NREP).zip: INSTRUCCIONES.pdf datos.R make-aux.R
	R --vanilla --slave < datos.R
	wait
	zip -r rep-$(NREP).zip rep-$(NREP)


