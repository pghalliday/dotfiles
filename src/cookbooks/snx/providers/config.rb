def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  snx_dir = "#{home}/.snx_cookbook"
  snx_config = "#{snx_dir}/#{new_resource.name}"
  directory snx_dir do
    owner new_resource.user
    recursive true
    mode 0755
  end
  cookbook_file snx_config do
    cookbook new_resource.cookbook
    source new_resource.source
    owner new_resource.user
    mode 0644
  end
  bash_config_alias "snx.#{new_resource.name}" do
    command "snx -f #{snx_config}"
    user new_resource.user
  end
end
