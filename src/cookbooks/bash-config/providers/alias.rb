def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  config_dir = "#{home}/.bash-config"
  bash_aliasesd = "#{config_dir}/bash_aliases.d" 
  bash_aliasesdsh = "#{bash_aliasesd}/#{new_resource.name}.sh" 
  bash_config_rc '__aliases__' do
    cookbook 'bash-config'
    source 'aliases.sh'
    user new_resource.user
  end
  directory config_dir do
    owner new_resource.user
    group group
    mode 0755
  end
  directory bash_aliasesd do
    owner new_resource.user
    group group
    mode 0755
  end
  file bash_aliasesdsh do
    content <<-EOH
alias #{new_resource.name}="#{new_resource.command}"
EOH
    owner new_resource.user
    group group
    mode 0644
  end
end
