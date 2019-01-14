control "memcache is installed" do
  describe package("memcached") do
    it { should be_installed }
  end

  describe processes("memcached") do
    its("entries.length") { should eq 1 }
    its("commands") { should include a_string_matching("-c 2048") }
  end
end
