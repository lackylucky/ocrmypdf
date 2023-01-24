#!/bin/bash
source=/input
target=/output

if [ $LANG != "engl" ]; then
        Echo Install $LANG
        apk add --no-cache tesseract-ocr-data-$LANG
fi

inotifywait -r -m "$source/$INPUT" -e CREATE,MOVED_TO | while read path action file
do      
        cd $source/$INPUT
        echo "The file '$file' appeared in directory '$path' via '$action'"
        ocrtime=$(date +%Y%m%d-%H%M%S)
        if [ "${file: -4}" == ".pdf" ]; then
                echo File $file is a pdf
                actualsize=$(du -k "$file" | cut -f 1)
                if [ $actualsize -ge $MAXSIZE ]; then
                        echo $file is $actualsize kilobytes and over the maximum of $MAXSIZE kilobytes, sorry no ocr
                        mv $file $target/$OUTPUT/$ocrtime'_'$file
                else
                        echo $file is $actualsize kilobytes, lets OCR
                        ocrmypdf -d -c -l $LANG $source/$INPUT/$file $target/$OUTPUT/$ocrtime'_'$file
                        echo "OCR done, remove file '$file' in '$path'"
                        rm $source/$INPUT/$file
                        echo "file removed"
                fi
        else
                echo File $file is not a pdf, no ocr
                mv $file $target/$OUTPUT/$ocrtime'_'$file
                echo "File moved to $target/$OUTPUT"
        fi
done
