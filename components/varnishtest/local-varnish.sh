#!/bin/bash

# https://stackoverflow.com/a/30520299
if [[ -t 1 ]]; then
    interactive='-it'
else
    interactive=''
fi

docker run --rm ${interactive} -p 8080:8080 \
    --volume {{component.workdir}}:/varnishtest \
    --volume {{component.workdir}}/../varnish/vcl_includes:/etc/varnish/vcl_includes \
    --entrypoint /varnishtest/varnish.sh varnish_test_front "$@"
