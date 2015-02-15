def whyrun_supported?
  true
end

use_inline_resources

action :add do
  vim_plugin 'chriskempson/base16-vim' do
    user new_resource.user
  end
  vim_config 'base16-vim' do
    cookbook 'base16-vim'
    source 'base16-vim.vim'
    user new_resource.user
  end
end
