# encoding: utf-8

# Inspec test for recipe httpd::remove

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe service('httpd') do
  it { should_not be_installed }
  it { should_not be_enabled }
  it { should_not be_running }
end

describe package('httpd') do
  it { should_not be_installed }
end

describe package('mod_ssl') do
  it { should_not be_installed }
end

describe file('/etc/pki/tls/private/localhost.key') do
  it { should_not exist }
end

describe file('/etc/pki/tls/certs/localhost.crt') do
  it { should_not exist }
end

describe file('/etc/pki/tls/certs/ca.crt') do
  it { should_not exist }
end

describe directory('/var/www') do
  it { should_not exist }
end
