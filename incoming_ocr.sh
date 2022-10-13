#!/bin/bash
source=/input/
output=/output/
maximumsize=5240

for f in *; do
        echo $f
        ocrtime=$(date +%Y%m%d-%H%M%S)
        if [ "${f: -4}" == ".pdf" ]; then
                echo File $f is a pdf
                actualsize=$(du -k "$f" | cut -f 1)
                if [ $actualsize -ge $maximumsize ]; then
                        echo $f is $actualsize kilobytes and over the maximum of $maximumsize kilobytes, sorry no ocr
                        mv $f $output/$ocrtime'_'$f
                else
                        echo $f is $actualsize kilobytes, lets OCR
                        ocrmypdf $source/$f $output/$ocrtime'_'$f
                        rm $source/$f
                fi
        else
                echo File $f is not a pdf, no ocr
                mv mv $f $output/$ocrtime'_'$f
        fi
done
