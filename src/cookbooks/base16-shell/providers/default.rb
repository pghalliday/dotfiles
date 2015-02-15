def whyrun_supported?
  true
end

use_inline_resources

action :add do
  config_dir = "#{new_resource.home}/.config"
  install_dir = "#{config_dir}/base16-shell"
  bash_config_rc 'base16-shell' do
    cookbook 'base16-shell'
    source 'base16-shell.sh'
    user new_resource.user
    group new_resource.group
    home new_resource.home
  end
  git install_dir do
    repository 'https://github.com/chriskempson/base16-shell.git'
    user new_resource.user
    group new_resource.group
  end
end
