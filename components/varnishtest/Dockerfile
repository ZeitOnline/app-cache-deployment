FROM ubuntu:18.04
RUN apt-get update && apt-get install -y \
   python3 varnish python3-pip
RUN pip3 install pytest
COPY . /varnishtest 
WORKDIR /varnishtest 
COPY config/default.vcl /etc/varnish/
COPY config/vcl_includes /etc/varnish/vcl_includes
ENTRYPOINT ["pytest"]
