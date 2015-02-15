def whyrun_supported?
  true
end

use_inline_resources

action :add do
  git_config 'user.name' do
    user new_resource.user
    value new_resource.user_name
  end
  git_config 'push.default' do
    user new_resource.user
    value 'simple'
  end
end
