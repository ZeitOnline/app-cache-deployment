from batou.component import Component, platform
from batou.lib.file import File
import re


class HAProxy(Component):

    memcache_settings = [
        'inter 5s fastinter 1s rise 2 fall 3',
        'backup',
    ]
    memcache_port = 11211

    zeit_networks = [
        "127.0.0.1",        # localhost
        "10.100.0.0/16",    # Server HH
        "10.30.0.0/21",     # ZON HH
        "10.30.8.0/21",     # ZON Ber
        "10.200.200.0/21",  # OpenVPN
        "10.210.0.0/21",    # OpenVPN
        "10.110.0.0/16",    # Google k8s
        "194.77.156.0/23",  # ZON HH public
        "217.13.68.0/23",   # Gaertner
        "192.168.0.0/16",   # Docker
    ]

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
