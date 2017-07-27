FROM ubuntu:17.04

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install isc-dhcp-client

RUN mv /sbin/dhclient /usr/sbin/dhclient

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
npm

RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install mosca pino -g

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install \
libzmq3-dev

EXPOSE 1883 80

COPY fix_network_and_start.sh /usr/bin/fix_network_and_start.sh

CMD ["/usr/bin/fix_network_and_start.sh"]

#####
# Clean up
#####

RUN DEBIAN_FRONTEND=noninteractive apt-get -y clean && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /tmp/*