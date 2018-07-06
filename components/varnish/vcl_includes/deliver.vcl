sub vcl_deliver {
    set resp.http.X-ZON-Cache = req.http.X-ZON-Cache;
}
