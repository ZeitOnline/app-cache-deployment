require_relative "./common.rb"; common()

name "app-cache"

run_list [
    "zeit-app-cache::default",
    "zeit-app-cache::varnish",
    "zeit-app-cache::haproxy",
    "zeit-corosync::haproxy",
    "zeit-corosync",
]
local_cookbook "zeit-app-cache"
zon_cookbook "zeit-corosync"
