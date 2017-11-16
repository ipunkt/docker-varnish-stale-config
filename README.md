# docker-varnish-stale-config
stale-on-revalidate and stale-on-error config template for confd to use with [rancher-tools](https://github.com/rawmind0/rancher-tools)

# Config
The configuration currently uses a round-robin director to add all backends.

The backends are generated from the services links. However in rancher 1.2.0-pre3 there is a bug in
rancher/confd giving `STACK/SERVICE` as key and confd only passes on the `STACK` part. Thus the config is generated
for all services matching the links `STACK` and:
- BACKEND\_PREFIX: Name to match
- BACKEND\_DIVIDER: only up until this character is matched  
- NOBOTS: if this is set to `true` then the bot useragent -> pass through(pipe) mode instead of cache
- VARY\_AUTH: If this is set to `true` then caching will take place despite an authorization header being sent. Responses
  will vary based on the authorization header.  
  This is ment for staging environments with basic auth protection.
- IGNORE\_COOKIES: If this is set to `true` then caching will take place despite cookies. Responses are NOT varied by cookie  
- SIMPLE\_BACKEND: If this is set to `true` then varnish will simply use the
  hostname `backend` as its backend.

Ex. BACKEND\_PREFIX `abc`, BACKEND_DIVIDER `-`:
- `abc-v1` would match `abc` = `abc` and create a backend for the service
- `abcd-v1` would match `abcd` != `abc` and discard the service

# Important
You must make `/opt/tools` a volume in your container for this image to work.  
The actual content is unpacked into `/opt/tools` when the container is run

Because confd is run in the rancher-tools container and not in this sidekick container all options MUST be set in the
rancher-tools container

# Created configs
- VARNISH_CONFIG: `/opt/varnish/etc/default.vcl` - 1 year grace  
