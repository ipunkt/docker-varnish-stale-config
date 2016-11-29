vcl 4.0;

backend default {
	.host = "backend";
	.port = "80";
}

# Customised 'vcl_hit'.
sub vcl_hit {
	return (deliver);
}
