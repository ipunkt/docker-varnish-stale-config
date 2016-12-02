FROM rawmind/rancher-tools:0.3.4-5
COPY root /
VOLUME /config/varnish/
COPY no-bots.vcl /config/varnish/
