# -*- ruby -*-

source "https://supermarket.chef.io"


def zon_cookbook(name)
  cookbook(name, {
    git: "git@github.com:ZeitOnline/chef",
    ref: "888f67a",
    rel: "cookbooks/#{name}",
  })
end


def local_cookbook(name)
  cookbook name, path: File.expand_path(
    File.dirname(__FILE__) + "/cookbooks/#{name}")
end


local_cookbook "zeit-app-cache"
