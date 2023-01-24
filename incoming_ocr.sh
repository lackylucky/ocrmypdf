#!/bin/bash
source=/input
target=/output
language="$(echo $LANG | tr [:upper:] [:lower:])"
#Install Language
echo Language $language is selected
if [[ "${language}" == "eng" ]]; then
		echo Language $language already installed
else
	echo Install $language
        apk add --no-cache tesseract-ocr-data-$language
fi
#Check for new files
inotifywait -r -m "$source/$INPUT" -e CREATE,MOVED_TO | while read path action file
do
        cd $source/$INPUT
        echo "The file '$file' appeared in directory '$path' via '$action'"
        ocrtime=$(date +%Y%m%d-%H%M%S)
        if [ "${file: -4}" == ".pdf" ]; then
                echo File $file is a pdf
                actualsize=$(du -k "$file" | cut -f 1)
                if [[ $actualsize -ge $MAXSIZE ]]; then
                        echo $file is $actualsize kilobytes and over the maximum of $MAXSIZE kilobytes, sorry no ocr
                        mv $file $target/$OUTPUT/$ocrtime'_'$file
                else
                        echo $file is $actualsize kilobytes, lets OCR
                        ocrmypdf -d -c -l $language $source/$INPUT/$file $target/$OUTPUT/$ocrtime'_'$file
                        echo "OCR finished, remove file '$file' in '$path'"
                        rm $source/$INPUT/$file
                        echo "file removed"
                fi
        else
                echo File $file is not a pdf, no ocr
                mv $file $target/$OUTPUT/$ocrtime'_'$file
                echo "File moved to $target/$OUTPUT"
        fi
done

