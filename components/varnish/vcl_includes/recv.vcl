sub vcl_recv {

    ### --- Access restriction --- ###
	# Only internal services will ever be allowed to use this varnish

    if (!client.ip ~ zeit) {
        return(synth(405, "Not allowed."));
    }

    ### --- Health check --- ###

    if (req.url == "/cache_health") {
        return(synth(200, "health check."));
    }


    ### --- Purging --- ###

    if (req.method == "PURGE" && req.url ~ "^/agatho/thread") {
        ban("obj.http.x-req-url ~ ^" + req.url);
        return(synth(202, "Ban for agatho added"));
    }

    ### --- Set backends based on request properties --- ###

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

    # -- homepage feeds --

    if (req.url == "/academics-hp-feed") {
        set req.backend_hint = academics;
        set req.http.host = "jobs.zeit.de";
        set req.url = "/cached-rss-feeds/adpanel_333644.html";
    }

    if (req.url == "/brandeins-hp-feed") {
        set req.backend_hint = brandeins;
        set req.http.host = "www.brandeins.de";
        set req.url = "/zeit-feed.rss";
    }

    if (req.url == "/spektrum-hp-feed") {
        set req.backend_hint = spektrum;
        set req.http.host = "www.spektrum.de";
        set req.url = "/alias/rss/zeit-kooperationsfeed-mit-kategorien/1342995";
    }

    if (req.url == "/zett-hp-feed") {
        set req.backend_hint = zett;
        set req.http.host = "ze.tt";
        set req.url = "/feed-zon";
    }


    ### --- Useful patterns --- ###

    # Remove cookies, where not needed.
    if (req.backend_hint == liveblog ||
            req.backend_hint == academics ||
            req.backend_hint == brandeins ||
            req.backend_hint == liveblog3api ||
            req.backend_hint == solr.backend() ||
            req.backend_hint == spektrum ||
            req.backend_hint == zett) {
        unset req.http.Cookie;
    }
}
