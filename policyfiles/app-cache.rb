require_relative "./common.rb"; common()

name "app-cache"

run_list [
    "zeit-app-cache::default",
    "zeit-app-cache::varnish"
]
local_cookbook "zeit-app-cache"
