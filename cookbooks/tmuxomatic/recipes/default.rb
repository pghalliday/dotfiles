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
