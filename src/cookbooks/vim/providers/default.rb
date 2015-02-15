def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  vimrc = "#{home}/.vimrc"
  vim_dir = "#{home}/.vim"
  vim_backup = "#{vim_dir}/backup"
  vim_swap = "#{vim_dir}/swap"
  vim_undo = "#{vim_dir}/undo"
  vim_autoload = "#{vim_dir}/autoload"
  vim_config = "#{vim_dir}/config.vim"
  pathogen = "#{vim_autoload}/pathogen.vim"
  directory vim_dir do
    owner new_resource.user
    group group
    mode 0755
  end
  directory vim_backup do
    owner new_resource.user
    group group
    mode 0755
  end
  directory vim_swap do
    owner new_resource.user
    group group
    mode 0755
  end
  directory vim_undo do
    owner new_resource.user
    group group
    mode 0755
  end
  directory vim_autoload do
    owner new_resource.user
    group group
    mode 0755
  end
  file vim_config do
    owner new_resource.user
    group group
    mode 0644
    action :create_if_missing
  end
  remote_file pathogen do
    source 'https://tpo.pe/pathogen.vim'
    owner new_resource.user
    group group
    mode 0644
  end
  cookbook_file vimrc do
    cookbook 'vim'
    source '.vimrc'
    owner new_resource.user
    group group
    mode 0644
  end
end
