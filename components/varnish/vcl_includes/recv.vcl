sub vcl_recv {
    if (req.method == "PURGE" && req.url ~ "^/agatho/thread") {
            ban("obj.http.x-req-url ~ ^" + req.url);
    }

    if (req.url ~ "^/agatho/") {
        set req.backend_hint = agatho;
        set req.http.host = "community01{{component.environment}}.zeit.de";
    }
}

