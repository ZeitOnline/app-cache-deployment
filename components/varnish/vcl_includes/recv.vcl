acl zeit {
    "127.0.0.1";
    "194.77.156.0"/23;
    "217.13.68.0"/24;
    "217.13.69.0"/24;
}

sub vcl_recv {
    ### --- Purging --- ###

    if (!client.ip ~ zeit) {
        return(synth(405, "Not allowed."));
    }

    if (req.method == "PURGE" && req.url ~ "^/agatho/thread") {
        ban("obj.http.x-req-url ~ ^" + req.url);
        return(synth(202, "Ban for agatho added"));
    }

    ### --- Set backends based on request properties --- ###

    # -- community --
    if (req.url ~ "^/agatho/") {
        set req.backend_hint = agatho;
        set req.http.host = "community01{{component.env}}.zeit.de";
    }

    # -- liveblog --

    # liveblog backends are needed, when the app-server itself does some
    # requests to authenticate or ask for the state of a blog.

    # liveblog version 3
    if (req.url ~ "^/liveblog-api-v3/") {
        set req.url = regsub(req.url, "^/liveblog-api-v3/", "/api/blogs/");
        set req.http.host = "zeit-api.liveblog.pro";
        set req.backend_hint = liveblog3api;
    }

    # liveblog legacy version	
    if (req.url ~ "^/liveblog-status/") {
        set req.url = regsub(
            req.url, "^/liveblog-status/", "/resources/LiveDesk/");
        set req.http.host = "zeit.superdesk.pro";
        set req.backend_hint = liveblog;
    }

    if (req.backend_hint == liveblog || req.backend_hint == liveblog3api) {
        unset req.http.Cookie;
    }
}
