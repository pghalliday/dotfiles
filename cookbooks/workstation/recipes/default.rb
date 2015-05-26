case node['platform']
when 'ubuntu'
  include_recipe 'workstation::ubuntu'
when 'mac_os_x'
  include_recipe 'workstation::mac_os_x'
end
