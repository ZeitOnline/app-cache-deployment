sub vcl_backend_response {
    set beresp.http.x-req-url = bereq.url;

    if (beresp.ttl <= 30s) {
        set beresp.ttl = 30s;
    }

    set beresp.grace = 1h;

    if (bereq.backend == liveblog3api) {
        set beresp.grace = 48h;
    }

}
