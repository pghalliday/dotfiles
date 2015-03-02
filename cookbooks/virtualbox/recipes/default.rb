apt_repository 'virtualbox' do
  uri 'http://download.virtualbox.org/virtualbox/debian'
  distribution node['lsb']['codename']
  components ['contrib']
  key 'https://www.virtualbox.org/download/oracle_vbox.asc'
end
package 'virtualbox-4.3' do
  timeout 1800
end
