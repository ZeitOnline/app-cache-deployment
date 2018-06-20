sub vcl_init {
    new solr = directors.fallback();
    solr.add_backend(minerva);
    solr.add_backend(athene);
}

