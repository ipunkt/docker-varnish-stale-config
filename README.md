# docker-varnish-stale-config
stale-on-revalidate and stale-on-error config template for confd to use with [rancher-tools](https://github.com/rawmind0/rancher-tools)

# Config
The configuration currently uses a round-robin director to add all backends.

The backends are generated from the services links. However in rancher 1.2.0-pre3 there is a bug in
rancher/confd giving `STACK/SERVICE` as key and confd only passes on the `STACK` part. Thus the config is generated
for all services matching the links `STACK` and:
- BACKEND_PREFIX: Name to match
- BACKEND_DIVIDER: only up until this character is matched  

Ex. BACKEND_PREFIX `abc`, BACKEND_DIVIDER `-`:
- `abc-v1` would match `abc` = `abc` and create a backend for the service
- `abcd-v1` would match `abcd` != `abc` and discard the service

# Important
You must make `/opt/tools` a volume in your container for this image to work.  
The actual content is unpacked into `/opt/tools` when the container is run

The options `BACKEND_PREFIX` and `BACKEND_DIVIDER` must be set in the `rancher-tools` image because the confd is run
there, not inside this sidekick

# Created configs
- VARNISH_CONFIG: `/opt/varnish/etc/default.vcl` - 1 year grace  
  Alternative: `/opt/varnish/etc/no-bots.vcl` - `default.vcl` + switches to pass-through mode for bot crawler
