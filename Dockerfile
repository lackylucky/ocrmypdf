# syntax=docker/dockerfile:1
FROM alpine:latest
MAINTAINER lackylucky
COPY ./incoming_ocr.sh /
RUN apk update
RUN apk upgrade --available
RUN apk --no-cache add tesseract-ocr 
RUN apk --no-cache add inotify-tools
RUN apk --no-cache add ocrmypdf
RUN mkdir /input
RUN mkdri /output
VOLUME /input
VOLUME /output
RUN chmod +x /incoming_ocr.sh
ENTRYPOINT ["/incoming_ocr.sh"]
