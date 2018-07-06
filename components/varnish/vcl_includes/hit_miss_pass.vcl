sub vcl_hit {
    set req.http.X-ZON-Cache = "HIT";
}

sub vcl_miss {
    set req.http.X-ZON-Cache = "MISS";
}

sub vcl_pass {
    set req.http.X-ZON-Cache = "PASS";
}
