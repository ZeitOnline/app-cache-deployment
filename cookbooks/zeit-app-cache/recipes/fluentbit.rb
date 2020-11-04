node.default["fluentbit"]["target"] = "internallb"
if node.chef_environment.include?("production")
  node.default["fluentbit"]["conf"]["index_prefix"] = "app-cache"
else
  node.default["fluentbit"]["conf"]["index_prefix"] = "staging-app-cache"
end

include_recipe "zeit-fluentbit"
