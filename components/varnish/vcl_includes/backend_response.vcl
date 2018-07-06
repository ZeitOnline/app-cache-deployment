sub vcl_backend_response {
    set beresp.http.x-req-url = bereq.url;

    if (beresp.ttl <= 30s) {
        set beresp.ttl = 30s;
    }

    set beresp.grace = 1h;

    if (bereq.http.host == "zeit-api.liveblog.pro") {
        set beresp.grace = 48h;
    }

}
