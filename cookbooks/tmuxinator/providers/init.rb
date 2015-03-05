def whyrun_supported?
  true
end

use_inline_resources

action :add do
  bash_rc 'tmuxinator' do
    remote_file 'https://github.com/tmuxinator/tmuxinator/raw/master/completion/tmuxinator.bash'
    checksum '10d30dfa98d34c5f209f24c0931955e6909ba148743e83d9ffe3fe3ceaf9c1e2'
    user new_resource.user
  end
end
