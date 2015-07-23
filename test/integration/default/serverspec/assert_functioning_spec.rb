require 'serverspec'

set :backend, :exec

installed_packages = %w(
  libdatetime-perl
  unzip
  libwww-perl
)

installed_packages.each do |package_name|
  describe package(package_name) do
    it { should be_installed }
  end
end

prefix = File.join('/', 'opt', 'cloudwatch_monitoring_scripts')
script_path = File.join(prefix, 'mon-put-instance-data.pl')

describe file(prefix) do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode '755' }
end

describe file(script_path) do
  it { should be_file }
  it { should be_executable }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode '774' }
end

describe cron do
  cron_5_mins_period = '5 * * * *'
  script_parameters = %w(
    --mem-util
    --disk-space-util
    --swap-util
    --disk-path=/
    --from-cron
  )
  cron_entry = [
    cron_5_mins_period,
    script_path,
    script_parameters
  ].join(' ')

  it { should have_entry cron_entry }
end
