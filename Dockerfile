
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
COPY --chown=root:root ./cron-tasks /etc/crontabs/cron-tasks
RUN chmod a+x ./incoming_ocr.sh
RUN chmod 0644 /etc/crontabs/cron-tasks
RUN crontab /etc/crontabs/cron-tasks
CMD ["/bin/sh", "incoming_ocr.sh"]
