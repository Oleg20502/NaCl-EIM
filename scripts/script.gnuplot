#!/usr/bin/gnuplot
set terminal png size 1000,1000
set output "png/rdf_YYYYTEMP.png"



set title "RDF for NaCl. T = YYYYTEMP K"
set xlabel "R"
set ylabel "RDF"
set grid

plot "rdf/tmp_YYYYTEMP.rdf" u 2:3 w l lw 4

###plot for [blockId=0:4] "YYYYTEMP_formated.rdf" i blockId u 2:3 w l lw 4 lc palette frac 0.1*blockId t "Time: ".blockId
