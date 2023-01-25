#!/bin/bash
language="$(echo $LANG | tr [:upper:] [:lower:])"

#Install Language
echo Language $language is selected
if [[ "${language}" == "eng" ]]; then
		echo Language $language already installed
else
	echo Install $language
        apk add --no-cache tesseract-ocr-data-$language
fi