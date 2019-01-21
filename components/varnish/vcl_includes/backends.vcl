backend default {
    .host = "{{component.haproxy_backend}}";
    .port = "8081";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 1s;
}
