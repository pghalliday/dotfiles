vagrant_deb = "#{Chef::Config[:file_cache_path]}/vagrant.deb"
remote_file vagrant_deb do
  source 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.deb'
  checksum '9d7f1c587134011e2d5429eb21b6c0e95487f52e6d6d47c03ecc82cbeee73968'
end
package 'vagrant' do
  source vagrant_deb
  provider Chef::Provider::Package::Dpkg
end
