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
    # Note: Specific backends are defined in internal-lb config.

    set req.backend_hint = default;

    # -- homepage feeds --

    if (req.url == "/academics-hp-feed") {
        set req.http.host = "jobs.zeit.de";
        set req.url = "/cached-rss-feeds/adpanel_333644.html";
    }

    if (req.url == "/brandeins-hp-feed") {
        set req.http.host = "www.brandeins.de";
        set req.url = "/zeit-feed.rss";
    }

    if (req.url == "/spektrum-hp-feed") {
        set req.http.host = "www.spektrum.de";
        set req.url = "/alias/rss/zeit-kooperationsfeed-mit-kategorien/1342995";
    }

    if (req.url == "/zett-hp-feed") {
        set req.http.host = "ze.tt";
        set req.url = "/feed-zon";
    }

    # -- liveblog --
    # liveblog backends are needed, when the app-server itself does some
    # requests to authenticate or ask for the state of a blog.

    # liveblog version 3
    if (req.url ~ "^/liveblog-api-v3/") {
        set req.url = regsub(req.url, "^/liveblog-api-v3/", "/api/blogs/");
        set req.http.host = "zeit-api.liveblog.pro";
    }

    # liveblog legacy version	
    if (req.url ~ "^/liveblog-status/") {
        set req.url = regsub(
            req.url, "^/liveblog-status/", "/resources/LiveDesk/");
        set req.http.host = "zeit.superdesk.pro";
    }

    ### --- Specific backends, based on request properties --- ###

    # -- community --
    if (req.url ~ "^/agatho/") {
        set req.backend_hint = agatho;
        set req.http.host = "community01{{component.subdomain}}.zeit.de";
    }

    # -- search --
    if (req.url ~ "^/website-solr/select") {
        set req.url = regsub(req.url, "^/website-solr", "/solr/website");
        set req.backend_hint = solr.backend();
    }


    ### --- Exit Strategy --- ###
    # An infinite loop would be triggered for requests to the default backend with 
    # an app-cache host header. To prevent it, we respond with a 404.

    if (req.http.host == "app-cache.zeit.de" && req.backend_hint == default) {
        return(synth(404, "Not found"));
    }


    ### --- Useful patterns --- ###

    # Remove cookies, where not needed.
    if (req.backend_hint != agatho) {
        unset req.http.Cookie;
    }
}
