# Used for homepage feeds and liveblogs
backend default {
    {% if not component.haproxy_backend %}
    .host = "internal-lb{{component.subdomain}}.zeit.de";
    {% else %}
    .host = "{{component.haproxy_backend}}";
    {% endif %}
    .port = "80";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 1s;
}
