# Used for homepage feeds and liveblogs
backend default {
    .host = "internal-lb{{component.subdomain}}.zeit.de";
    .port = "80";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 1s;
}

backend agatho {
    .host = "community01{{component.subdomain}}.zeit.de";
    .port = "80";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 1s;
}

backend athene {
    .host = "athene.zeit.de";
    .port = "8180";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 1s;
    .probe = {
        .url = "/solr/";
        .timeout = 3 s;
        .window = 8;
        .threshold = 3;
        .initial = 3;
    }
}

backend minerva {
    .host = "minerva.zeit.de";
    .port = "8180";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 1s;
    .probe = {
        .url = "/solr/";
        .timeout = 3 s;
        .window = 8;
        .threshold = 3;
        .initial = 3;
    }
}
