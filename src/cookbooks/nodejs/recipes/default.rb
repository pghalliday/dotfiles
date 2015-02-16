apt_repository 'nodejs' do
  uri          'https://deb.nodesource.com/node'
  distribution node['lsb']['codename']
  components   ['main']
  key          'https://deb.nodesource.com/gpgkey/nodesource.gpg.key'
end
package 'nodejs'

n_installed = Mixlib::ShellOut.new('npm ls -g n')
n_installed.run_command
bash 'install n' do
  code 'npm install -g n'
  only_if {n_installed.error?}
end

stable_installed = Mixlib::ShellOut.new('n bin $(n --stable)')
stable_installed.run_command
bash 'install stable' do
  code 'n stable'
  only_if {stable_installed.error?}
end

latest_installed = Mixlib::ShellOut.new('n bin $(n --latest)')
latest_installed.run_command
bash 'install latest' do
  code 'n latest'
  only_if {latest_installed.error?}
end
