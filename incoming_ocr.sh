#!/bin/bash
source=/input/
output=/output/
maximumsize=5240
echo "Wait for File"
inotifywait -m -e create -e moved_to --format "%f" $source \
        | while read FILENAME
                do
                        echo "New File detected"
                        ocrtime=$(date +%Y%m%d-%H%M%S)
                        if [ "${FILENAME: -4}" == ".pdf" ]; then
                                echo "New file is a pdf"
                                actualsize=$(du -k "$f" | cut -f 1)
                                if [ $actualsize -ge $maximumsize ]; then
                                        echo size is over $maximumsize kilobytes, no ocr
                                        mv $FILENAME $output/$ocrtime'_'$FILENAME
                                else
                                        echo "OCR the new file"
                                        ocrmypdf $source/$FILENAME $output/$ocrtime'_'$FILENAME
                                        rm $source/$FILENAME
                                fi
                        else
                                echo "New file is not a pdf, no ocr"
                                mv mv $FILENAME $output/$ocrtime'_'$FILENAME
                        fi
                  done
