FROM busybox
RUN mkdir -p /config/varnish/
VOLUME /config/varnish/
COPY default.vcl /config/varnish/
COPY no-bots.vcl /config/varnish/
