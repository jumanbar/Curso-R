pandoc -o INSTRUCCIONES.tex -s INSTRUCCIONES.md
wait
pdflatex INSTRUCCIONES.tex
wait
R --vanilla --slave < datos.R &
