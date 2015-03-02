def whyrun_supported?
  true
end

use_inline_resources

action :add do
  vim_plugin 'scrooloose/syntastic' do
    user new_resource.user
  end
  vim_config 'syntastic' do
    cookbook 'syntastic'
    source 'syntastic.vim'
    user new_resource.user
  end
end
