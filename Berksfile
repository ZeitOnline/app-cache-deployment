# -*- ruby -*-

source "https://supermarket.chef.io"


def zon_cookbook(name)
  cookbook(name, {
    git: "git@github.com:ZeitOnline/chef",
    ref: "9d90014",
    rel: "cookbooks/#{name}",
  })
end


def local_cookbook(name)
  cookbook name, path: File.expand_path(
    File.dirname(__FILE__) + "/cookbooks/#{name}")
end


local_cookbook "zeit-app-cache"
  zon_cookbook "zeit-batou-target"
