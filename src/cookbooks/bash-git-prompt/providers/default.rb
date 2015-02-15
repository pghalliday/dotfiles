def whyrun_supported?
  true
end

use_inline_resources

action :add do
  config_dir = "#{new_resource.home}/.config"
  install_dir = "#{config_dir}/bash-git-prompt"
  bash_config_rc 'bash-git-prompt' do
    cookbook 'bash-git-prompt'
    source 'bash-git-prompt.sh'
    user new_resource.user
    group new_resource.group
    home new_resource.home
  end
  git install_dir do
    repository 'https://github.com/magicmonty/bash-git-prompt.git'
    user new_resource.user
    group new_resource.group
  end
end
