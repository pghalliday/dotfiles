def whyrun_supported?
  true
end

use_inline_resources

action :add do
  bash_config_alias 'tmux' do
    command 'tmux -2'
    user new_resource.user
    group new_resource.group
    home new_resource.home
  end
  cookbook_file "#{new_resource.home}/.tmux.conf" do
    cookbook 'tmux'
    source '.tmux.conf'
    owner new_resource.user
    group new_resource.group
    mode 0644
  end
end
