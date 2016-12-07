# docker-varnish-stale-config
stale-on-revalidate and stale-on-error config template for confd to use with [rancher-tools](https://github.com/rawmind0/rancher-tools)

# Important
You must make `/opt/tools` a volume in your container for this image to work.  
The actual content is unpacked into `/opt/tools` when the container is run

# Created configs
- VARNISH_CONFIG: `/opt/varnish/etc/default.vcl` - 1 year grace  
  Alternative: `/opt/varnish/etc/no-bots.vcl` - `default.vcl` + switches to pass-through mode for bot crawler
