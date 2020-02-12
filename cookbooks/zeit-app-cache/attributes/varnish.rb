default["varnish"] = {}
default["varnish"]["port"] = "8080"
default["varnish"]["storage-size"] = "256M"
default["varnish"]["send-timeout"] = "60"
# To get the upstream default format, set to this:
# '%h %l %u %t "%r" %s %b "%{Referer}i" "%{User-agent}i"'
default["varnish"]["ncsa_format"] = false
