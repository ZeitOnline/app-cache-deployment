sub vcl_backend_response {
    set beresp.http.x-req-url = bereq.url;

    if (beresp.ttl <= 30s) {
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

    if (beresp.status >= 500 && bereq.is_bgfetch) {
         return (abandon);
    }
}
