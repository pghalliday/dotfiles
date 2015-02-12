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
