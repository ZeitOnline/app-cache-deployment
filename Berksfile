# -*- ruby -*-

source "https://supermarket.chef.io"
source :chef_server

def local_cookbook(name)
  cookbook name, path: File.expand_path(
    File.dirname(__FILE__) + "/cookbooks/#{name}")
end

local_cookbook "zeit-app-cache"
cookbook "zeit-baseserver"  # only for the version pins
