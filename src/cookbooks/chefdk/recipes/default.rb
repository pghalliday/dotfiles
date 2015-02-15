chefdk_deb = "#{Chef::Config[:file_cache_path]}/chefdk.deb"
remote_file chefdk_deb do
  source 'https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.4.0-1_amd64.deb'
  checksum 'e135c0719fc80fc7b95560e90839103167308a45d4927cf8da9c22bdc385cc7d'
end
package 'chefdk' do
  source chefdk_deb
  provider Chef::Provider::Package::Dpkg
end
