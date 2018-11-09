name             'zeit-app-cache'
version          '1.1.0'

maintainer       'ZEIT ONLINE GmbH'
maintainer_email 'zon-backend@zeit.de'
issues_url       nil
source_url       nil
license          'All rights reserved'
description      'Installs/Configures app-cache'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

chef_version     '>= 12'
supports         'ubuntu', '>= 18.04'

depends          'zeit-batou-target', '=1.4.1'
