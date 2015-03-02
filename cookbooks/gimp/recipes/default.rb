apt_repository 'gimp' do
  uri 'ppa:otto-kesselgulasch/gimp'
  distribution node['lsb']['codename']
end
package 'gimp'
