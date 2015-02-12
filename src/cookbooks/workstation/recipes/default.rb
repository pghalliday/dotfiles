package 'vim-gnome'
package 'tmux'
package 'keepass2'
package 'python3'
package 'python3-pip'

bash 'install tmuxomatic' do
  code <<-EOH
rm -rf /tmp/pip-build-root/
pip3 install tmuxomatic --upgrade
EOH
  not_if {Mixlib::ShellOut.new('which tmuxomatic').run_command().status == 0}
end

apt_repository "docker" do
  uri "https://get.docker.com/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "36A1D7869245C8950F966E92D8576A8BA88D21E9"
end

package 'lxc-docker'
