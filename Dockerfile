
# syntax=docker/dockerfile:1
FROM alpine:latest
MAINTAINER lackylucky
RUN apk update
RUN apk upgrade --available
RUN apk --no-cache add tesseract-ocr
RUN apk --no-cache add inotify-tools
RUN apk --no-cache add ocrmypdf
RUN mkdir /input
RUN mkdir /output
VOLUME /input
VOLUME /output
WORKDIR /
COPY --chown=root:root ./incoming_ocr.sh /
RUN ls -l
RUN chmod a+x ./incoming_ocr.sh
RUN ls -l
CMD ["ls -l"]
CMD ["/bin/sh", "incoming_ocr.sh"]
