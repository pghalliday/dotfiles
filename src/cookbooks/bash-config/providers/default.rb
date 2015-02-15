def whyrun_supported?
  true
end

use_inline_resources

action :add do
  bash_config_alias 'br' do
    command '. ~/.bashrc'
    user new_resource.user
    group new_resource.group
    home new_resource.home
  end
end
