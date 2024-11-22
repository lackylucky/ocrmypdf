# ocrmypdf
Docker Container to run OCRmyPDF on all PDFs.
The image based on the latest Alpine-Linux.
A cronjob run to scan for new files. Unfortently it isn't possible monitor the folder with inotify. Inotify doesn't work with smb-shares.


## Volume
/input/ will be scaned for new PDFs.<br/>
/output/ ist the target for the PDFs after the ocr

## Variables
|Variable|Description|Default|
|---|---|---|
|INTERVAL|Interval in minutes to scan for new files in the Input Folder|5|
|LANGUAGE|Language for the ocr enginde. You can use every languagecode from the list at https://tesseract-ocr.github.io/tessdoc/Data-Files-in-different-versions.html|ENG|
|INPUT|Path to a subfolder insiede of the mounted /input/ volume|/|
|OUTPUT|Path to a subfolder inside of the mounted /output/ volume |/|
|MAXSIZE|Maximum size (kB) of PDF's. If the size over the maximum, the script move the file without ocr.|5240|
