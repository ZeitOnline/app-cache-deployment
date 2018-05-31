require_relative "./common.rb"; common()

name "app-cache"

run_list [
	"app-cache::default",
	"app-cache::corosync",
    "zeit-corosync::haproxy",
    "zeit-corosync",
    "app-cache::haproxy"
]
zon_cookbook "zeit-corosync"
local_cookbook "app-cache"
