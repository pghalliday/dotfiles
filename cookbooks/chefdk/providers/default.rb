def whyrun_supported?
  true
end

use_inline_resources

action :add do
  bash_alias 'chefdk-init' do
    command 'eval "$(chef shell-init bash)"'
    user new_resource.user
  end
end
