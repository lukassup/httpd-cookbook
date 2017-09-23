name 'httpd'
maintainer 'Lukas Šupienis'
maintainer_email 'lukassup@yahoo.com'
license 'MIT'
description 'Installs/Configures httpd'
long_description 'Installs/Configures httpd'
chef_version '>= 12.1' if respond_to?(:chef_version)
supports 'redhat'
issues_url 'https://github.com/lukassup/httpd-cookbook/issues'
source_url 'https://github.com/lukassup/httpd-cookbook'

depends 'chef-vault', '~>3.0'

version '0.4.0'
