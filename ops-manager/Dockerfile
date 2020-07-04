FROM ubuntu:18.04

# https://www.mongodb.com/try/download/ops-manager
ARG OPS_MGR_VERSION=4.2.15.56937.20200701T0316Z-1

RUN apt-get update \
 && apt-get install -y wget vim curl libsasl2-2 libsnmp30 ca-certificates \
 && wget https://downloads.mongodb.com/on-prem-mms/deb/mongodb-mms_${OPS_MGR_VERSION}_x86_64.deb \
 && dpkg --install mongodb-mms_${OPS_MGR_VERSION}_x86_64.deb \
 && rm -f *.deb && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY default-conf-mms.properties /opt/mongodb/mms/conf/conf-mms.properties
COPY docker-entrypoint.sh /entrypoint.sh

VOLUME /etc/mongodb-mms /opt/mongodb/mms/conf /opt/mongodb/mms/logs

ENTRYPOINT ["/entrypoint.sh"]

CMD ["mongodb-mms"]
