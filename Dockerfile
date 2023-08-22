FROM ubuntu:22.04

ENV EXTRA_ARGS=""

RUN apt update && \
    apt install -y xmltv libdatetime-format-sqlite-perl libipc-run3-perl libjson-xs-perl liblwp-protocol-https-perl liburi-escape-xs-perl libchi-perl libchi-driver-redis-perl cron

COPY tv-grab-az-sdjson-sqlite /etc/cron.d/
RUN chmod 0644 /etc/cron.d/tv-grab-az-sdjson-sqlite
RUN crontab /etc/cron.d/tv-grab-az-sdjson-sqlite
COPY tv_grab_az_sdjson_sqlite /usr/bin
RUN chmod +x /usr/bin/tv_grab_az_sdjson_sqlite

CMD ["sh", "-c", "/usr/bin/tv_grab_az_sdjson_sqlite --config-file /config/sd.conf --output /xmltv/xmltv.xml ${EXTRA_ARGS} && cron -f"]
