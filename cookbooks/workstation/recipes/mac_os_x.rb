workstation_user = node['workstation']['user']

# install bash
include_recipe 'bash'
bash_init workstation_user
bash_profile workstation_user

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
}.each do |plugin|
  vim_plugin plugin do
    user workstation_user
  end
end
syntastic workstation_user
vim_markdown workstation_user
base16_vim workstation_user

# install base16-shell
base16_shell workstation_user

# install bash-git-prompt
bash_git_prompt workstation_user
