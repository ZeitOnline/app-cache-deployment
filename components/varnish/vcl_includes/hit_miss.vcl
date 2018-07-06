sub vcl_hit {
    set resp.http.X-ZON-Cache = "HIT";
}

sub vcl_miss {
    set resp.http.X-ZON-Cache = "MISS";
}
