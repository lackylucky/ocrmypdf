# syntax=docker/dockerfile:1
FROM alpine:latest
COPY incoming_ocr.sh /app
RUN apk update
RUN apk upgrade --available
RUN apk --no-cache add tesseract-ocr 
RUN apk --no-cache add inotify-tools
RUN apk --no-cache add ocrmypdf
RUN mkdir /input
RUN mkdri /output
RUN chmod u+x /app/incoming_ocr.sh
CMD bash /app/incoming_ocr.sh
