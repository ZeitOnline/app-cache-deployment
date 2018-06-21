require_relative "./common.rb"; common()

name "app-cache"

run_list [
    "zeit-app-cache::testing",
    "zeit-app-cache::varnish"
]
local_cookbook "zeit-app-cache"
