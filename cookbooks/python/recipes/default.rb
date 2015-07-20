package 'python'
case node['platform']
when 'ubuntu'
  include_recipe 'python::ubuntu'
end
