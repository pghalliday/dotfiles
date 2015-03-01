def whyrun_supported?
  true
end

use_inline_resources

action :install do
  vagrant_plugin_list_command = Mixlib::ShellOut.new(
    "su -l #{new_resource.user} vagrant plugin list",
  )
  vagrant_plugin_list_command.run_command()
  vagrant_plugin_list_command.error!
  installed_vagrant_plugins = vagrant_plugin_list_command.stdout
  if new_resource.license
    license_command = "su -l #{new_resource.user} vagrant plugin license #{new_resource.name} #{new_resource.license}"
  else
    license_command = ''
  end
  bash "vagrant plugin install #{new_resource.name}" do
    code <<-EOH
su -l #{new_resource.user} vagrant plugin install #{new_resource.name}
#{license_command}
EOH
    only_if { (/^#{new_resource.name} / =~ installed_vagrant_plugins).nil? }
  end
end
