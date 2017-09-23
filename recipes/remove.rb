#
# Cookbook:: httpd
# Recipe:: remove
#
# Copyright:: 2017, The Authors, All Rights Reserved.

service 'httpd' do
  action [:disable, :stop]
end

package 'httpd' do
  action :remove
end

package 'mod_ssl' do
  action :remove
end

%w[
  /etc/pki/tls/private/localhost.key
  /etc/pki/tls/certs/localhost.crt
  /etc/pki/tls/certs/ca.crt
].each do |path|
  file path do
    action :delete
  end
end

directory '/var/www' do
  recursive true
  action :delete
end
