workstation_user = node['workstation']['user']

# install keepass2 for password management
package 'keepass2'

# install vim (for gnome to enable clipboard integration)
package 'vim-gnome'

# install tmux
package 'tmux'

# install tmuxomatic
package 'python3'
package 'python3-pip'
bash 'install tmuxomatic' do
  code <<-EOH
rm -rf /tmp/pip-build-root/
pip3 install tmuxomatic --upgrade
EOH
  not_if {Mixlib::ShellOut.new('which tmuxomatic').run_command().status == 0}
end

# install minicom
package 'minicom'
group "dialout" do
  action :modify
  members workstation_user
  append true
end

# install docker
package 'apt-transport-https'
apt_repository 'docker' do
  uri 'https://get.docker.com/ubuntu'
  distribution 'docker'
  components ['main']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key '36A1D7869245C8950F966E92D8576A8BA88D21E9'
end
package 'lxc-docker'
group "docker" do
  action :modify
  members workstation_user
  append true
end

# install virtualbox
apt_repository 'virtualbox' do
  uri 'http://download.virtualbox.org/virtualbox/debian'
  distribution node['lsb']['codename']
  components ['contrib']
  key 'https://www.virtualbox.org/download/oracle_vbox.asc'
end
package 'virtualbox-4.3' do
  timeout 1800
end

# install vagrant and plugins
vagrant_deb = "#{Chef::Config[:file_cache_path]}/vagrant.deb"
remote_file vagrant_deb do
  source 'https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.deb'
  checksum '9d7f1c587134011e2d5429eb21b6c0e95487f52e6d6d47c03ecc82cbeee73968'
end
package 'vagrant' do
  source vagrant_deb
  provider Chef::Provider::Package::Dpkg
end
