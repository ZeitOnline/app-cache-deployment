apt_repository "varnish" do
  uri "https://packagecloud.io/varnishcache/varnish60lts/ubuntu/"
  distribution "trusty"
  components ["main"]
  key 'https://packagecloud.io/varnishcache/varnish60lts/gpgkey'
end

package "varnish" do
  # Prevent unwanted updates (which might trigger an uncontrolled restart)
  version node["varnish"]["package-version"]
end

execute 'varnish_restart' do
  command 'systemctl daemon-reload && systemctl restart varnish && sleep 3'
  action :nothing
end

execute 'varnish_reload' do
  command 'systemctl reload varnish'
  action :nothing
end

directory '/etc/systemd/system/varnish.service.d' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template "/etc/systemd/system/varnish.service.d/varnish.conf" do
  source "varnish.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :run, 'execute[varnish_restart]', :immediately
end

# Link VCL to configured batou location
varnish_config = node["batou"]["varnish_config"] or []
if ! varnish_config.is_a?(Array)
  varnish_config = [varnish_config]
end

varnish_config.each do |config|
  link "/etc/varnish/#{File.basename(config)}" do
    to config
    only_if { File.exists? config}
    notifies :run, "execute[varnish_reload]", :delayed
  end
end

# Allow batou to restart varnish,if serviceUser is given
template "/etc/sudoers.d/batou-varnish" do
  source "sudoers.erb"
  mode "0440"
  only_if { Dir.exists? "/etc/sudoers.d" }
end


if not node["varnish"]["enable_ncsa_service"]
  # Started by default by the varnish debian package
  service "varnishncsa" do
    action [:stop, :disable]
  end
end
