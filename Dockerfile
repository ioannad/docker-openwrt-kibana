FROM mcreations/openwrt-java:8

LABEL maintainer="Ioanna M. Dimitriou <dimitriou@m-creations.com>"
LABEL version="5.5.0"
LABEL vendor="mcreations"
LABEL name="docker-openwrt-kibana"

EXPOSE 5601

ENV KIBANA_VERSION "5.5.0"
ENV KIBANA_ARTIFACT "kibana-${KIBANA_VERSION}-linux-x86_64"
ENV KIBANA_FILE "${KIBANA_ARTIFACT}.tar.gz"
ENV KIBANA_DOWNLOAD_URL "https://artifacts.elastic.co/downloads/kibana/${KIBANA_FILE}"

ENV KIBANA_HOME /opt/kibana

# add user: 

ENV KIBANA_USER="kibana"
ENV KIBANA_GROUP="$KIBANA_USER"
# ENV ELASTICSEARCH_URL="http://localhost:9200"

# installation scripts are here:
RUN mkdir -p /mnt/packs

ADD image/root /
ADD dist/ /mnt/packs

RUN bash /mnt/packs/install-kibana.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
 
CMD [ "" ]