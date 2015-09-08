def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  vim_plugin 'maksimr/vim-jsbeautify' do
    user new_resource.user
  end
  vim_config 'vim-jsbeautify' do
    cookbook 'vim-jsbeautify'
    source 'vim-jsbeautify.vim'
    user new_resource.user
  end
  cookbook_file ::File.join(home, '.editorconfig') do
    cookbook 'vim-jsbeautify'
    owner new_resource.user
    group group
  end
end
