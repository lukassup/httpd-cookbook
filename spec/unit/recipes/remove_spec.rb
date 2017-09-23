#
# Cookbook:: httpd
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'httpd::remove' do
  context 'When all attributes are default, on a Centos 7.3.1611' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.3.1611')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'disables and stops httpd service' do
      expect(chef_run).to disable_service('httpd')
      expect(chef_run).to stop_service('httpd')
    end

    it 'removes the httpd package' do
      expect(chef_run).to remove_package('httpd')
    end

    it 'removes the mod_ssl package' do
      expect(chef_run).to remove_package('mod_ssl')
    end

    it 'deletes the httpd TLS certificate' do
      expect(chef_run).to delete_file('/etc/pki/tls/certs/localhost.crt')
    end

    it 'deletes the httpd TLS private key' do
      expect(chef_run).to delete_file('/etc/pki/tls/private/localhost.key')
    end

    it 'deletes the CA certificate' do
      expect(chef_run).to delete_file('/etc/pki/tls/certs/ca.crt')
    end

    it 'deletes the /var/www directory' do
      expect(chef_run).to delete_directory('/var/www')
    end
  end
end
