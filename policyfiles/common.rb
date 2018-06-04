def common()
  default_source :supermarket

  zon_cookbook "zeit-online"
  zon_cookbook "zeit-baseserver"
  zon_cookbook "zeit-patch"
  zon_cookbook "zeit-zabbix"
  zon_cookbook "zeit-environments"
end


def zon_cookbook(name)
  cookbook(name, {
    git: "git@styx2.zeit.de:/home/git/chef.git",
    branch: "chefServer",
    revision: "58b27b2",
    rel: "cookbooks/#{name}",
  })
end


def local_cookbook(name)
  cookbook "zeit-app-cache", path: File.expand_path(
    File.dirname(__FILE__) + "/../cookbooks/#{name}")
end
