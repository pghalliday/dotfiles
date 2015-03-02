package 'apt-transport-https'
apt_repository 'docker' do
  uri 'https://get.docker.com/ubuntu'
  distribution 'docker'
  components ['main']
  keyserver 'hkp://keyserver.ubuntu.com:80'
  key '36A1D7869245C8950F966E92D8576A8BA88D21E9'
end
package 'lxc-docker'

package 'python'
package 'python-pip'
fig_installed = Mixlib::ShellOut.new('which fig')
fig_installed.run_command
bash 'install fig' do
  code 'pip install -U fig'
  only_if {fig_installed.error?}
end
