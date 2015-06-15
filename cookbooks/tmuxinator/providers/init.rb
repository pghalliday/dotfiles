def whyrun_supported?
  true
end

use_inline_resources

action :add do
  bash_rc 'tmuxinator' do
    remote_file 'https://github.com/tmuxinator/tmuxinator/raw/master/completion/tmuxinator.bash'
    checksum 'f55d1bc4de4805eac80c71b92297b119b2c2cdcd175b290a2992ebf54fb04fba'
    user new_resource.user
  end
end
