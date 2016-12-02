FROM rawmind/rancher-tools:0.3.4-5
COPY root /
VOLUME /opt/
COPY no-bots.vcl /config/varnish/
