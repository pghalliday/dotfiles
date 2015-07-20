case node['platform']
when 'ubuntu'
  include_recipe 'aws::ubuntu'
end
zipfile = "#{Chef::Config[:file_cache_path]}/AWSCloudFormation-cli.zip"
installdir = '/opt'
remote_file zipfile do
  source 'https://s3.amazonaws.com/cloudformation-cli/AWSCloudFormation-cli.zip'
  checksum '382e3e951833fd77235fae41c1742224d68bdf165e1ace4200ee88c01ac29a90'
  notifies :run, 'bash[install AWS Cloud Formation CLI tools]', :immediately
end
bash 'install AWS Cloud Formation CLI tools' do
  code <<-EOH
  unzip #{zipfile}
  ln -s -f AWSCloudFormation-1.0.12 AWSCloudFormation 
  EOH
  cwd installdir
  action :nothing
end
bash 'install AWS CLI tools' do
  code <<-EOH
  pip install awscli
  EOH
  not_if { ::File.exist?('/usr/local/bin/aws') }
end
