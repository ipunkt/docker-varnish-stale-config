FROM rawmind/rancher-tools:0.3.4-5
COPY root /
VOLUME /config/varnish/
COPY default.vcl /config/varnish/
COPY no-bots.vcl /config/varnish/
