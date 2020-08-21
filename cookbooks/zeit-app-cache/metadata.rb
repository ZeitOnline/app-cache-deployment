name             'zeit-app-cache'
version          '1.9.2'

maintainer       'ZEIT ONLINE GmbH'
maintainer_email 'zon-backend@zeit.de'
issues_url       nil
source_url       nil
license          'All rights reserved'
description      'Installs/Configures app-cache'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

chef_version     '>= 14'
supports         'ubuntu', '>= 18.04'

depends 'zeit-batou-target', '=1.8.0'
depends 'zeit-haproxy', '=2.3.0'
depends "zeit-letsencrypt-acme.sh"  # pinned in env
depends 'memcached', '=5.1.1'
  depends 'runit', '=4.3.0'
    depends 'packagecloud', '=1.0.1'
    depends 'yum-epel'  # already pinned by baseserver
depends 'zeit-zabbix'  # already pinned by baseserver
depends 'prometheus_exporters', '>=0.15.102'
