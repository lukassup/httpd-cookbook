# encoding: utf-8

# Inspec test for recipe httpd::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('httpd') do
  it { should be_installed }
end

describe service('httpd') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
  # The checks below require recent InSpec installation, YMMV!
  its('processes') { should include 'httpd' }
end

describe file('/var/www/html/index.html') do
  it { should exist }
  it { should be_file }
  it { should be_readable.by_user('apache') }
end
