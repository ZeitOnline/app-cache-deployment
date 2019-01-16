control "liveblog API is proxied correctly" do
  describe "" do
    it "" do  # work around annoying rspec API
      response = http(
        "http://localhost/liveblog-api-v3/auth",
        headers: {"Content-Type" => "application/json"} ,
        method: "POST",
        data: '{"username": "zon-backend", "password": "redanOvAwph6"}',
        enable_remote_worker: true)
      expect(response.status).to eq(201)
      authtoken = JSON.parse(response.body)["token"]
      expect(authtoken.class).to eq(String)

      response = http(
        "http://localhost/liveblog-api-v3/blogs/5a1ecb356aa4f500ed9fb5bc",
        auth: {user: authtoken, pass: ""},
        enable_remote_worker: true)
      expect(response.body).to include("blog_status")
    end
  end
end


control "liveblog content is proxied correctly" do
  # This test is not as encompassing as it could be, since we cannot include
  # the front-varnish portion of the chain here.
  describe http(
     "http://localhost/liveblog/3/content/5a1ecb356aa4f500ed9fb5bc/index.html",
     enable_remote_worker: true) do
    its("status") { should eq 200}
    its("body") { should include 'class="lb-post"' }
  end
end
