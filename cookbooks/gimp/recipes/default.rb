apt_repository 'gimp' do
  uri 'ppa:otto-kesselgulasch/gimp'
  distribution node['lsb']['codename']
  key '614C4B38'
  keyserver 'keyserver.ubuntu.com'
end
package 'gimp'
