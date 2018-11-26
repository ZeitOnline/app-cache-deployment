name             'zeit-app-cache'
<<<<<<< Updated upstream
version          '1.1.0'
=======
version          '1.2.0'
>>>>>>> Stashed changes

maintainer       'ZEIT ONLINE GmbH'
maintainer_email 'zon-backend@zeit.de'
issues_url       nil
source_url       nil
license          'All rights reserved'
description      'Installs/Configures app-cache'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

chef_version     '>= 13'
supports         'ubuntu', '>= 18.04'

depends 'zeit-batou-target', '=1.5.1'
depends 'zeit-metrics', '=0.0.32'
  depends 'xinetd', '=1.0.1'
depends 'memcached', '=5.1.1'
  depends 'runit', '=4.3.0'
    depends 'packagecloud', '=1.0.1'
    depends 'yum-epel'  # already pinned by baseserver
depends 'zeit-zabbix'  # already pinned by baseserver
