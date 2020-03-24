node.default["memcached"]["memory"] = 512
node.default["memcached"]["maxconn"] = 2048
# Having to specify this twice is rather poor API design.
node.default["memcached"]["ulimit"] = node.default["memcached"]["maxconn"]
node.default["memcached"]["user"] = "memcache"

node.default["batou"]["serviceUsers"] = ["app-cache"]
node.default["batou"]["varnish_config"] = [
  "/srv/app-cache/deployment/work/varnish/default.vcl",
  "/srv/app-cache/deployment/work/varnish/vcl_includes"
]

node.default["varnish"]["storage-size"] = "1655M"

include_recipe "zeit-batou-target"
include_recipe "zeit-app-cache::varnish"
include_recipe "zeit-zabbix::monitor-varnish"

include_recipe "memcached"
include_recipe "zeit-zabbix::monitor-memcached"
include_recipe "prometheus_exporters::memcache"
