FROM ubuntu:17.04

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
apt-get -y dist-upgrade && \
apt-get -y install \
npm \
inetutils-ping \
libzmq3-dev

RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install mosca pino -g

EXPOSE 1883 80

COPY scripts/mosca_entrypoint.sh /usr/bin/mosca_entrypoint.sh
CMD ["/usr/bin/mosca_entrypoint.sh"]

#####
# Clean up
#####

RUN DEBIAN_FRONTEND=noninteractive apt-get -y clean && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /tmp/*