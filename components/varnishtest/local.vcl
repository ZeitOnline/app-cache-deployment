vcl 4.0;

backend default {
    .host = "internal-lb.zeit.de";
    .port = "80";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 1s;
}

include "/etc/varnish/vcl_includes/main.vcl";
