#!/bin/bash
source=/input/
output=/output/
maximumsize=5240

inotifywait -r -m "$source" --format '%w%f' -e CREATE,MOVED_TO | while IFS= read -r item
do      
        cd $source
        echo $item
        ocrtime=$(date +%Y%m%d-%H%M%S)
        if [ "${item: -4}" == ".pdf" ]; then
                echo File $item is a pdf
                actualsize=$(du -k "$item" | cut -f 1)
                if [ $actualsize -ge $maximumsize ]; then
                        echo $item is $actualsize kilobytes and over the maximum of $maximumsize kilobytes, sorry no ocr
                        mv $item $output/$ocrtime'_'$item
                else
                        echo $item is $actualsize kilobytes, lets OCR
                        ocrmypdf $source/$item $output/$ocrtime'_'$item
                        rm $source/$item
                fi
        else
                echo File $item is not a pdf, no ocr
                mv mv $item $output/$ocrtime'_'$item
        fi
done
