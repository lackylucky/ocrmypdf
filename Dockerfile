# syntax=docker/dockerfile:1
FROM alpine:latest
MAINTAINER lackylucky

#Variables
ENV INTERVAL 5
ENV LANGUAGE ENG
ENV INPUT /
ENV OUTPUT /
ENV MAXSIZE 5240

#Run Updates
RUN apk update

#Install pakages
RUN apk add --no-cache \
    ghostscript \
    jbig2enc \
    leptonica \
    pngquant \
    py3-deprecation \
    py3-img2pdf \
    py3-packaging \
    py3-pdfminer \
    py3-pikepdf \
    py3-pillow \
    py3-pluggy \
    py3-reportlab \
    py3-rich \
    python3 \
    qpdf \
    tesseract-ocr \
    unpaper \
    ocrmypdf
    
#Make folder and volumes
RUN mkdir /input
RUN mkdir /output
VOLUME /input
VOLUME /output

WORKDIR /
ADD --chown=root:root https://github.com/lackylucky/ocrmypdf/raw/refs/heads/main/incoming_ocr.sh /
RUN chmod a+x ./incoming_ocr.sh
ADD --chown=root:root https://github.com/lackylucky/ocrmypdf/raw/refs/heads/main/install_lang-cron.sh /
RUN chmod a+x ./install_lang-cron.sh

CMD ["/bin/sh", "install_lang-cron.sh", "&&", "exec", "crond", "-n"]
