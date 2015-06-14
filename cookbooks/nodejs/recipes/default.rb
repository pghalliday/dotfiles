case node['platform']
when 'ubuntu'
  include_recipe 'nodejs::ubuntu'
when 'mac_os_x'
  include_recipe 'nodejs::mac_os_x'
end

n_installed = Mixlib::ShellOut.new('which n')
n_installed.run_command
bash 'install n' do
  code 'npm install -g n'
  only_if {n_installed.error?}
end

stable_installed = Mixlib::ShellOut.new('which n && n bin $(n --stable)')
stable_installed.run_command
bash 'install stable' do
  code 'n stable'
  only_if {stable_installed.error?}
end

latest_installed = Mixlib::ShellOut.new('which n && n bin $(n --latest)')
latest_installed.run_command
bash 'install latest' do
  code 'n latest'
  only_if {latest_installed.error?}
end
