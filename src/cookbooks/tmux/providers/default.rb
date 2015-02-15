def whyrun_supported?
  true
end

use_inline_resources

action :add do
  home = ::Dir.home(new_resource.user)
  group = ::Etc.getpwnam(new_resource.user).gid
  bash_alias 'tmux' do
    command 'tmux -2'
    user new_resource.user
  end
  cookbook_file "#{home}/.tmux.conf" do
    cookbook 'tmux'
    source '.tmux.conf'
    owner new_resource.user
    group group
    mode 0644
  end
end
