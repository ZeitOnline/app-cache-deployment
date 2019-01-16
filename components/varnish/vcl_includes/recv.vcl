sub vcl_recv {

    ### --- Access restriction --- ###
    # Only internal services will ever be allowed to use this varnish

    if (!client.ip ~ zeit) {
        return(synth(405, "Not allowed."));
    }

    ### --- Health check --- ###

    if (req.url == "/cache_health") {
        return(synth(200, "OK"));
    }


    ### --- Purging --- ###

    if (req.method == "PURGE" && req.url ~ "^/agatho/thread") {
        ban("obj.http.x-req-url ~ ^" + req.url);
        return(synth(202, "Ban for agatho added"));
    }

    ### --- Default backend --- ###
    # The default backend is feeds, which points to the internal-lb HA cluster.
    # This round trip is needed, because varnish cannot resolve SSL backends itself.
    # Note: The specific backends are defined in the haproxy config.

    set req.backend_hint = default;

    # -- homepage feeds --

    if (req.url == "/academics-hp-feed") {
        set req.http.host = "jobs.zeit.de";
        set req.url = "/cached-rss-feeds/adpanel_333644.html";
        set req.http.x-ignore-cache-control = "true";
        set req.http.x-long-term-grace = "true";
    }

    if (req.url == "/brandeins-hp-feed") {
        set req.http.host = "www.brandeins.de";
        set req.url = "/zeit-feed.rss";
        set req.http.x-ignore-cache-control = "true";
        set req.http.x-long-term-grace = "true";
    }

    if (req.url == "/spektrum-hp-feed") {
        set req.http.host = "www.spektrum.de";
        set req.url = "/alias/rss/zeit-kooperationsfeed-mit-kategorien/1342995";
        set req.http.x-ignore-cache-control = "true";
        set req.http.x-long-term-grace = "true";
    }

    if (req.url == "/zett-hp-feed") {
        set req.http.host = "ze.tt";
        set req.url = "/feed-zon";
        set req.http.x-ignore-cache-control = "true";
        set req.http.x-long-term-grace = "true";
    }

    # -- liveblog --
    # liveblog backends are needed, when the app-server itself does some
    # requests to authenticate or ask for the state of a blog.

    # liveblog version 3
    if (req.url ~ "^/liveblog-api-v3/") {
        set req.url = regsub(req.url, "^/liveblog-api-v3/", "/liveblog/3/api/");
        set req.http.x-cache-auth = "true";
        set req.http.x-ignore-cache-control = "true";
        set req.http.x-long-term-grace = "true";
    }

    # liveblog version 3 staging
    if (req.url ~ "^/liveblog-api-vstaging/") {
        set req.url = regsub(req.url, "^/liveblog-api-vstaging/", "/liveblog/staging/api/");
        set req.http.x-cache-auth = "true";
        set req.http.x-ignore-cache-control = "true";
        set req.http.x-long-term-grace = "true";
    }

    # liveblog legacy version
    if (req.url ~ "^/liveblog-status/") {
        set req.url = regsub(req.url, "^/liveblog-status/", "/liveblog/2/api/");
    }

    # -- community --
    if (req.url ~ "^/agatho/") {
        set req.http.host = "community-app{{component.subdomain}}.zeit.de";
        set req.http.x-keep-cookies = "true";
    }

    ### --- Useful patterns --- ###

    if (! req.http.x-keep-cookies) {
        unset req.http.Cookie;
    }

    if (req.method != "GET" && req.method != "HEAD") {
        return (pass);
    }

    if (req.http.x-cache-auth == "true") {
        return (hash);
    }
}
