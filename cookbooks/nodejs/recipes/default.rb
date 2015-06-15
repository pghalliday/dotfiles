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

stable_io_installed = Mixlib::ShellOut.new('which n && n io bin $(n io --stable)')
stable_io_installed.run_command
bash 'install io stable' do
  code 'n io stable'
  only_if {stable_io_installed.error?}
end

latest_io_installed = Mixlib::ShellOut.new('which n && n io bin $(n io --latest)')
latest_io_installed.run_command
bash 'install io latest' do
  code 'n io latest'
  only_if {latest_io_installed.error?}
end
