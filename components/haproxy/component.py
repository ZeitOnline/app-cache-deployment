from batou.component import Component, platform
from batou.lib.file import File
import re


class HAProxy(Component):

    memcache_settings = [
        'inter 5s fastinter 1s rise 2 fall 3',
        'backup',
    ]
    memcache_port = 11211

    def configure(self):
        self.subdomain = self.require_one('settings').subdomain

        self.nameservers = []
        for line in open('/etc/resolv.conf'):
            if line.startswith('nameserver'):
                parts = re.split(' +', line.strip())
                self.nameservers.append(parts[1])
        self.varnish_hosts = self.require('varnish:http')
        self += File('haproxy.cfg')


@platform('debian', HAProxy)
class ReloadHAProxy(Component):

    def verify(self):
        self.parent.assert_no_subcomponent_changes()

    def update(self):
        self.cmd('/usr/sbin/haproxy -c -f /etc/haproxy/haproxy.cfg')
        self.cmd('sudo /etc/init.d/haproxy reload')
