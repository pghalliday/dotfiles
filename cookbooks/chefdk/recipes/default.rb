case node['platform']
when 'ubuntu'
  include_recipe 'chefdk::ubuntu'
when 'mac_os_x'
  include_recipe 'chefdk::mac_os_x'
end
gem_package 'knife-vsphere' do
  gem_binary '/opt/chefdk/embedded/bin/gem'
end
