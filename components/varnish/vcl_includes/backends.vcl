backend default {
    {% if not component.haproxy_backend %}
    .host = "internal-lb{{component.subdomain}}.zeit.de";
    {% else %}
    .host = "{{component.haproxy_backend}}";
    {% endif %}
    .port = "8081";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 1s;
}
