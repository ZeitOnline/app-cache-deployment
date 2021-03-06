node.default["acme.sh"]["deploy_target"] = "haproxy"
node.default["acme.sh"]["run_as_user"] = "haproxy"
node.default["acme.sh"]["ddns-key-id"] = "app-cache"
if node.chef_environment != "_default"  # kitchen
  include_recipe "zeit-letsencrypt-acme.sh"
  include_recipe "zeit-app-cache::fluentbit"
end

node.default["batou"]["serviceUsers"] = ["app-cache"]
node.default["batou"]["haproxy_config"] = "/srv/app-cache/deployment/work/haproxy/haproxy.cfg"

include_recipe "zeit-batou-target"
include_recipe "zeit-batou-target::haproxy"
node.default["prometheus_exporters"]["haproxy"]["scrape_uri"] = "unix:/var/run/haproxy.sock"
include_recipe "zeit-haproxy::monitoring"
