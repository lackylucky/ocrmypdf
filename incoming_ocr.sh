#!/bin/bash
source=/input
target=/output
language="$(echo $LANG | tr [:upper:] [:lower:])"

#Check for files
cd $source/$INPUT
for f in *; do
        if [ -f "$f" ]; then
                echo "The file '$f' appeared in directory '$source/$INPUT'"
                ocrtime=$(date +%Y%m%d-%H%M%S)
                if [ "${f: -4}" == ".pdf" ]; then
                        echo File $f is a pdf
                        actualsize=$(du -k "$f" | cut -f 1)
                        if [[ $actualsize -ge $MAXSIZE ]]; then
                                echo $f is $actualsize kilobytes and over the maximum of $MAXSIZE kilobytes, sorry no ocr
                                mv $f $target/$OUTPUT/$ocrtime'_'$f
                        else
                               echo $f is $actualsize kilobytes, lets OCR
                                ocrmypdf -d -c -l $language --rotate-pages $source/$INPUT/$f $target/$OUTPUT/$ocrtime'_'$f && echo "OCR finished, remove file '$f' in '$source/$INPUT'" && rm $source/$INPUT/$f
                              echo "file removed"
                        fi
                else
                      echo File $f is not a pdf, no ocr
                     mv $f $target/$OUTPUT/$ocrtime'_'$f
                       echo "File moved to $target/$OUTPUT"
                fi
        fi
done

