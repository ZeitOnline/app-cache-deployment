package "haproxy"
package "socat"

if node["haproxy"] and node["haproxy"]["access_log_path"] then
  directory node["haproxy"]["access_log_path"] do
    user "syslog"
    group "adm"
  end

  template "/etc/haproxy/haproxy.cfg" do
    source "haproxy/app-cache.zeit.de.conf.erb"
    notifies :restart, 'service[haproxy]', :delayed
  end

  template "/etc/logrotate.d/haproxy" do
    source "haproxy-logrotated.erb"
  end

  template "/etc/cron.hourly/logrotate-haproxy" do
    mode "0755"
    source "haproxy-logrotate.erb"
  end
end

file "/etc/default/haproxy" do
  content "ENABLED=1"
end

service "haproxy" do
  action [:start, :enable]
end
