def common()
  default_source :supermarket

  zon_cookbook "zeit-environments"
end


def zon_cookbook(name)
  cookbook(name, {
    git: "git@styx2.zeit.de:/home/git/chef.git",
    branch: "chefServer",
    revision: "04ea556",
    rel: "cookbooks/#{name}",
  })
end


def local_cookbook(name)
  cookbook "zeit-app-cache", path: File.expand_path(
    File.dirname(__FILE__) + "/../cookbooks/#{name}")
end
