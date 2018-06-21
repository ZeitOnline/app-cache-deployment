# DO NOT ACTUALLY USE THIS IN PRODUCTION
#
# This recipe is only meant to do some boostrapping in development

apt_update "update"

directory '/srv/app-cache/deployment/work/varnish/vcl_includes' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

file '/srv/app-cache/deployment/work/varnish/default.vcl' do
  content "vcl 4.0;\nbackend ap1 {\n  .host = \"127.0.0.1\";\n  .port = \"8080\";\n}"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

