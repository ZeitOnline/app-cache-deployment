package "varnish"

service "varnish" do
  supports :stop => true, :start => true, :restart => true, :reload => true
  action [ :enable ]
end

execute 'varnish_reload' do
  command 'systemctl daemon-reload && systemctl restart varnish'
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
  notifies :run, 'execute[varnish_reload]', :immediately
end
