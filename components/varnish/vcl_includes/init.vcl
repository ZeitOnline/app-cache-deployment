sub vcl_init {
    new solr = directors.fallback();
    solr.add_backend(athene);
    solr.add_backend(minerva);
}

