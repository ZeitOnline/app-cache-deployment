sub vcl_init {
    new solr = directors.round_robin();
    solr.add_backend(athene);
    solr.add_backend(minerva);
}

