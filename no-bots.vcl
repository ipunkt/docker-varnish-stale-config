vcl 4.0;

backend default {
	.host = "backend";
	.port = "80";
}

# Customised 'vcl_hit'.
sub vcl_hit {

	# Bots require special versions of the page, pipe them through and don't
	# cache what they see
	if ( 
			req.http.User-Agent ~ "Googlebot"
			|| req.http.User-Agent ~ "AdsBot-Google"
			|| req.http.User-Agent ~ "Mediapartners-Google"
			|| req.http.User-Agent ~ "Slurp"
			|| req.http.User-Agent ~ "search.msn.com"
			|| req.http.User-Agent ~ "nutch"
			|| req.http.User-Agent ~ "simpy"
			|| req.http.User-Agent ~ "bot"
			|| req.http.User-Agent ~ "ASPSeek"
			|| req.http.User-Agent ~ "crawler"
			|| req.http.User-Agent ~ "msnbot"
			|| req.http.User-Agent ~ "Libwww-perl"
			|| req.http.User-Agent ~ "FAST"
			|| req.http.User-Agent ~ "Baidu"
			|| req.http.User-Agent ~ "Clapp/Mobile Kaufland"
		) {
		return (pass);

	}

	return (deliver);
}

sub vcl_recv {
    unset req.http.Cache-Control;
}

sub vcl_backend_response {
    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.
}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.

    if (obj.hits > 0) {
                set resp.http.X-Cache = "HIT";
        } else {
                set resp.http.X-Cache = "MISS";
        }
}

sub vcl_hash {
    hash_data(req.http.method);
}
