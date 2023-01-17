#!/bin/bash
source=/input/
output=/output/
maximumsize=5240

inotifywait -r -m "$source" --format '%w%f' -e CREATE,MOVED_TO | while read path action file
do      
        cd $source
        echo "The file '$file' appeared in directory '$path' via '$action'"
        ocrtime=$(date +%Y%m%d-%H%M%S)
        if [ "${file: -4}" == ".pdf" ]; then
                echo File $file is a pdf
                actualsize=$(du -k "$file" | cut -f 1)
                if [ $actualsize -ge $maximumsize ]; then
                        echo $file is $actualsize kilobytes and over the maximum of $maximumsize kilobytes, sorry no ocr
                        mv $file $output/$ocrtime'_'$file
                else
                        echo $file is $actualsize kilobytes, lets OCR
                        ocrmypdf $source/$file $output/$ocrtime'_'$file
                        rm $source/$file
                fi
        else
                echo File $file is not a pdf, no ocr
                mv mv $file $output/$ocrtime'_'$file
        fi
done
