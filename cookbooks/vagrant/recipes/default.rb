case node['platform']
when 'ubuntu'
  include_recipe 'vagrant::ubuntu'
when 'mac_os_x'
  include_recipe 'vagrant::mac_os_x'
end
