def whyrun_supported?
  true
end

use_inline_resources

action :add do
  bash_rc 'tmuxinator' do
    cookbook 'tmuxinator'
    source 'tmuxinator.sh'
    user new_resource.user
  end
end
