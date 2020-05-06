sub vcl_deliver {
    # Add debug output (set in vcl_hit/miss/pass)
    set resp.http.X-ZON-Cache = req.http.X-ZON-Cache;
    if (client.ip ~ zeit) {
        if (req.http.X-ZON-TTL) {
            set resp.http.X-ZON-TTL = req.http.X-ZON-TTL;
        }
        if (req.http.X-ZON-Grace) {
            set resp.http.X-ZON-Grace = req.http.X-ZON-Grace;
        }
    } else {
        # Remove for non-varnishtest (set in vcl_backend_response)
        unset resp.http.x-beresp-ttl;
        unset resp.http.x-beresp-grace;
    }
}
