soma=$(cut -d',' -f2 compras.txt | grep -Eo '[0-9]+' | paste -sd+ | bc)
echo $soma > soma.txt

loja=$(sort -t',' -k2 -nr compras.txt | head -n1 | cut -d',' -f3)
echo $loja > loja.txt
