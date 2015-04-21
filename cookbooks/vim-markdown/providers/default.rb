def whyrun_supported?
  true
end

use_inline_resources

action :add do
  vim_plugin 'plasticboy/vim-markdown' do
    user new_resource.user
    revision '0da5ba9d719b818909d85bacdad2ce5d860c9e94'
  end
  vim_config 'vim-markdown' do
    cookbook 'vim-markdown'
    source 'vim-markdown.vim'
    user new_resource.user
  end
end
