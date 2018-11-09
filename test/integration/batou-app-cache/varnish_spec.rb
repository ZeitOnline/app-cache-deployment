control "varnish package is installed" do
  describe package('varnish') do
    it { should be_installed }
  end

  describe processes('varnishd') do
    its('list.length') { should eq 2 }
    its('commands') { should include a_string_matching("-a :8080") }
  end
end


control "varnish parameters can be configured" do
  describe processes('varnishd') do
    its('commands') { should include a_string_matching("-s malloc,32M") }
  end
end


control "vcl config is deployed" do
  describe file('/etc/varnish/default.vcl') do
    its('link_path') { should eq '/srv/app-cache/deployment/work/varnish/default.vcl' }
  end

  describe file('/etc/varnish/vcl_includes') do
    its('link_path') { should eq '/srv/app-cache/deployment/work/varnish/vcl_includes' }
  end

  describe file('/etc/sudoers.d/batou-varnish') do
      its('content') { should match(%r{app-cache.*NOPASSWD.*varnish.service}) }
  end
end


control "vcl is applied" do
  describe http("http://localhost:8080/cache_health",
                enable_remote_worker: true) do
    its("status") { should cmp 200 }
    its("body") { should include "OK" }
  end
end
