sub vcl_hit {
    set req.http.X-ZON-Cache = "HIT";
    set req.http.X-ZON-TTL = obj.ttl;
    set req.http.X-ZON-Grace = obj.grace;
}

sub vcl_miss {
    set req.http.X-ZON-Cache = "MISS";
}

sub vcl_pass {
    set req.http.X-ZON-Cache = "PASS";
}
