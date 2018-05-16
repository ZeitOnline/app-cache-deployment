backend agatho {
    .host = "community01.zeit.de";
    .port = "80";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 1s;
}

backend zett {
    .host = "app-cache{{environment}}.zeit.de";
    .port = "80";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 1s;
}

backend spektrum {
    .host = "www.spektrum.de";
    .port = "80";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 1s;
}

backend brandeins {
    .host = "app-cache<%=@environment%>.zeit.de";
    .port = "80";
    .connect_timeout = 10s;
    .first_byte_timeout = 10s;
    .between_bytes_timeout = 1s;
}

backend academics {
    .host = "jobs.zeit.de";
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

