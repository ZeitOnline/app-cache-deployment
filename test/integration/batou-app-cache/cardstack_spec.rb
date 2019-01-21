control "cardstack is proxied correctly" do
  # This test is not as encompassing as it could be, since we cannot include
  # the front-varnish portion of the chain here.
  describe http(
             "http://localhost:8081/cardstack/stacks/esi/head",
             enable_remote_worker: true) do
    its("status") { should eq 200}
    its("body") { should include 'Cards Head Begin' }
  end
end
