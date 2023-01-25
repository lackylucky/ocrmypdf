# syntax=docker/dockerfile:1
FROM alpine:latest
MAINTAINER lackylucky

#Variables
ENV INTERVAL 5
ENV LANG ENG
ENV INPUT /
ENV OUTPUT /
ENV MAXSIZE 5240

#Run Updates
RUN apk update

#Install pakages
RUN apk add --no-cache \
    cron \
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

CMD /bin/sh install_lang-cron.sh
CMD cron
