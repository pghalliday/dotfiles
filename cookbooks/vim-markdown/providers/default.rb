def whyrun_supported?
  true
end

use_inline_resources

action :add do
  vim_plugin 'plasticboy/vim-markdown' do
    user new_resource.user
  end
  vim_config 'vim-markdown' do
    cookbook 'vim-markdown'
    source 'vim-markdown.vim'
    user new_resource.user
  end
end
