
echo '/^\\\\documentclass/a \\\\\'$(cat ../hifenacion.tex) > /tmp/sedscript

wait

sed -f /tmp/sedscript INSTRUCCIONES.tex > /tmp/instr.tex

wait

cp /tmp/instr.tex INSTRUCCIONES.tex

wait

rm /tmp/sedscript /tmp/instr.tex



