#!/bin/bash

# https://stackoverflow.com/a/30520299
if [[ -t 1 ]]; then
    interactive='-it'
else
    interactive=''
fi

docker run --rm ${interactive} \
    --volume {{component.vcldir}}/default.vcl:/etc/varnish/default.vcl \
    --volume {{component.vcldir}}/vcl_includes:/etc/varnish/vcl_includes \
    --volume {{component.workdir}}:/varnishtest \
    -t varnish_test_app_cache --tb=native "$@"
