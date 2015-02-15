def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  config_dir = "#{home}/.config"
  install_dir = "#{config_dir}/bash-git-prompt"
  bash_config_rc 'bash-git-prompt' do
    cookbook 'bash-git-prompt'
    source 'bash-git-prompt.sh'
    user new_resource.user
  end
  git install_dir do
    repository 'https://github.com/magicmonty/bash-git-prompt.git'
    user new_resource.user
    group group
  end
end
