sub vcl_deliver {
    if (obj.hits > 0) {
        set resp.http.X-ZON-Cache = "HIT";
    } else {
        set resp.http.X-ZON-Cache = "MISS";
    }
}
