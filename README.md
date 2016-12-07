# docker-varnish-stale-config
stale-on-revalidate and stale-on-error config template for confd to use with [rancher-tools](https://github.com/rawmind0/rancher-tools)

# Important
You must make `/opt/tools` a volume in your container for this image to work.  
The actual content is unpacked into `/opt/tools` when the container is run
