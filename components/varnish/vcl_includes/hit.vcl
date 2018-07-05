sub vcl_hit {
    set resp.http.X-ZON-Cache = "HIT";
}
