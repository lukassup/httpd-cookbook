# encoding: utf-8

# Inspec test for recipe httpd::ssl

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('mod_ssl') do
  it { should be_installed }
end

describe port(443) do
  it { should be_listening }
  # The checks below require recent InSpec installation, YMMV!
  its('processes') { should include 'httpd' }
end

describe file('/etc/pki/tls/private/localhost.key') do
  it { should exist }
  it { should be_file }
  it { should_not be_readable.by('others') }
  its('content') { should match '-----BEGIN RSA PRIVATE KEY-----' }
  its('content') { should match '-----END RSA PRIVATE KEY-----' }
end

describe file('/etc/pki/tls/certs/localhost.crt') do
  it { should exist }
  it { should be_file }
  its('content') { should match '-----BEGIN CERTIFICATE-----' }
  its('content') { should match '-----END CERTIFICATE-----' }
end
