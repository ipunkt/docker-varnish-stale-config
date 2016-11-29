vcl 4.0;

backend default {
	.host = "backend";
	.port = "80";
}

# Customised 'vcl_hit'.
sub vcl_hit {
	return (deliver);
}

sub vcl_backend_response {
    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.
    set beresp.ttl = 45s;
    set beresp.grace = 10d;
}
