apt_repository 'plex' do
  uri 'ppa:plexapp/plexht'
  distribution node['lsb']['codename']
  key 'EB7DFFFB'
  keyserver 'keyserver.ubuntu.com'
end
package 'plexhometheater'
