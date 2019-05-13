control "drupal agatho API is proxied correctly" do
  describe http(
             "http://localhost/agatho/health_check",
             enable_remote_worker: true) do
    its("status") { should eq 200}
    its("body") { should include 'healthy' }
  end
end


control "drupal community API is proxied correctly" do
  describe http(
             "http://localhost/api/moderation/users/me",
             headers: {"Host" => "community-app.zeit.de"},
             enable_remote_worker: true) do
    its("status") { should eq 403}
    # Should not go through varnish
    its("headers") { should_not include "Via"}
  end
end
