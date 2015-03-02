def whyrun_supported?
  true
end

use_inline_resources

def load_current_resource
  code = <<-EOH
su -l #{new_resource.user} -c 'cd #{new_resource.project_path} && git status'
EOH
  @current_resource = Mixlib::ShellOut.new(code)
  @current_resource.run_command
end

action :add do
  name = "clone #{new_resource.repository} to #{new_resource.project_path} for user #{new_resource.user}"
  code = <<-EOH
su -l #{new_resource.user} -c 'git clone #{new_resource.repository} #{new_resource.project_path}'
EOH
  if @current_resource.error?
    bash name do
      code code
    end
  end
end
