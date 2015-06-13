case node['platform']
when 'ubuntu'
  include_recipe 'git::ubuntu'
when 'mac_os_x'
  include_recipe 'git::mac_os_x'
end
