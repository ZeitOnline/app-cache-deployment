control "haproxy package is installed" do
  describe package('haproxy') do
    it { should be_installed }
  end

  describe processes('haproxy') do
    its('entries.length') { should eq 2 }
  end
end


control "haproxy config retrieves backends via provide/require" do
  describe file('/etc/haproxy/haproxy.cfg') do
    its('content') { should include "batou-app-cache-ubuntu-1804:11211" }
    its('content') { should include "batou-app-cache-ubuntu-1804:8080" }
  end
end


control "haproxy config is applied" do
  describe http("http://localhost/cache_health",
                enable_remote_worker: true) do
    its("status") { should cmp 200 }
    its("body") { should include "OK" }
  end
end
