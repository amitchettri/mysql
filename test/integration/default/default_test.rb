# InSpec test for recipe mysql::default

# The InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

describe mysql_conf do
  its('mysqld.port') { should cmp 3300 }
end

describe service('mysqld') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
