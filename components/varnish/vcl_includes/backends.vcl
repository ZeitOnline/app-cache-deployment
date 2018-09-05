# Used for homepage feeds and liveblogs
backend default {
    .host = "internal-lb{{component.subdomain}}.zeit.de";
    .port = "80";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 1s;
}

backend agatho {
    .host = "community-app{{component.subdomain}}.zeit.de";
    .port = "80";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 1s;
}
