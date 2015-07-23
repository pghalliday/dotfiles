workstation_user = node['workstation']['user']
workstation_aws_s3_bucket = node['workstation']['aws_s3_bucket']
workstation_aws_access_key_id = node['workstation']['aws_access_key_id']
workstation_aws_secret_access_key = node['workstation']['aws_secret_access_key']

# install homebrew
include_recipe 'homebrew::default'
include_recipe 'homebrew::cask'

# setup ssh and keys
include_recipe 'ssh::default'
ssh workstation_user do
  aws_s3_bucket workstation_aws_s3_bucket
  aws_access_key_id workstation_aws_access_key_id
  aws_secret_access_key workstation_aws_secret_access_key
end

# install wget
package 'wget'

# install bash
include_recipe 'bash::default'
bash_init workstation_user
bash_profile workstation_user

# install git
include_recipe 'git::default'
git_init workstation_user do
  user_name 'Peter Halliday'
end

# install iterm2
homebrew_cask 'iterm2' do
  options '--appdir=/Applications'
end

# install chefdk
include_recipe 'chefdk::default'
chefdk workstation_user

# install nodejs
include_recipe 'nodejs::default'

# install python
include_recipe 'python::default'

# install AWS tools
include_recipe 'aws::default'
aws workstation_user

vim workstation_user
%w{
elzr/vim-json
scrooloose/nerdtree
tpope/vim-surround
kchmck/vim-coffee-script
mtscout6/vim-cjsx
ekalinin/Dockerfile.vim
vim-scripts/AutoComplPop
scrooloose/nerdcommenter
jistr/vim-nerdtree-tabs
rust-lang/rust.vim
cespare/vim-toml
groenewege/vim-less
nathanaelkane/vim-indent-guides
digitaltoad/vim-jade
}.each do |plugin|
  vim_plugin plugin do
    user workstation_user
  end
end
syntastic workstation_user
vim_markdown workstation_user
base16_vim workstation_user

# install tmux
include_recipe 'tmux::default'
tmux workstation_user

# install tmuxomatic
include_recipe 'tmuxomatic::default'

# install tmuxinator
include_recipe 'tmuxinator::default'
tmuxinator_init workstation_user

# install base16-shell
base16_shell workstation_user

# install bash-git-prompt
bash_git_prompt workstation_user

# install vagrant and plugins
include_recipe 'vagrant::default'
%w{
  vagrant-omnibus
  vagrant-berkshelf
  vagrant-aws
}.each do |vagrant_plugin_name|
  vagrant_plugin vagrant_plugin_name do
    user workstation_user
  end
end

# install virtualbox
include_recipe 'virtualbox::default'
virtualbox workstation_user

# checkout projects
development workstation_user

# set up libertyglobal projects
libertyglobal workstation_user

# set up Helios projects
helios workstation_user
