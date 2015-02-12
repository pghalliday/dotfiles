workstation_user = node['workstation']['user']
workstation_group = node['workstation']['group']

# install keepass2 for password management
package 'keepass2'

# install vim (for gnome to enable clipboard integration)
package 'vim-gnome'

# install tmux
package 'tmux'

# install tmuxomatic
%w{
  python3
  python3-pip
}.each do |package_name|
  package package_name
end
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
vagrant_plugin_list_command = Mixlib::ShellOut.new(
  'vagrant plugin list',
  user: workstation_user,
  group: workstation_group
)
vagrant_plugin_list_command.run_command()
vagrant_plugin_list_command.error!
installed_vagrant_plugins = vagrant_plugin_list_command.stdout
%w{
  vagrant-omnibus
  vagrant-berkshelf
}.each do |vagrant_plugin_name|
  bash "vagrant plugin install #{vagrant_plugin_name}" do
    user workstation_user
    group workstation_group
    code <<-EOH
vagrant plugin install #{vagrant_plugin_name}
EOH
    only_if { (/^#{vagrant_plugin_name} / =~ installed_vagrant_plugins).nil? }
  end
end

# install snx client
%w{
  libpam0g:i386
  libstdc++5:i386
  libx11-6:i386
}.each do |package_name|
  package package_name
end
snx_install_script = "#{Chef::Config[:file_cache_path]}/snx_install.sh"
remote_file snx_install_script do
  source 'http://vpn.upclabs.com/download/linux-vpn-cli.sh'
  checksum '9ecba22bc3853e17b59e06860f783da084aff1e1c73827f3746e5a67d3918c08'
  mode 0700
  notifies :run, "bash[install snx]", :immediately
end
bash 'install snx' do
  code <<-EOH
#{snx_install_script}
EOH
  action :nothing
end
