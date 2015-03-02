def whyrun_supported?
  true
end

use_inline_resources

def load_current_resource
  if new_resource.project_path.nil?
    code = <<-EOH
su -l #{new_resource.user} -c 'git config --global #{new_resource.property}'
EOH
  else
    code = <<-EOH
su -l #{new_resource.user} -c 'cd #{new_resource.project_path} && git config --local #{new_resource.property}'
EOH
  end
  @current_resource = Mixlib::ShellOut.new(code)
  @current_resource.run_command
end

action :set do
  if new_resource.project_path.nil?
    name = "set #{new_resource.property} to \"#{new_resource.value}\" globally for user #{new_resource.user}"
    code = <<-EOH
su -l #{new_resource.user} -c 'git config --global #{new_resource.property} "#{new_resource.value}"'
EOH
  else
    name = "set #{new_resource.property} to \"#{new_resource.value}\" locally for #{new_resource.project_path} for user #{new_resource.user}"
    code = <<-EOH
su -l #{new_resource.user} -c 'cd #{new_resource.project_path} && git config --local #{new_resource.property} "#{new_resource.value}"'
EOH
  end
  if @current_resource.error? or !@current_resource.stdout.chomp.eql? new_resource.value
    bash name do
      code code
    end
  end
end
