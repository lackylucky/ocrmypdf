
# syntax=docker/dockerfile:1
FROM alpine:latest
MAINTAINER lackylucky

#Variables
ENV LANG ENG
ENV INPUT /
ENV OUTPUT /
ENV MAXSIZE 5240

#Run Updates
RUN apk update

#Install pakages
RUN apk add --no-cache \
    tesseract-ocr \
    inotify-tools \
    imagemagick \
    parallel \
    ghostscript \
    qpdf \
    unpaper \
    ocrmypdf

#Make folder and volumes
RUN mkdir /input
RUN mkdir /output
VOLUME /input
VOLUME /output

WORKDIR /
COPY --chown=root:root ./incoming_ocr.sh /
RUN chmod a+x ./incoming_ocr.sh


CMD ["/bin/sh", "incoming_ocr.sh"]
