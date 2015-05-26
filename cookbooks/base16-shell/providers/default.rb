def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  config_dir = "#{home}/.config"
  directory config_dir do
    owner new_resource.user
    group group
  end
  install_dir = "#{config_dir}/base16-shell"
  bash_rc 'base16-shell' do
    cookbook 'base16-shell'
    source 'base16-shell.sh'
    user new_resource.user
  end
  git install_dir do
    repository 'https://github.com/chriskempson/base16-shell.git'
    user new_resource.user
    group group
  end
end
