node.default["batou"]["serviceUsers"] = ["app-cache"]
node.default["batou"]["haproxy_config"] = "/srv/app-cache/deployment/work/haproxy/haproxy.cfg"

include_recipe "zeit-batou-target"
include_recipe "zeit-batou-target::haproxy"
include_recipe "zeit-haproxy::monitoring"
