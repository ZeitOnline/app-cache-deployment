FROM ubuntu:18.04

# ubuntu-18 has varnish-5, so we need a custom repo for varnish-6, see
# <https://packagecloud.io/varnishcache/varnish63/install#manual>
RUN apt-get update && apt-get install -y curl gnupg apt-transport-https
RUN curl -L https://packagecloud.io/varnishcache/varnish63/gpgkey \
    | apt-key add -
RUN echo "deb https://packagecloud.io/varnishcache/varnish63/ubuntu/ bionic main" \
    > /etc/apt/sources.list.d/varnish.list

RUN apt-get update && apt-get install -y \
   python3 varnish python3-pip
RUN pip3 install pytest
WORKDIR /varnishtest
ENV LANG=en_US.utf-8
ENV PYTHONDONTWRITEBYTECODE 1
ENTRYPOINT ["pytest", "-p", "no:cacheprovider"]
