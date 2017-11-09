# # encoding: utf-8

# Inspec test for recipe alternatives_test::v1

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/usr/local/sample-binary-1') do
  it { should exist }
end

describe file('/usr/local/sample-binary-2') do
  it { should exist }
end

describe file('/usr/bin/sample-binary') do
  it { should be_symlink }
  it { should_not be_directory }
end

describe file('/etc/alternatives/sample-binary') do
  it { should be_symlink }
  it { should_not be_directory }
end

screen_alt_file = file('/etc/alternatives/sample-binary').link_path
describe file(screen_alt_file) do
  its('content') { should match 'sample-binary-v1' }
  it { should exist }
  it { should_not be_symlink }
end

describe file('/usr/bin/sample-binary-test') do
  it { should_not exist }
end

describe file('/etc/alternatives/sample-binary-test') do
  it { should_not exist }
end
