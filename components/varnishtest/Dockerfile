FROM ubuntu:18.04
RUN apt-get update && apt-get install -y \
   python3 varnish python3-pip
RUN pip3 install pytest
WORKDIR /varnishtest 
ENTRYPOINT ["pytest"]
