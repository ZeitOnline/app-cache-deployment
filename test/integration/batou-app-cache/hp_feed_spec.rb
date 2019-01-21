# control "academics feed is proxied correctly" do
#   describe http("http://localhost/academics-hp-feed",
#                 enable_remote_worker: true) do
#     its("status") { should eq 200}
#     its("body") { should include "<link>https://jobs.zeit.de</link>" }
#   end
# end


control "brandeins feed is proxied correctly" do
  describe http("http://localhost/brandeins-hp-feed",
                enable_remote_worker: true) do
    its("status") { should eq 200}
    its("body") { should include "<link>http://www.brandeins.de</link>" }
  end
end


control "spektrum feed is proxied correctly" do
  describe http("http://localhost/spektrum-hp-feed",
                enable_remote_worker: true) do
    its("status") { should eq 200}
    its("body") { should include "<link>https://www.spektrum.de</link>" }
  end
end


control "zett feed is proxied correctly" do
  describe http("http://localhost/zett-hp-feed",
                enable_remote_worker: true) do
    its("status") { should eq 200}
    its("body") { should include "<link>https://ze.tt</link>" }
  end
end