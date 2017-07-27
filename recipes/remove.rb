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

file '/etc/pki/tls/private/localhost.key' do
  action :delete
end

file '/etc/pki/tls/certs/localhost.crt' do
  action :delete
end

file '/etc/pki/tls/certs/ca.crt' do
  action :delete
end

directory '/var/www' do
  recursive true
  action :delete
end
