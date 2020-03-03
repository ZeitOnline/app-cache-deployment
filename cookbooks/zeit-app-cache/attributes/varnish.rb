default["varnish"] = {}
default["varnish"]["version"] = "6.3"
default["varnish"]["port"] = "8080"
default["varnish"]["storage-size"] = "256M"
default["varnish"]["send-timeout"] = "60"
default["varnish"]["workspace-client"] = "64k"
# To get the upstream default format, set to this:
# '%h %l %u %t "%r" %s %b "%{Referer}i" "%{User-agent}i"'
default["varnish"]["ncsa_format"] = false
default["varnish"]["ncsa_options"] = ""
default["varnish"]["ncsa_logrotate_hourly"] = false
