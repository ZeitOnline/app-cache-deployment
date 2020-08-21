sub vcl_backend_response {
    set beresp.http.x-req-url = bereq.url;

    # Per RFC2616 14.9, s-maxage is an option of the Cache-control header. But
    # since we do not want to affect any other proxies or clients, just our own
    # varnish, zeit.web uses a custom header instead.
    if (beresp.http.x-maxage && beresp.status <= 302) {
        set beresp.ttl = std.duration(beresp.http.x-maxage + "s", 60s);
    } else if (beresp.ttl <= 30s) {
        set beresp.ttl = 30s;
    }

    if (bereq.http.x-ignore-cache-control == "true") {
        unset beresp.http.Cache-Control;
        unset beresp.http.expires;
    }

    set beresp.grace = 1h;

    if (bereq.http.x-long-term-grace == "true") {
        set beresp.grace = 48h;
    }

    # Only for varnishtest
    set beresp.http.x-beresp-ttl = beresp.ttl;
    set beresp.http.x-beresp-grace = beresp.grace;

    if (beresp.status >= 500 && bereq.is_bgfetch) {
         return (abandon);
    }
}
