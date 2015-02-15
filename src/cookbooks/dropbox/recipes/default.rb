dropbox_deb = "#{Chef::Config[:file_cache_path]}/dropbox.deb"
remote_file dropbox_deb do
  source 'https://linux.dropbox.com/packages/ubuntu/dropbox_1.6.2_amd64.deb'
  checksum '58f0340db9f03fb054eb6bc86598de194f7fce8bec2f4870a8d4065277b0cc38'
end
package 'dropbox' do
  source dropbox_deb
  provider Chef::Provider::Package::Dpkg
end
