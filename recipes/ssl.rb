#
# Cookbook:: httpd
# Recipe:: ssl
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'chef-vault'

package 'mod_ssl' do
  notifies :reload, 'service[httpd]', :delayed
end

# try getting the private key
begin
  key = chef_vault_item('private_keys', node.name)['key']
rescue Net::HTTPServerException => e
  Chef::Log.error('Unable to retrieve private key')
  key = nil
end

# try getting the certificate
begin
  cert = data_bag_item('certificates', node.name)['cert']
rescue Net::HTTPServerException => e
  Chef::Log.error('Unable to retrieve certificate')
  cert = nil
end

# if any of the keypair parts are empty or Chef Vault item cannot be read
# generate a self-signed keypair
if key.nil? or cert.nil? or key.match?(/invalid_password/i)
  Chef::Log.error('Unable to retrieve either of the keypair items')
  Chef::Log.info('Generating a self-signed keypair')
  bash 'generate self-signed keypair' do
    code <<-EOH
    openssl req \
      -x509 \
      -nodes \
      -newkey rsa:2048 \
      -keyout /etc/pki/tls/private/localhost.key \
      -out /etc/pki/tls/certs/localhost.crt \
      -subj "/C=GB/ST=London/L=London/O=Kitchen/OU=Infrastructure/CN=#{node['fqdn']}" \
      -days 365
    EOH
    not_if { File.exist?('/etc/pki/tls/private/localhost.key') }
    not_if { File.exist?('/etc/pki/tls/certs/localhost.crt') }
    notifies :reload, 'service[httpd]', :delayed
  end
else
  Chef::Log.info('Both keypair items found')

  file '/etc/pki/tls/private/localhost.key' do
    content key
    sensitive true
    mode '0600'
    notifies :reload, 'service[httpd]', :delayed
  end

  file '/etc/pki/tls/certs/localhost.crt' do
    content cert
    notifies :reload, 'service[httpd]', :delayed
  end
end

ca_cert = data_bag_item('certificates', 'ca')['cert']
file '/etc/pki/tls/certs/ca.crt' do
  content ca_cert
end
