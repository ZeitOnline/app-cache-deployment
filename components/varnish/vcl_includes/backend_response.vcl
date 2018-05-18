sub vcl_backend_response {
    set beresp.http.x-req-url = bereq.url;
}
