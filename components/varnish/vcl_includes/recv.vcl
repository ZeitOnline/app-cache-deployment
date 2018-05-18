sub vcl_recv {
    if (req.method == "PURGE" && req.url ~ "^/agatho/thread") {
            ban("obj.http.x-req-url ~ ^" + req.url);
			return(synth(202, "Ban for agatho added"));
    }

    if (req.url ~ "^/agatho/") {
        set req.backend_hint = agatho;
        set req.http.host = "community01{{component.env}}.zeit.de";
    }
}

