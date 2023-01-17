
# syntax=docker/dockerfile:1
FROM alpine:latest
MAINTAINER lackylucky

#Variables
ENV LANG C.UTF-8

#Run Updates
RUN apk update

#Install pakages
RUN apk add --no-cache \
    tesseract-ocr \
    inotify-tools \
    ocrmypdf

#Make folder and volumes
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
#CMD ["/bin/sh", "incoming_ocr.sh"]
ENTRYPOINT /bin/sh -c incoming_ocr.sh
#ENTRYPOINT ["tail", "-f", "/dev/null"]
#CMD echo hello world
