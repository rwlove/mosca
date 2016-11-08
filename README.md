# mosca

Dockerfile has hack to initialize dhclient so that the container can acquire it's IP address from a DHCP server (not Docker's). The MAC address that should be configured for this container in the DHCP server is supplied by the settings.conf file.