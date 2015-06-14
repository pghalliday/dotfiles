apt_repository 'nodejs' do
  uri          'https://deb.nodesource.com/node'
  distribution node['lsb']['codename']
  components   ['main']
  key          'https://deb.nodesource.com/gpgkey/nodesource.gpg.key'
end
package 'nodejs'
