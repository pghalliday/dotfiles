def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  install_dir = node['android-sdk']['install_dir']
  bash "create android avd #{new_resource.name}" do
    code <<-EOH
      #{install_dir}/current/tools/android create avd -n "#{new_resource.name}" -t "#{new_resource.target}" --skin "#{new_resource.skin}" --abi "#{new_resource.abi}"
      EOH
    user new_resource.user
    not_if { ::File.exist?(::File.join(home, '.android', 'avd', 'default.ini')) }
  end
end
