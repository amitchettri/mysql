#
# Cookbook:: mysql
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

cookbook_file "#{Chef::Config[:file_cache_path]}/#{node['mysql']['rpm_package']}" do
  source node['mysql']['rpm_package']
  mode '755'
end

rpm_package 'mysql57' do
  source "#{Chef::Config[:file_cache_path]}/#{node['mysql']['rpm_package']}"
  action :install
end

package 'mysql-server' do
  action :install
end

ruby_block 'update mysql server port' do
  block do
    file = Chef::Util::FileEdit.new('/etc/my.cnf')
    if shell_out("grep '^port.*' /etc/my.cnf").stdout.empty?
      file.insert_line_after_match('\[mysqld\]', "port=#{node['mysql']['port']}")
    else
      file.search_file_replace_line('^port', "port=#{node['mysql']['port']}")
    end
    file.write_file
  end
  notifies :restart, 'service[mysqld]', :delayed
  not_if "grep \"^port.*#{node['mysql']['port']}\" /etc/my.cnf"
end

execute ' SELinux rule to bind MySQL socket on the new port' do
  command "semanage port -a -t mysqld_port_t -p tcp #{node['mysql']['port']}"
  notifies :restart, 'service[mysqld]', :delayed
  not_if "semanage port -l | grep mysqld_port_t | grep #{node['mysql']['port']}"
end

service 'mysqld' do
  action [:enable, :start]
end
