version = node["varnish"]["version"].gsub('.', '')

apt_repository "varnish" do
  uri "https://packagecloud.io/varnishcache/varnish#{version}/ubuntu/"
  distribution node["lsb"]["codename"]
  components ["main"]
  key "https://packagecloud.io/varnishcache/varnish#{version}/gpgkey"
end

package "varnish" do
  # lock prevents unwanted updates, which might trigger an uncontrolled restart
  action [:install, :lock]
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


if not node["varnish"]["ncsa_format"]
  # Started by default by the varnish debian package
  service "varnishncsa" do
    action [:stop, :disable]
  end
else
  service "varnishncsa"
  directory "/etc/systemd/system/varnishncsa.service.d"
  template "/etc/systemd/system/varnishncsa.service.d/service.conf" do
    source "varnishncsa.service.erb"
    notifies :run, "execute[systemd-reload]"
    notifies :restart, "service[varnishncsa]"
  end
  execute "systemd-reload" do
    command "systemctl daemon-reload"
    action :nothing
  end
end

if node["varnish"]["ncsa_logrotate_hourly"]
  template "/etc/logrotate.d/varnish" do
    source "logrotate.conf"
  end
  template "/etc/cron.hourly/logrotate-varnish" do
    source "logrotate.cron"
    mode "0755"
  end
end
