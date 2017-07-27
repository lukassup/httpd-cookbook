#
# Cookbook:: httpd
# Recipe:: ssl
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'chef-vault'

package 'mod_ssl' do
  notifies :reload, 'service[httpd]', :delayed
end

key = chef_vault_item('pki', "#{node.name}-vault")['key']
file '/etc/pki/tls/private/localhost.key' do
  content key
  sensitive true
  mode '0600'
  notifies :reload, 'service[httpd]', :delayed
end

cert = data_bag_item('pki', node.name)['cert']
file '/etc/pki/tls/certs/localhost.crt' do
  content cert
  notifies :reload, 'service[httpd]', :delayed
end

ca_cert = data_bag_item('pki', 'ca')['cert']
file '/etc/pki/tls/certs/ca.crt' do
  content ca_cert
end
