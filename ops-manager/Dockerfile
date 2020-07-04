FROM ubuntu:18.04

# https://www.mongodb.com/try/download/ops-manager
# https://docs.opsmanager.mongodb.com/current/installation/

# stable:        https://downloads.mongodb.com/on-prem-mms/deb/mongodb-mms_4.2.15.56937.20200701T0316Z-1_x86_64.deb
# rapid release: https://downloads.mongodb.com/on-prem-mms/deb/mongodb-mms_4.3.9.100.20200331T2242Z-1_x86_64.deb
# stable:        https://downloads.mongodb.com/on-prem-mms/deb/mongodb-mms_4.0.18.50621.20200512T1431Z-1_x86_64.deb

ARG OPS_MGR_VERSION=4.2.15.56937.20200701T0316Z-1
ARG OPS_MGR_TAg=4.2.15

RUN apt-get update \
 && apt-get install -y wget vim curl net-tools libsasl2-2 libsnmp30 ca-certificates \
 && wget https://downloads.mongodb.com/on-prem-mms/deb/mongodb-mms_${OPS_MGR_VERSION}_x86_64.deb \
 && dpkg --install mongodb-mms_${OPS_MGR_VERSION}_x86_64.deb \
 && rm -f *.deb && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY default-conf-mms.properties /opt/mongodb/mms/conf/conf-mms.properties
COPY docker-entrypoint.sh /entrypoint.sh

VOLUME /etc/mongodb-mms /opt/mongodb/mms/conf /opt/mongodb/mms/logs

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
CMD ["mongodb-mms"]
