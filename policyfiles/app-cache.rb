require_relative "./common.rb"; common()

name "app-cache"

run_list [
    "app-cache::default",
    "app-cache::varnish",
    "app-cache::haproxy",
    "zeit-corosync::haproxy",
    "zeit-corosync",
]
local_cookbook "app-cache"
zon_cookbook "zeit-corosync"
