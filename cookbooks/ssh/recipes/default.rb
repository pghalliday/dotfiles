case node['platform']
when 'ubuntu'
  include_recipe 'ssh::ubuntu'
when 'mac_os_x'
  include_recipe 'ssh::mac_os_x'
end
