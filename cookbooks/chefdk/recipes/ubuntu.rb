chefdk_deb = "#{Chef::Config[:file_cache_path]}/chefdk.deb"
remote_file chefdk_deb do
  source 'https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.6.2-1_amd64.deb'
  checksum 'e6990a3821590b999d09b707ff124fa891d44849cd63fd4f6f9db73bf5cb23f9'
end
package 'chefdk' do
  source chefdk_deb
  provider Chef::Provider::Package::Dpkg
end
