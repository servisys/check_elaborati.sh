#!/bin/bash
# Script to find probability of differences between txt file
# useful to theck students homework or test :)
# Author: Matteo Temporini v1.0

for f in `find elaborati/*`
do
        for g in `find elaborati/*`
        do
                if [[ "$f" != "$g" ]]
                then
                        righe1=$(wc -l $f | awk '{print $1}')
                        righe2=$(wc -l $g | awk '{print $1}')
                        echo "Confronto $f ($righe1) e $g ($righe2)"
                        modifiche=$(diff -u -r $f $g | diffstat -m | grep "|" | awk '{print $3}')
                        if [[ ! -z "$modifiche" ]]
                        then
                                echo "Modifiche: $modifiche"
                                perc1=$(printf %.2f%%  "$((10**3 * 100 * $modifiche/$righe1))e-3")
                                perc2=$(printf %.2f%%  "$((10**3 * 100 * $modifiche/$righe2))e-3")
                                echo "Probabilità che i file siano diversi: $perc1"
                        else
                                echo -e "\e[31mI due file sono IDENTICI\e[0m"
                        fi
                fi
        done
done
