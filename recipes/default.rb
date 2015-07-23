#
# Cookbook Name:: aws-custom-monitoring
# Recipe:: default
SCRIPT_FILENAME = 'mon-put-instance-data.pl'

prefix = node['aws-custom-monitoring']['prefix']
script_path = File.join(prefix, SCRIPT_FILENAME)
script_parameters = %w(
  --mem-util
  --disk-space-util
  --swap-util
  --disk-path=/
  --from-cron
).join(' ')

package [ 'libdatetime-perl', 'unzip', 'libwww-perl' ]  do
  action :install
end

directory '/opt/cloudwatch_monitoring_scripts' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

cookbook_file script_path do
  source 'mon-put-instance-data.pl'
  owner 'root'
  group 'root'
  mode '0774'
end

cron 'send data to amazon' do
  minute '5'
  command "#{script_path} #{script_parameters}"
end
