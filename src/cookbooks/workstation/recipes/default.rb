workstation_user = node['workstation']['user']
workstation_group = node['workstation']['group']
workstation_home = node['workstation']['home']

workstation_cookbook = run_context.cookbook_collection[cookbook_name]
workstation_cookbook_files = workstation_cookbook.manifest['files']

# make sure apt repository  is up to date
include_recipe 'apt::default'

# install bash
include_recipe 'bash-config::default'
bash_config workstation_user do
  group workstation_group
  home workstation_home
end

# install nfs client stuff
package 'nfs-common'

# install Filezilla
package 'filezilla'

# install keepass2 for password management
package 'keepass2'

# install vim
include_recipe 'vim::default'
vim workstation_user do
  group workstation_group
  home workstation_home
end
%w{
elzr/vim-json
plasticboy/vim-markdown
scrooloose/nerdtree
tpope/vim-surround
kchmck/vim-coffee-script
mtscout6/vim-cjsx
ekalinin/Dockerfile.vim
vim-scripts/AutoComplPop
scrooloose/nerdcommenter
jistr/vim-nerdtree-tabs
}.each do |plugin|
  vim_plugin plugin do
    user workstation_user
    group workstation_group
    home workstation_home
  end
end
syntastic workstation_user do
  group workstation_group
  home workstation_home
end
base16_vim workstation_user do
  group workstation_group
  home workstation_home
end

# install tmux
include_recipe 'tmux::default'
tmux workstation_user do
  group workstation_group
  home workstation_home
end

# install tmuxomatic
include_recipe 'tmuxomatic::default'
workstation_cookbook_files.each do |entry|
  parent_directory = ::File.basename(::File.dirname(entry['path']))
  name = entry['name']
  if parent_directory.eql? 'tmuxomatic'
    tmuxomatic_config name do
      source "tmuxomatic/#{name}"
      user workstation_user
      group workstation_group
      home workstation_home
    end
  end
end

# install snx
include_recipe 'snx::default'
workstation_cookbook_files.each do |entry|
  parent_directory = ::File.basename(::File.dirname(entry['path']))
  name = entry['name']
  if parent_directory.eql? 'snx'
    snx_config name do
      source "snx/#{name}"
      user workstation_user
      group workstation_group
      home workstation_home
    end
  end
end

# install base16-shell
base16_shell workstation_user do
  group workstation_group
  home workstation_home
end

# install bash-git-prompt
bash_git_prompt workstation_user do
  group workstation_group
  home workstation_home
end

# install minicom
include_recipe 'minicom::default'
minicom workstation_user do
  group workstation_group
  home workstation_home
end

# install docker
include_recipe 'docker::default'
docker workstation_user

# install virtualbox
include_recipe 'virtualbox::default'

# install vagrant and plugins
include_recipe 'vagrant::default'
%w{
  vagrant-omnibus
  vagrant-berkshelf
}.each do |vagrant_plugin_name|
  vagrant_plugin vagrant_plugin_name do
    user workstation_user
    group workstation_group
  end
end

# install skype
include_recipe 'skype::default'

# install chrome
include_recipe 'chrome::default'
